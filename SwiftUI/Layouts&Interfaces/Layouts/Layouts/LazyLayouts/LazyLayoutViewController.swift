//
//  LazyLayoutViewController.swift
//  Layouts
//
//  Created by Nestor Hernandez on 09/07/22.
//

import Foundation
class LazyLayoutViewController:SwiftUIViewController<LazyLayoutView> {
	let viewModel:LazyLayoutViewModel
	let coordinator: AppNavigation?
	init(viewModel:LazyLayoutViewModel = LazyLayoutViewModel(),
		 coordinator: AppNavigation?){
		self.viewModel = viewModel
		self.coordinator = coordinator
		super.init(content: LazyLayoutView(coordinator: coordinator))
	}
}
