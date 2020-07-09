//
//  HomeUseCases.swift
//  UnsplashClient
//
//  Created by Ness Bautista on 08/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import Foundation

protocol HomeUseCasesProtocol{
    var unsplashClient:UnsplashClient {get}
    func loadFeed(page:Int,onCompletion: @escaping(([PhotoVM]?, String?) -> Void)) 
    func searchPhoto(searchWord:String)
    func getPhotoDetail(id:String)
}

class HomeUseCases:HomeUseCasesProtocol {
    
    var unsplashClient:UnsplashClient
    
    init(unsplashClient:UnsplashClient){
        self.unsplashClient = unsplashClient
    }
    
    func loadFeed(page:Int,onCompletion: @escaping(([PhotoVM]?, String?) -> Void)) {
        self.unsplashClient.getPhotos(page:page) { (photos, error) in
            
            let photosVM = photos?.compactMap({PhotoVM(photo:$0)})
            onCompletion(photosVM,error)
            
        }
    }
    func searchPhoto(searchWord: String) {
        
    }
    
    func getPhotoDetail(id: String) {
        
    }
    
    
}
