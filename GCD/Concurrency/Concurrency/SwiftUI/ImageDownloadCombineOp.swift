//
//  ImageDownloadCombineOp.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 13/07/22.
//

import Foundation
import SwiftUI
import Combine
enum DemoError: Error {
	case networkError
	case noData
}

class ImageDownloadCombineOp: ObservableObject{
	@Published var outputImage:UIImage?
	private(set) var subscriptions = Set<AnyCancellable>()
	let url: URL
		
	init(url: URL){
		self.url = url
		self.fetchImage()
	}
	
	func fetchImage(){
		let netPublisher = URLSession.shared.dataTaskPublisher(for: self.url)
		netPublisher
			.subscribe(on: DispatchQueue.global())
			.tryMap { (data, response) -> UIImage in
			guard let response = response as? HTTPURLResponse,
			response.statusCode == 200 else {
				print("Error status code")
				throw DemoError.networkError
			}
			guard let downloadedImage = UIImage(data: data) else {
				print("Error constructing UIImage")
				throw DemoError.noData
			}
				if Thread.isMainThread {
					print("NetworkDownloader in main")
				}
			return downloadedImage
		}
		.replaceError(with: nil)
		.assign(to: &self.$outputImage)
	}
}

