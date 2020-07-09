//
//  ImageDownloadOperation.swift
//  UnsplashClient
//
//  Created by Ness Bautista on 09/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import UIKit

class PendingOperations {
    lazy var downloadsInProgress: [IndexPath:Operation] = [:]
    lazy var downloadQueue:OperationQueue = {
        var queue = OperationQueue()
        queue.name = "Image download queue"
        queue.maxConcurrentOperationCount = 10
        return queue
    }()
    func getOperation(at: IndexPath)-> Operation?{
        return downloadsInProgress[at]
    }
    
    func cancelOperations(for indexPaths:[IndexPath]){
        for idx in indexPaths{
            self.downloadsInProgress[idx]?.cancel()
        }
    }
}

class ImageDownloadOperation:Operation {
    var photoRecord: PhotoVM
    
    init(_ photoRecord: PhotoVM){
        self.photoRecord = photoRecord
    }
    
    override func main() {
        guard !isCancelled else { return }
        guard let url = photoRecord.thumbURL,
            let imageData = try? Data(contentsOf: url) else {return}
        
        if imageData.isEmpty == false {
            self.photoRecord.thumbImg = UIImage(data:imageData)!
            self.photoRecord.state = .downloaded
        } else {
            self.photoRecord.thumbImg = UIImage(named:"Failed")!
            self.photoRecord.state = .failed
        }
    }
        
}
