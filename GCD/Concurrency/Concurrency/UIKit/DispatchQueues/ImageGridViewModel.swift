//
//  ImageGridViewModel.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 12/07/22.
//

import Foundation
import UIKit

class ImageGridViewModel: ObservableObject {
	let urlProvider: URLProvider
	let dispatcher: QueueDispatcher
	var images:[UIImage?] = []
	init(urlProvider: URLProvider = URLProvider(),
		 dispatcher: QueueDispatcher = QueueDispatcher()){
		self.urlProvider = urlProvider
		self.dispatcher = dispatcher
		self.images = Array(repeating: nil, count: self.urlProvider.urls.count)
	}
	
}
