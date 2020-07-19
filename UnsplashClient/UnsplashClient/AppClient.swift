//
//  AppClient.swift
//  UnsplashClient
//
//  Created by Ness Bautista on 09/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import Foundation
class AppClient {
    static var shared = AppClient()
    var isLoggedIn:Bool = true
    init(){
        
    }
    
    func loginStatus()->Bool{
        return isLoggedIn
    }
}
