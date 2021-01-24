//
//  File.swift
//  
//
//  Created by Nestor Hernandez on 08/01/21.
//

import XCTest
import Combine
@testable import MyLibrary

final class StorageTestCase: XCTestCase{
    
    struct MyTestStruct:Codable {
        var name:String
        var id:Int
        
        init(name:String, id:Int) {
            self.name = name
            self.id = id
        }
    }
               
    //Writing
    func testWritingString(){
        //Testing variables
        let key = "Key"
        let value = "My String for storage"
        let myStorage = Storage<String>()
        
        //Write to a FileStorage instance using subscripts
        myStorage[key] = value
        XCTAssertNotNil(myStorage[key])
        
        //Verify the value was storaged at TempDirectory
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(key)")
        let fileExist = FileManager.default.fileExists(atPath: tempURL.path)
        XCTAssert(fileExist, "File doesn't exist in Temprorary Directory")
    }
    
    func testWriting(){
        //Testing variables
        let key = "1"
        let value = 123
        let myStorage = Storage<Int>()
        
        //Write to a FileStorage instance using subscripts
        myStorage[key] = value
        XCTAssertNotNil(myStorage[key])
        
        //Verify the value was storaged at TempDirectory
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(key)")
        let fileExist = FileManager.default.fileExists(atPath: tempURL.path)
        XCTAssert(fileExist, "File doesn't exist in Temprorary Directory")
        
       myStorage[key] = nil
    }
    
    func testWritingWithEmptyKey(){
        let emptyKey = ""
        let value = "My String for storage"
        let myStorage = Storage<String>()
        myStorage[emptyKey] = value
        XCTAssertNil(myStorage[emptyKey],
                     "A value with an empty key is not allowed")
    }
    
    //deleting
    func testDeletingString(){
        let key = "DeleteTest"
        let value = "Test String for deletion test"
        let myStorage = Storage<String>()
        //first write
        myStorage[key] = value
        XCTAssertNotNil(myStorage[key])
        
        //delete
        myStorage[key] = nil
        
        //Once deleted, FileStorage instance should be empty
        XCTAssertNil(myStorage[key])
        
        //Deleted value should not be present at Temp Directory
        let tempURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("\(key)")
        let fileExist = FileManager.default.fileExists(atPath: tempURL.path)
        XCTAssertFalse(fileExist,
                       "Deleted file is still on disk")
    }
    
    //Test Life Time
    func testShortLifeTime(){
        let lifeTime: TimeInterval = 1
        let key = "TemporalKey"
        let value = "TemporalValue"
        let myStorage = Storage<String>(lifetime: lifeTime)
        myStorage[key] = value
        
        let expectation = self.expectation(description: "Value correctly deleted after defined lifeTime")
        defer{waitForExpectations(timeout: 3)}
        
        DispatchQueue.main
            .asyncAfter(deadline: .now() + 1.5,
                        execute: {
                            defer{expectation.fulfill()}
                            XCTAssertNil(myStorage[key], "Value was not deleted after lifeTime expired")
                            
                            
                        })
    }
    
    //test lifetime
    func testLongLifeTime(){
        let key = "01_TempKey"
        let value = "This value has a life time of 12 hours"
        //lifeTime is 12 hours by default
        let myStorageNow = Storage<String>()
        myStorageNow[key] = value
        
        
        //creation date was 13 hours ago
        let observationDate = Date().addingTimeInterval((60*60*13))
        let myStorageAfter = Storage<String>(dateProvider:{return observationDate})
                
        XCTAssertNil(myStorageAfter[key], "Value was not deleted after lifeTime expired")
    }
    
    func testWritingCustomStruct(){
        
        let myStruct = MyTestStruct(name:"Me", id: 123)
        let myStructStorage = Storage<MyTestStruct>()
        myStructStorage["01_CustomStorage"] = myStruct
        //Test Writing to disk
        XCTAssertNotNil( myStructStorage["01_CustomStorage"])
        
        //Test read data
        if let myStruct = myStructStorage["01_CustomStorage"]{
            XCTAssertEqual(myStruct.name, "Me")
            XCTAssertEqual(myStruct.id, 123)
        }
        
        //Test Delete
//        myStructStorage["01_CustomStorage"] = nil
//        XCTAssertNil(myStructStorage["01_CustomStorage"])
        
        //Test reading after expiration date
        let observationDate = Date().addingTimeInterval((60*60*13))
        let myStorageAfter = Storage<MyTestStruct>(dateProvider:{return observationDate})
        XCTAssertNil(myStorageAfter["01_CustomStorage"], "Value was not deleted after lifeTime expired")
    }
    
    func testCombine(){
        let array: Set<[String:Int]> = [["a":1], ["b":2]]
        let _ = array.publisher.sink(receiveValue: {print($0)})
    }
}
