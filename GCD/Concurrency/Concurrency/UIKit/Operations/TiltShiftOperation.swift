//
//  TiltShiftOperation.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 13/07/22.
//

import Foundation
import UIKit

class TiltShiftOperation: Operation {
	var input: UIImage?
	var output: UIImage?
	private static let context = CIContext()
	
	init(_ input: UIImage? = nil){
		self.input = input
	}
	
	override func main() {
		// Perform calculations here
		guard let processedImage = self.performFilteringTask() else {
			return
		}
		// Assign to output
		self.output = processedImage
	}
	
	private func performFilteringTask()->UIImage?{
		// Extract image from dependency
		let dependencyImage = dependencies
		  .compactMap { ($0 as? ImageDataProvider)?.image }
		  .first
		self.input = dependencyImage
		guard let inputImage = self.input else {
			print("Operation Failed: not input image")
			return nil
		}
		
		//filteredImage: CIImage
		let filter = TiltShiftFilter(image: inputImage)
		guard let filteredImage = filter?.outputImage else {
			print("Operation Failed")
			return nil
		}
		// from CIImage from CGImage to UIImage
		let frame = CGRect(origin: .zero, size: inputImage.size)
		guard let cgImage = TiltShiftOperation.context
							.createCGImage(filteredImage, from: frame),
		let renderedImage = cgImage.rendered() else {
			print("Operation Failed")
			return nil
		}
		let finalImage = UIImage(cgImage: renderedImage)
		return finalImage
	}
}

extension CGImage {
  func rendered()-> CGImage? {
	guard let colorSpace = self.colorSpace else {
	  return nil
	}
	
	guard let context = CGContext(
	  data: nil,
	  width: width,
	  height: height,
	  bitsPerComponent: bitsPerComponent,
	  bytesPerRow: bytesPerRow,
	  space: colorSpace,
	  bitmapInfo: bitmapInfo.rawValue)
	  else {
		return nil
	}
	
	let rect = CGRect(x: 0, y: 0, width: width, height: height)
	context.draw(self, in: rect)
	return context.makeImage()
  }
}
