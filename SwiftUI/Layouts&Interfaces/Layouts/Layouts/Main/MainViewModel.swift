//
//  MainViewModel.swift
//  Layouts
//
//  Created by Nestor Hernandez on 09/07/22.
//

import Foundation
enum AppScreen{
	case home
	case layout1
	case layout2
	case layout3
}
class MainViewModel: ObservableObject {
	@Published var screen: AppScreen = .home
	
}

extension MainViewModel: AppNavigation {
	func navigateTo(_ screen: AppScreen){
		self.screen = screen
	}
}
protocol AppNavigation{
	func navigateTo(_ screen: AppScreen)
}
