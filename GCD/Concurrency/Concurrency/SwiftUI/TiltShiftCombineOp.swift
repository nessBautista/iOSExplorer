//
//  TiltShiftCombineOp.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 13/07/22.
//

import Foundation
import UIKit
import SwiftUI
import Combine
enum FilterError: Error {
	case emptyData
	case renderError
	case filterError
}

class TiltShiftCombineOp: ObservableObject{
	var inputImage: UIImage
	@Published var outputImage: Image? = nil
	static let context = CIContext()
		
	init(inputImage: UIImage){
		self.inputImage = inputImage
		self.performTiltShiftFilter(inputImage)			
			.assign(to: &self.$outputImage)
		
	}
	
	func performTiltShiftFilter(_ rawImage: UIImage)
		 -> AnyPublisher<Image?, Never> {
		Future{ promise in
			if Thread.isMainThread {
				print("performTiltShiftFilter in main")
			}
			let filter = TiltShiftFilter(image: rawImage)
			
			// filter from UIImage to CIImage
			guard let ciimage = filter?.outputImage else {
				//promise(.failure(.filterError))
				print("filter error")
				return
			}
			// from CIImage to CGImage
			let frame = CGRect(origin: .zero, size: rawImage.size)
			guard let cgimage = TiltShiftCombineOp.context.createCGImage(ciimage, from: frame) else {
				//promise(.failure(.renderError))
				print("render error")
				return
			}
			// from CGImage to UIImage to Image
			let finalImage = Image(uiImage: UIImage(cgImage: cgimage))
			promise(.success(finalImage))
		}
		.eraseToAnyPublisher()
	}
}


