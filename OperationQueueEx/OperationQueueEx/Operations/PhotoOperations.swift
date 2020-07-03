//
//  File.swift
//  OperationQueueEx
//
//  Created by Ness Bautista on 02/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import UIKit
enum PhotoRecordState {
    case new
    case downloaded
    case filtered
    case failed
}

struct PhotoRecord {
    let name: String
    let url: URL
    var state = PhotoRecordState.new
    public var image = UIImage(named:"Placeholder")
    mutating func updateImage(image:UIImage){
        self.image = image
    }
    mutating func updateState(_ state:PhotoRecordState){
        self.state = state
    }
    init(name:String, url: URL, image:UIImage = UIImage(named:"Placeholder")!, state:PhotoRecordState = .new) {
        self.name = name
        self.url = url
        self.image = image
        self.state = state
    }
}

class PendingOperations {
    lazy var downloadsInProgress: [IndexPath:Operation] = [:]
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Download queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    lazy var filtrationsInProgress: [IndexPath:Operation] = [:]
    lazy var filtrationQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Image Filtration queue"
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
}

class ImageDownloader:Operation {
    var photoRecord:PhotoRecord
    
    init(_ photoRecord: PhotoRecord){
        self.photoRecord = photoRecord
    }
    override func main() {
        if isCancelled {
            return
        }
        
        guard let imageData = try? Data(contentsOf: photoRecord.url) else {return}
        
        if !imageData.isEmpty {
            self.photoRecord.updateImage(image: UIImage(data:imageData)!)
            self.photoRecord.updateState(.downloaded)
            //self.photoRecord.image = UIImage(data:imageData)
            //self.photoRecord.state = .downloaded
        } else {
            self.photoRecord.updateImage(image: UIImage(named:"Failed")!)
            self.photoRecord.updateState(.failed)
            //self.photoRecord.image = UIImage(named:"Failed")
            //self.photoRecord.state = .failed
        }
    }
}

class ImageFiltration:Operation {
    
    var photoRecord:PhotoRecord
    
    init(_ photoRecord: PhotoRecord){
        self.photoRecord = photoRecord
    }
    
    override func main() {
        if isCancelled {
            return
        }
        guard self.photoRecord.state == .downloaded else {return}
        
        if let image = photoRecord.image, let filteredImage = self.applySepiaFilter(image) {
            self.photoRecord.updateImage(image: filteredImage)
            self.photoRecord.updateState(.filtered)
//            self.photoRecord.image = filteredImage
//            self.photoRecord.state = .filtered
        }
    }
    
    private func applySepiaFilter(_ image: UIImage) -> UIImage? {
        guard let data = image.pngData() else { return nil }
      let inputImage = CIImage(data: data)
          
      if isCancelled {
        return nil
      }
          
      let context = CIContext(options: nil)
          
      guard let filter = CIFilter(name: "CISepiaTone") else { return nil }
      filter.setValue(inputImage, forKey: kCIInputImageKey)
      filter.setValue(0.8, forKey: "inputIntensity")
          
      if isCancelled {
        return nil
      }
          
      guard
        let outputImage = filter.outputImage,
        let outImage = context.createCGImage(outputImage, from: outputImage.extent)
      else {
        return nil
      }

      return UIImage(cgImage: outImage)
    }
}
