//
//  File.swift
//  
//
//  Created by Nestor Hernandez on 08/01/21.
//

import Foundation

public extension FloatingPoint {
    var isInteger: Bool {rounded() == self}
}
