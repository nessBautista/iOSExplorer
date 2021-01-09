//
//  File.swift
//  
//
//  Created by Nestor Hernandez on 08/01/21.
//

import XCTest
@testable import MyLibrary

final class StorageTestCase: XCTestCase {
    //create Storage Class
    
    func testStringStorage(){
        //Write and read a string to our Storage class
        let myStorage = Storage()
        let value = "My String for storage"
        myStorage["key"] = value
        
        XCTAssertNotNil(myStorage["key"])
        
        //test delete
        myStorage["key"] = nil
        XCTAssertNil(myStorage["key"])
    }
    
    
    
    
    
}
