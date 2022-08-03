//
//  SUIPhotoListViewModel.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 14/07/22.
//

import Foundation
import Combine
import SwiftUI

class SUIPhotoListViewModel: ObservableObject {
	@Published var data:[SUIPhoto] = []
	let urlProvider = URLProvider()
	@Published var searchText: String = String()
	private(set) var subscriptions = Set<AnyCancellable>()
	var search: String = String(){
		didSet{
			print(search)
			updateWithSearchResults(for: search)
		}
	}
	init(){
		
		for (idx, url) in urlProvider.urls.enumerated() {
			let item = SUIPhoto(url: url, title:"\(idx)")
			self.data.append(item)
		}
		self.$searchText
			.assign(to: \.search, on: self)
			.store(in: &subscriptions)
	}
	
	func updateWithSearchResults(for query:String){
		guard let q = Int(query) else {return}
		let data = self.data.filter{
			q < (Int($0.title) ?? 0)
		}
		self.data = data
	}
}

class SUIPhotoCellViewModel: ObservableObject {
	@Published var image:Image?
	let url:URL
	let defaultImage = UIImage(named: "mountains")!
	private(set) var subscriptions = Set<AnyCancellable>()
	init(url:URL){
		self.url = url
		let downloaderPublisher = CombineImageDownloader(input: url).$output
		let filterPublisher =  downloaderPublisher
									.map {CombineImageTiltShifter(input: ($0 ?? self.defaultImage)).$output}
		
		Publishers.Zip(downloaderPublisher, filterPublisher)
			.subscribe(on: DispatchQueue.global(qos: .userInteractive))
			.receive(on: RunLoop.main)
			.sink(receiveValue: {
				$1.sink(receiveValue: {
					self.image = Image(uiImage: ($0 ?? self.defaultImage))
				}).store(in: &self.subscriptions)
			}).store(in: &subscriptions)
	}
	
	
}
