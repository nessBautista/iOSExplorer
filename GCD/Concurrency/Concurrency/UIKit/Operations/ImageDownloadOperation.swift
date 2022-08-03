//
//  ImageDownloadOperation.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 13/07/22.
//

import Foundation
import UIKit
final class ImageDownloadOperation: AsyncOperation {
	var image: UIImage?
	private let url: URL
	private let completionHandler:((Data?, URLResponse?, Error?) -> Void)?
	
	init(url: URL, completionHandler: ((Data?, URLResponse?, Error?) -> Void)? = nil){
		self.url = url
		self.completionHandler = completionHandler
		super.init()
	}
	
	convenience init?(string: String, completionHandler: ((Data?, URLResponse?, Error?) -> Void)? = nil){
		guard let url = URL(string: string) else {
			return nil
		}
		self.init(url: url, completionHandler: completionHandler)
	}
	
	override func main() {
		URLSession.shared.dataTask(with: self.url) { [weak self] data, response, error in
			guard let sSelf = self else { return }
			defer{sSelf.state = .finished}
			
			if let completionHandler = sSelf.completionHandler {
				completionHandler(data, response, error)
			}
			
			guard error == nil, let data = data else {
				return
			}
			sSelf.image = UIImage(data:data)
			
		}.resume()
	}
}
extension ImageDownloadOperation: ImageDataProvider {}
protocol ImageDataProvider {
  var image: UIImage? { get }
}
