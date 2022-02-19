//
//  File.swift
//  
//
//  Created by Nestor Hernandez on 20/01/21.
//
import XCTest
import Foundation
import MyLibrary
import CoreGraphics

final class CGImageExtensionTest: XCTestCase {
    /** This function will test the downsizing function added as extensions of Data.
     
     */
    func testImageDownsize() {
        //Create an CGImage to use as reference to compare
        //This is PNG image of size: 850x638
        guard let url =  Bundle.module.url(forResource: "nature", withExtension: "png"),
           let pngData: CGDataProvider = try? CGDataProvider(data: Data(contentsOf: url) as CFData)
        else {
            XCTFail("Original PNG resource was not found")
            return
        }
        let image = CGImage.init(pngDataProviderSource: pngData,
                                 decode: nil,
                                 shouldInterpolate: true,
                                 intent: .defaultIntent)
        //Get Original image Data information
        let originalData = image?.png
        let originalDataCount = image?.png?.count ?? 0
        
        //Apply Downsize of 300x300
        if let dataDownsized = originalData?.downSizeImage(width: 300, height: 300) {
            let afterDownsize = dataDownsized.count
            XCTAssertLessThan(afterDownsize, originalDataCount)
        }
        
        if let dataResized = originalData?.resizedImage(width: 300, height: 300) {
            let afterResized  = dataResized.count
            XCTAssertLessThan(afterResized, originalDataCount)
        }
        
    }
}
