//
//  PickMeUpViewController.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 02/08/22.
//

import Foundation
class PickMeUpViewController: SwiftUIViewController<PickMeUpView>{
	let location: Location
	let viewModel: PickMeUpViewModel
	
	init(location: Location,
		 viewModel: PickMeUpViewModel){
		self.location = location
		self.viewModel = viewModel
		super.init(rootView: PickMeUpView())
	}

}
