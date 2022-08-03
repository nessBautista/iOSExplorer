//
//  GettingUsersLocationViewController.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 29/07/22.
//

import Foundation
import Combine

class GettingUsersLocationViewController: NiblessViewController{
	private var subscriptions = Set<AnyCancellable>()
	let viewModel: GettingUsersLocationViewModel
	
	init(viewModelFactory: GettingUsersLocationViewModelFactory){
		self.viewModel = viewModelFactory.makeGettingUsersLocationViewModel()
		super.init()
	}
	
	override func loadView() {
		super.loadView()
		self.view = GettingUsersLocationRootView(viewModel: viewModel)
	}
}
