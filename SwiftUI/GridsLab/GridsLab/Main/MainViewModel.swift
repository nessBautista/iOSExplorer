//
//  MainViewModel.swift
//  GridsLab
//
//  Created by Nestor Hernandez on 13/06/22.
//

import Foundation

public enum AppNavigationState: String, CaseIterable {
	case home
	case lab1 = "Lab 1"
	case lab2 = "iPad's Lab 2 : Fixed, flexible, adaptive"
	case lab3 = "Grid without LazyGrids"
	case lab4 = "Lazy Grids"
	case lab5 = "Flow Layout"
	case lab6 = "LazyGrid: Tree Visualizer"
}

class MainViewModel:ObservableObject {
		
	@Published var appState: AppNavigationState = .home
	
	init(){
		
	}
}
extension MainViewModel: AppNavigation {
	func goToScreen(_ screen: AppNavigationState) {
		self.appState = screen
	}
}

protocol AppNavigation {
	func goToScreen(_ screen: AppNavigationState)
}

