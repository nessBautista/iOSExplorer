//
//  PickMeUpMapViewController.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 02/08/22.
//

import Foundation
class PickMeUpMapViewController: NiblessViewController {
	//MARK: - Dependencies
	let viewModelFactory: PickMeUpMapViewModelFactory
	let imageCache: ImageCache
	
	// Root View
	var mapView: PickMeUpMapRootView {
	  return view as! PickMeUpMapRootView
	}
	
	init(viewModelFactory: PickMeUpMapViewModelFactory,
		 imageCache: ImageCache){
		self.imageCache = imageCache
		self.viewModelFactory = viewModelFactory
		super.init()
		self.view.backgroundColor = .blue
	}
	
	override func loadView() {
		super.loadView()
		let viewModel = viewModelFactory.makePickMeUpMapViewModel()
		self.view = PickMeUpMapRootView(viewModel: viewModel,
										imageCache: imageCache)
	}
	
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		
		mapView.imageCache = imageCache
	}
	
	public override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	public override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
	}
}
