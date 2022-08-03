//
//  CombineOpsViewModel.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 13/07/22.
//

import Foundation
import UIKit
import Combine
import SwiftUI

class CombineOpsViewModel: ObservableObject {
	let urlProvider: URLProvider
	var data:[DemoItem02] = []
	private let defaultImage = UIImage(named: "mountains")!
	
	init(urlProvider: URLProvider = URLProvider()){
		self.urlProvider = urlProvider
		self.data = self.urlProvider.urls
					.map({DemoItem02(imageURL: $0, rawImage: nil)})
	}
}

class ImageCellViewModel: ObservableObject {
	@Published var image: Image?
	let url: URL
	private var subscriptions = Set<AnyCancellable>()
	deinit{
		print("deinit: \(url.path)")
	}
	
	init(url: URL){
		self.url = url
		let downloaderPublisher = ImageDownloadCombineOp(url: url).$outputImage
		let filterPublisher = downloaderPublisher
							.map{
								TiltShiftCombineOp(inputImage: $0 ?? UIImage(named:"mountains")!)
								.$outputImage
							}
		Publishers.Zip(downloaderPublisher, filterPublisher)
			.subscribe(on: DispatchQueue.global())
		  .sink(receiveValue: {
			  $1.receive(on: RunLoop.main)
				  .assign(to: &self.$image)
		  }).store(in: &subscriptions)
		
	}
}
