//
//  URLProvider.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 12/07/22.
//

import Foundation
class URLProvider {
	var urls:[URL] = []
	
	init(){
		guard let plist = Bundle.main.url(forResource: "Photos", withExtension: "plist"),
			  let contents = try? Data(contentsOf: plist),
			  let serial = try? PropertyListSerialization.propertyList(from: contents, format: nil),
			  let serialUrls = serial as? [String] else {
		  print("Something went horribly wrong!")
		  return
		}
		self.urls = serialUrls.compactMap({URL(string: $0)})
	}
	
	
}
