//
//  BasicGridViewModel.swift
//  CombineUtils
//
//  Created by Nestor Hernandez on 12/02/21.
//

import Foundation
import UIKit
import Combine
class BasicGridViewModel: ObservableObject {
    @Published var imageModels: [ImageModel] = []
    @Published var imageViewModels: [ImageViewModel] = []
    let defaultImage = UIImage(imageLiteralResourceName: "3")
    var operationsInProgress:Set<Int> = []
    var subscriptions = Set<AnyCancellable>()
    var subscriptionsDictionary : [Int: [AnyCancellable]] = [:]
    private lazy var mountains: [Mountain] = {
        return generateMountains()
    }()
        
}

//MARK:- Basic Grid 02
extension BasicGridViewModel {
    class ImageViewModel: Hashable, ObservableObject {
        let title: String
        var url: URL
        @Published var image: UIImage?
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        static func == (lhs: ImageViewModel, rhs: ImageViewModel) -> Bool {
            
            return (lhs.identifier == rhs.identifier)
        }
        
        init(url: URL, image: UIImage? = nil) {
            self.url = url
            self.title = url.lastPathComponent
            self.image = image
        }
    }
    
    func buildImageViewModels() {
        //Extrac urls from plist file
        guard let plist = Bundle.main.url(forResource: "Photos", withExtension: "plist"),
              let contents = try? Data(contentsOf: plist),
              let serial = try? PropertyListSerialization.propertyList(from: contents, format: nil),
              let serialUrls = serial as? [String] else {
          print("Something went horribly wrong!")
          return
        }
        var models: [ImageViewModel] = []
        for urlStr in serialUrls {
            if let url = URL(string: urlStr) {
                models.append(ImageViewModel(url: url))
            }
        }
        self.imageViewModels = models
    }
    
    func fetchImage02(for idx: Int) {
        
        // Check if image is not downloaded
        let model = self.imageViewModels[idx]
        guard model.image == nil else { return }
        // Check if operation is not already in progress
        guard self.operationsInProgress.contains(idx) == false else { return }
        
        //Register operation
        print("--->RequestImageFor:\(idx)")
        self.operationsInProgress.insert(idx)
                
        
        let urlSession = URLSession.shared
        // Download Publisher
        let downloadPub = urlSession.dataTaskPublisher(for: model.url)
            .map({UIImage(data:$0.data)})
            .replaceError(with: nil)
        
        // Link result of download operation to the Filter Operation
        let filterPub = downloadPub
            .map({
                TiltShiftOperation(
                        inputImage:$0 ?? self.defaultImage
                )
                .$outputImage
            })
        
        //ZIP the result of previous publisher
        /// Use Publishers.Zip to combine the latest elements from two publishers and emit a tuple to the downstream. The returned publisher waits until both publishers have emitted an event, then delivers the oldest unconsumed event from each publisher together as a tuple to the subscriber.  Much like a zipper or zip fastener on a piece of clothing pulls together rows of teeth to link the two sides, Publishers.Zip combines streams from two different publishers by linking pairs of elements from each side. If either upstream publisher finishes successfully or fails with an error, so too does the zipped publisher.
        Publishers.Zip(downloadPub, filterPub)
            .receive(on: RunLoop.main)
            .sink(receiveValue: {
                $1.receive(on: RunLoop.main)
                    .sink(receiveValue: {
                        self.imageViewModels[idx].image = $0
                        self.operationsInProgress.remove(idx)
                    })
                    .store(in: &self.subscriptions)                
            })
            .store(in: &self.subscriptions)
    }
    
}
//MARK:- Basic Grid
extension BasicGridViewModel {
    struct ImageModel: Hashable {
        let title: String
        var url: URL
        var image: UIImage?
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        static func == (lhs: ImageModel, rhs: ImageModel) -> Bool {
            
            return (lhs.identifier == rhs.identifier)
        }
        
        init(url: URL, image: UIImage? = nil) {
            self.url = url
            self.title = url.lastPathComponent
            self.image = image
        }
    }
    
