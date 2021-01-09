//
//  File.swift
//  
//
//  Created by Nestor Hernandez on 08/01/21.
//

import XCTest
import MyLibrary

final class SequenceTestCase:XCTestCase {
    func test_odds(){
        let odds = stride(from: 1, through: 9, by: 2)
        XCTAssertEqual(Array(odds), [1, 3,5,7,9])
    }
    
    func test_first_of_stride(){
        let odds = stride(from: 1, through: 9, by: 2)
        XCTAssertEqual(1, odds.first)
        
        //Test for NIl
        XCTAssertNil(odds.prefix(0).first)
    }
    
    func test_sum() {
        let threeTwoOne = stride(from:3, through: 1, by: -1)
        XCTAssertEqual(threeTwoOne.sum, 6)
        XCTAssertEqual([0.5,1.0,1.5].sum, 3.0)
        XCTAssertNil(Set<CGFloat>().sum)
    }
}
