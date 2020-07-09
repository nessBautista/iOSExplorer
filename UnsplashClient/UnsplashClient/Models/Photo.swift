//
//  Photo.swift
//  UnsplashClient
//
//  Created by Ness Bautista on 07/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import UIKit
struct GetPhotosResponse:Decodable {
    var photos:[Photo]
}

struct Photo: Decodable {
    var id:String
    var alt_description:String?
    var width:Int
    var height:Int
    var color:String
    var created_at:String
    var likes:Int
    var liked_by_user:Bool
    var description:String?
    var urls:[String:String]
    var links:[String:String]
    var user:User
}


enum PhotoRecordState {
    case new
    case downloaded
    case failed
}
struct PhotoVM {
    var description:String
    var thumbURL:URL?
    var thumbImg:UIImage = UIImage(named:"Placeholder")!
    var state:PhotoRecordState = .new
    init(photo:Photo){
        self.description = photo.description ?? "No Description"
        if let thumbUrl = photo.urls["thumb"], let url = URL(string: thumbUrl){
            self.thumbURL = url
        }
    }
}

