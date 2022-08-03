//
//  LazyGridsViewController.swift
//  Layouts
//
//  Created by Nestor Hernandez on 11/07/22.
//

import Foundation
class LazyGridsViewController:SwiftUIViewController<LazyGridsView> {
	let viewModel: LazyGridsViewModel
	var coordinator: AppNavigation?
	
	init(viewModel: LazyGridsViewModel = LazyGridsViewModel(),
		 coordinator: AppNavigation?){
		self.viewModel = viewModel
		self.coordinator = coordinator
		super.init(content: LazyGridsView(viewModel: viewModel,
										  coordinator: coordinator))
	}
}
