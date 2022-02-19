//
//  Collections.swift
//  UnsplashClient
//
//  Created by Ness Bautista on 07/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import Foundation

struct Collection {
    var id: Int
    var title: String
    var description: String
    var published_at: String
    var last_collected_at: String
    var updated_at: String
    var total_photos:Int
    var isPrivate:Bool // ****
    var share_key: String
}
