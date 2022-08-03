//
//  HomeViewController.swift
//  Layouts
//
//  Created by Nestor Hernandez on 10/07/22.
//

import Foundation
class HomeViewController: SwiftUIViewController<HomeView>{
	let viewModel: HomeViewModel
	var coordinator: AppNavigation?
	
	init(viewModel:HomeViewModel = HomeViewModel(),
		 coordinator: AppNavigation? = nil){
		
		self.viewModel = viewModel
		self.coordinator = coordinator
		super.init(content: HomeView(viewModel: viewModel, coordinator: coordinator))
	}
}
