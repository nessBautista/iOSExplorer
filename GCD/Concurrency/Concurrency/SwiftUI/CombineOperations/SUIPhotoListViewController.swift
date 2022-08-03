//
//  SUIPhotoListViewController.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 14/07/22.
//

import Foundation
class SUIPhotoListViewController: SwiftUIViewController<SUIPhotoListView>{
	let viewModel: SUIPhotoListViewModel
	
	init(viewModel: SUIPhotoListViewModel = SUIPhotoListViewModel()){
		self.viewModel = viewModel
		super.init(rootView: SUIPhotoListView(viewModel: viewModel))
	}
}
