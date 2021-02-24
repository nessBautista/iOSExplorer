//
//  ImageViewModel.swift
//  CombineUtils
//
//  Created by Nestor Hernandez on 08/02/21.
//

import UIKit
import Combine

enum DownloadStatus {
    case none
    case pending
    case downloaded
}
class ImageViewModel: Hashable {
    
    static func == (lhs: ImageViewModel, rhs: ImageViewModel) -> Bool {
        lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    private let identifier = UUID()
    let url: URL
    @Published var image: UIImage? = UIImage(imageLiteralResourceName: "1")
    let imageSubject = CurrentValueSubject<UIImage, Never>(UIImage(imageLiteralResourceName: "1"))
    private let defaultImage = UIImage(imageLiteralResourceName: "1")
    var downloadStatus: DownloadStatus = .none
    var subscriptions = Set<AnyCancellable>()
    
    init(url:URL) {
        self.url = url
    }
    
    init(strUrl:String) {
        self.url = URL(string: strUrl)!
    }
    
    func testFetch(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.image = self.defaultImage
        }
        
    }
    func fetchImage() {
        let urlSession = URLSession.shared
        
        // Download Publisher
        let downloadPub = urlSession.dataTaskPublisher(for: self.url)
            .map({UIImage(data:$0.data)})
            .replaceError(with: defaultImage)
        
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
                            self.image = $0 ?? self.defaultImage
                            self.imageSubject.send($0 ?? self.defaultImage)                            
                    })
                    .store(in: &self.subscriptions)
            })
            .store(in: &self.subscriptions)
    }
}
