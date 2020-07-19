//
//  UnsplashClientUITests.swift
//  UnsplashClientUITests
//
//  Created by Ness Bautista on 11/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import XCTest
@testable import UnsplashClient

class UnsplashClientUITests: XCTestCase {

    
    func test_unsplashClient_notNil(){
        //let homePresenter = HomePresenter(homeUseCase: HomeUseCaseTest(), pendingOperations: PendingOperations())
        
        //XCTAssertNotNil(homePresenter.homeUseCase.unsplashClient)
    }
}

class HomeUseCaseTest:HomeUseCasesProtocol{
    var unsplashClient: UnsplashClient
    
    init(){
        self.unsplashClient = UnsplashClient()
    }
    
    func loadFeed(page: Int, onCompletion: @escaping (([PhotoVM]?, String?) -> Void)) {
        onCompletion(nil, nil)
    }
    
        
    func likePhoto(id: String, onCompletion: @escaping (String?) -> Void) {
        onCompletion(nil)
    }
    
    func searchPhoto(query: String, page: Int, onCompletion: @escaping (([PhotoVM]?, String?) -> Void)) {
        onCompletion(nil,nil)
    }
    
    func getPhotoDetail(id: String) {
    
    }

}
