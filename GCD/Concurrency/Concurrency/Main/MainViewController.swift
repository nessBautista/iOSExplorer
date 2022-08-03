//
//  MainViewController.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 12/07/22.
//

import Foundation
import Combine
import UIKit

class MainViewController: SwiftUIViewController<MainView>{
	let viewModel: MainViewModel
	private(set) var subscriptions = Set<AnyCancellable>()
	init(viewModel: MainViewModel = MainViewModel()){
		self.viewModel = viewModel
		super.init(rootView: MainView(viewModel: viewModel))
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.bindViewModel()
	}
	
	private func bindViewModel(){
		self.viewModel.$screen.sink { screen in
			self.presentScreen(screen)
		}.store(in: &subscriptions)
	}
	
	func presentScreen(_ screen: ScreenOption){
		var vc: UIViewController?
		switch screen {
		case .home:
			self.dismiss(animated: true, completion: nil)
		case .example1:
			vc = ImageGridViewController()
			vc?.view.backgroundColor = .purple
		case .example2:
			vc = SUIPhotoListViewController()
			vc?.view.backgroundColor = .blue
		case .example3:
			vc = ImageFilterViewController()
		}
		if let vcToPresent = vc {
			vcToPresent.modalPresentationStyle = .fullScreen
			self.present(vcToPresent, animated: true, completion: nil)
		}
	}
}