    func buildImageModels() {
        //Extrac urls from plist file
        guard let plist = Bundle.main.url(forResource: "Photos", withExtension: "plist"),
              let contents = try? Data(contentsOf: plist),
              let serial = try? PropertyListSerialization.propertyList(from: contents, format: nil),
              let serialUrls = serial as? [String] else {
          print("Something went horribly wrong!")
          return
        }
        var models: [ImageModel] = []
        for urlStr in serialUrls {
            if let url = URL(string: urlStr) {
                models.append(ImageModel(url: url))
            }
        }
        self.imageModels = models
    }
    
    func fetchImage(for idx: Int) {
        
        // Check if image is not downloaded
        let model = self.imageModels[idx]
        guard model.image == nil else { return }
        // Check if operation is not already in progress
        guard self.operationsInProgress.contains(idx) == false else { return }
        
        //Register operation
        print("--->RequestImageFor:\(idx)")
        self.operationsInProgress.insert(idx)
                
        
        let urlSession = URLSession.shared
        // Download Publisher
        let downloadPub = urlSession.dataTaskPublisher(for: model.url)
            .map({UIImage(data:$0.data)})
            .replaceError(with: nil)
        
        // Link result of download operation to the Filter Operation
        let filterPub = downloadPub
            .map({
                TiltShiftOperation(
                        inputImage:$0 ?? self.defaultImage
                )
                .$outputImage
            })
        
        //ZIP the result of previous publisher
        /// Use Publishers.Zip to combine the latest elements from two publishers and emit a tuple to the downstream. The returned publisher waits until both publishers have emitted an event, then delivers the oldest unconsumed event from each publisher together as a tuple to the subscriber.  Much like a zipper or zip fastener on a piece of clothing pulls together rows of teeth to link the two sides, Publishers.Zip combines streams from two different publishers by linking pairs of elements from each side. If either upstream publisher finishes successfully or fails with an error, so too does the zipped publisher.
        Publishers.Zip(downloadPub, filterPub)
            .receive(on: RunLoop.main)
            .sink(receiveValue: {
                $1.receive(on: RunLoop.main)
                    .sink(receiveValue: {
                        let model = ImageModel(url: model.url, image: $0)
                        self.imageModels[idx] = model

                        self.operationsInProgress.remove(idx)
                    })
                    .store(in: &self.subscriptions)
                //self.registerOperation(idx: idx, subscription: sub)
            })
            .store(in: &self.subscriptions)
        //self.registerOperation(idx: idx, subscription: sub)
    }
    
    func registerOperation(idx:Int, subscription: AnyCancellable) {
        if self.subscriptionsDictionary[idx] == nil {
            self.subscriptionsDictionary[idx] = [subscription]
        } else {
            self.subscriptionsDictionary[idx]?.append(subscription)
        }
    }
    
    func cancelOperation(for idx:Int){
        self.operationsInProgress.remove(idx)
        self.subscriptionsDictionary[idx]?.forEach({$0.cancel()})
        self.subscriptionsDictionary[idx] = nil
        
    }
    
}
//MARK:- Mountain examples
extension BasicGridViewModel {
    
    struct Mountain: Hashable {
        var name: String
        let height: Int
        let identifier = UUID()
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        static func == (lhs: Mountain, rhs: Mountain) -> Bool {
            return lhs.identifier == rhs.identifier
        }
        func contains(_ filter: String?) -> Bool {
            guard let filterText = filter else { return true }
            if filterText.isEmpty { return true }
            let lowercasedFilter = filterText.lowercased()
            return name.lowercased().contains(lowercasedFilter)
        }
    }
    
    func filteredMountains(with filter: String?=nil, limit: Int?=nil) -> [Mountain] {
        let filtered = mountains.filter { $0.contains(filter) }
        if let limit = limit {
            return Array(filtered.prefix(through: limit))
        } else {
            return filtered
        }
    }
    
    
    
    private func generateMountains() -> [Mountain] {
        let components = mountainsRawData.components(separatedBy: CharacterSet.newlines)
        var mountains = [Mountain]()
        for line in components {
            let mountainComponents = line.components(separatedBy: ",")
            let name = mountainComponents[0]
            let height = Int(mountainComponents[1])
            mountains.append(Mountain(name: name, height: height!))
        }
        return mountains
    }
}
