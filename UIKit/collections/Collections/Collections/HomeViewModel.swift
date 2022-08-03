//
//  HomeViewModel.swift
//  Collections
//
//  Created by Nestor Hernandez on 08/07/22.
//

import Foundation
import Combine
struct HomeItem: Identifiable {
	var id: UUID = UUID()
	var menuOption: ScreenType
}

class HomeViewModel: ObservableObject {
	@Published var homeItems:[HomeItem]
	
	init(){
		self.homeItems = ScreenType.allCases.map({HomeItem(menuOption: $0)})
	}
}
