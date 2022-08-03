//
//  ImageFilterViewModel.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 13/07/22.
//

import Foundation
class ImageFilterViewModel: ObservableObject {
	@Published var data:[DemoItem] = []
	let urlProvider: URLProvider
	let opQueue = OperationQueue()
	
	init(urlProvider: URLProvider = URLProvider()){
		self.urlProvider = urlProvider
		for (idx, url) in self.urlProvider.urls.enumerated(){
			self.data.append(DemoItem(title: "\(idx)", image: nil, url: url))
		}		
	}
}
