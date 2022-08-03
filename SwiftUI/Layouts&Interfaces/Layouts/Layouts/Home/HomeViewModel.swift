//
//  HomeViewModel.swift
//  Layouts
//
//  Created by Nestor Hernandez on 10/07/22.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
	var data:[HomeItem]
	
	init(){
		self.data = HomeViewModel.buildHomeMenu()
	}
	
	static func buildHomeMenu()->[HomeItem]{
		let l1 = HomeItem(name: "A simple LazyVGrid", description: "Using a basic configuration of a basic LazyVStack, we demostrate the improvements over using a simple VStack in regards memory usage.", screen: .layout1)
		let l2 = HomeItem(name: "Layouts with LazyGrids", description: "an AppStore like layout using LazyGrids and scroll views.", screen: .layout2)
		let l3 = HomeItem(name: "LazyGrids", description: "Working with Lazy Grids", screen: .layout3)
		
		return [l1, l2, l3]
	}
}
