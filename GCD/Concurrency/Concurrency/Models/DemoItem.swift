//
//  DemoItem.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 13/07/22.
//

import Foundation
import UIKit
struct DemoItem: Identifiable, Hashable {
	let id:UUID = UUID()
	var title: String
	var image: UIImage?
	var url: URL
}
