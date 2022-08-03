//
//  PickMeUpRootViewController.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 02/08/22.
//

import Foundation
class PickMeUpRootViewController: NiblessViewController{
	let location: Location
	let viewModel: PickMeUpViewModel
	let mapViewController: PickMeUpMapViewController
	//let pickMeUpVC: PickMeUpViewController
	
	init(location: Location,
		 viewModel: PickMeUpViewModel,
		 mapViewController: PickMeUpMapViewController){
		self.location = location
		self.viewModel = viewModel
		self.mapViewController = mapViewController
//		self.pickMeUpVC = PickMeUpViewController(location: location,
//												 viewModel: viewModel)
		super.init()
	}
	
	override func loadView() {
		super.loadView()
		self.view = PickMeUpRootView(viewModel: viewModel)
	}
	
	override func viewDidLoad() {
		//self.addFullScreen(childViewController: self.pickMeUpVC)
		self.addFullScreen(childViewController: self.mapViewController)
		super.viewDidLoad()
	}
}
