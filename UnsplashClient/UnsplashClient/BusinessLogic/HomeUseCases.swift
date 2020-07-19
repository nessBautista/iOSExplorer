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
    func getPhotoDetail(id:String)
    func likePhoto(id:String, onCompletion:@escaping(String?)->Void)
    func searchPhoto(query:String, page:Int, onCompletion: @escaping(([PhotoVM]?, String?) -> Void))
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
    func searchPhoto(query:String, page:Int,onCompletion: @escaping(([PhotoVM]?, String?) -> Void)) {
        self.unsplashClient.searchPhoto(query: query, page: page) { (photos, error) in
            guard error == nil else {
                return
            }
            let photosVM = photos?.compactMap({PhotoVM(photo:$0)})
            onCompletion(photosVM,error)
        }
    }
    
    func getPhotoDetail(id: String) {
        
    }
    
    func likePhoto(id:String, onCompletion:@escaping(String?)->Void){
        self.unsplashClient.likePhoto(id:id){ response in 
            print(response)
            onCompletion(response)
        }
            
        
    }
    
}
