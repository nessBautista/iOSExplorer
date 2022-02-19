//
//  User.swift
//  UnsplashClient
//
//  Created by Ness Bautista on 07/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import UIKit

struct User: Decodable {
    
    var id:String
    var username:String
    var name: String
    var location:String?
    var links:[String:String]
    var profile_image:[String:String]            
}

struct UserVM  {
    var profileURL:URL?
    var profileImage:UIImage = UIImage(named:"humanIcon")!
    var profileImageState: PhotoRecordState = .new
    var username:String
    var location:String
    init(user:User){
        if let strUrl = user.profile_image["medium"],
            let url = URL(string:strUrl) {
            self.profileURL = url
        }
        self.username = user.name
        self.location = user.location ?? "Location Unknown"        
    }
    
    
}

extension UserVM: URLImageProvider{
    var downloadURL: URL? {
        return self.profileURL
    }
    
    var outputImage: UIImage? {
        get{
            return profileImage
        }
        set{
            self.profileImage = newValue ?? UIImage(named:"humanIcon")!
        }
        
    }
    
    var state: PhotoRecordState{
        get{
            return self.profileImageState
        }
        set {
            self.profileImageState = newValue
        }
    }
    
}
