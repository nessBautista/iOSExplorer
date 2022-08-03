//
//  MainViewController.swift
//  Layouts
//
//  Created by Nestor Hernandez on 09/07/22.
//

import Foundation
import UIKit
import Combine
class MainViewController: NiblessTabBarViewController {
	private(set) var subscriptions = Set<AnyCancellable>()
	let viewModel: MainViewModel
	let homeViewController:HomeViewController
	
	override init(){
		let mainViewModel = MainViewModel()
		self.viewModel = mainViewModel
		self.homeViewController = HomeViewController(coordinator: mainViewModel)
		self.homeViewController.coordinator = viewModel
		self.homeViewController.tabBarItem = UITabBarItem(title: "Home", image: nil, tag: 0)
		super.init()
		self.viewControllers = [homeViewController]
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.bindViewModel()
		self.modalPresentationStyle = .fullScreen
		self.tabBar.backgroundColor = .gray
		
	}
	
	private func bindViewModel(){
		self.viewModel.$screen
			.sink { [weak self] screen in
			self?.navigateTo(screen)
			}.store(in: &subscriptions)
	}
	
	func navigateTo(_ screen: AppScreen){
		var vc: UIViewController?
		switch screen {
		case .home:
			self.dismiss(animated: true, completion: nil)
			//self.popToRootViewController(animated: true)
			break
		case .layout1:
			vc = LazyLayoutViewController(coordinator: viewModel)
		case .layout2:
			vc = MusicGenresViewController(coordinator: viewModel)
		case .layout3:
			vc = LazyGridsViewController(coordinator: viewModel)
		}
		if let vcToPresent = vc{
			vcToPresent.modalPresentationStyle = .fullScreen
			//self.pushViewController(vcToPresent, animated: true)
			self.present(vcToPresent, animated: true, completion:nil)
		}
		
	}
}
