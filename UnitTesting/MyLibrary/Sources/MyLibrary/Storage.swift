//
//  File.swift
//  
//
//  Created by Nestor Hernandez on 08/01/21.
//

import Foundation
public class Storage {
    private var content:[String:String] = [:]
}

extension Storage {
    subscript(key:String) -> String? {
        get {return content[key]}
        set{
            guard let value = newValue else {
                content[key] = nil
                return
            }
            self.content[key] = value
        }
    }
}
