//
//  User.swift
//  UnsplashClient
//
//  Created by Ness Bautista on 07/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import Foundation

struct User: Decodable {
    
    var id:String
    var username:String
    var name: String
    
    var links:[String:String]
}
