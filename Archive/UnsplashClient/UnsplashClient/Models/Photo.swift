//
//  Photo.swift
//  UnsplashClient
//
//  Created by Ness Bautista on 07/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import UIKit
struct UnsplashQueryResponse:Decodable {
    var total:Int
    var total_pages:Int
    var results:[Photo]
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
struct PhotoVM: URLImageProvider {
    var id:String
    var description:String
    var thumbURL:URL?
    var thumbImg:UIImage = UIImage(named:"Placeholder")!
    var state:PhotoRecordState = .new
    var userLike:Bool
    var userName:String
    var user:UserVM
    
    
    var downloadURL: URL? {
        return self.thumbURL
    }
    var outputImage: UIImage?{
        get{
            return self.thumbImg
        }
        set{
            self.thumbImg = newValue ?? UIImage(named:"Placeholder")!
        }
    }
    init(photo:Photo){
        self.id = photo.id
        self.description = photo.description ?? photo.alt_description ?? ""
        if let thumbUrl = photo.urls["thumb"], let url = URL(string: thumbUrl){
            self.thumbURL = url
        }
        self.userName = photo.user.name
        self.user = UserVM(user: photo.user)
        self.userLike = photo.liked_by_user
    }
}

protocol URLImageProvider {
    var downloadURL:URL? {get}
    var outputImage:UIImage? {get set}
    var state:PhotoRecordState {get set}
}

