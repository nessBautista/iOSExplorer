//
//  File.swift
//  
//
//  Created by Nestor Hernandez on 08/01/21.
//

import XCTest
import MyLibrary

class FloatingPointTestCase: XCTestCase {
    func test_isInteger() {
        XCTAssertTrue(1.0.isInteger)
        XCTAssertFalse((1.2 as CGFloat).isInteger)
    }
    
    
}
