//
//  CombineOperations.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 14/07/22.
//

import Foundation
import UIKit
import Combine

class CombineImageDownloader {
	let input: URL
	@Published var output:UIImage? = nil
	let defaultImage = UIImage(named: "mountains")!
	
	init(input: URL){
		self.input = input
		self.downloadImage(url: self.input)
			.assign(to: &self.$output)
			
	}
	
	func downloadImage(url: URL)-> AnyPublisher<UIImage?, Never>{
		URLSession.shared.dataTaskPublisher(for: self.input)
			.map { (data, response) -> UIImage? in
				guard let response = response as? HTTPURLResponse,
					  response.statusCode == 200  else {
						  return self.defaultImage
				}
				return UIImage(data: data)
			}
			.replaceError(with: self.defaultImage)
			.eraseToAnyPublisher()
	}

}

class CombineImageTiltShifter{
	let input:UIImage
	@Published var output:UIImage? = nil
	let defaultImage = UIImage(named: "mountains")!
	private let context = CIContext()
	
	init(input:UIImage){
		self.input = input
		self.getFilterPublisher()
			.assign(to: &self.$output)
	}
	
	func getFilterPublisher()->AnyPublisher<UIImage?, Never>{
		Future<UIImage?, Never>{ promise in
			let filteredImage =  self.applyTiltShiftFilter(self.input)
			promise(.success(filteredImage))
		}.eraseToAnyPublisher()
	}
	
	func applyTiltShiftFilter(_ inputImage: UIImage)-> UIImage {
		// Create filter and get CIImage
		guard let filter = TiltShiftFilter(image: inputImage),
			  let ciimage = filter.outputImage else {
				  return self.defaultImage
			  }
		// from CIImage to CGImage
		let frame = CGRect(origin: .zero, size: inputImage.size)
		guard let cgimage = self.context.createCGImage(ciimage, from: frame) else {
			return defaultImage
		}
		
		return UIImage(cgImage: cgimage)
	}
}
