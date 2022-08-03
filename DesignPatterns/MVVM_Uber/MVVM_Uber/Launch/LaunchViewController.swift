//
//  LaunchViewController.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 29/07/22.
//

import Foundation
class LaunchViewController: NiblessViewController {
	
	let viewModel: LaunchViewModel
	init(viewModel: LaunchViewModel){
		self.viewModel = viewModel
		super.init()
	}
	override func loadView() {
		view = LaunchView(viewModel: viewModel)
	}
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}
