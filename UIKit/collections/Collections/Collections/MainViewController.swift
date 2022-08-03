//
//  MainViewController.swift
//  Collections
//
//  Created by Nestor Hernandez on 08/07/22.
//

import Foundation
import Combine

class MainViewController: NiblessNavigationController {
	private(set) var subscriptions = Set<AnyCancellable>()
	let viewModel: MainViewModel
	let homeViewController: HomeViewController
	
	init() {
		self.viewModel = MainViewModel()
		self.homeViewController = HomeViewController(viewModel: HomeViewModel(),
													 coordinator: self.viewModel)
		super.init(rootViewController: homeViewController)
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.bindViewModel()
	}
	
	private func bindViewModel(){
		self.viewModel.$screen
			.removeDuplicates()
			.sink { completion in
				print(completion)
			} receiveValue: { screen in
				self.goTo(screen)
			}
			.store(in: &subscriptions)
	}
	
	func goTo(_ screen: ScreenType){
		switch screen {
		case .home:
			self.popToRootViewController(animated: true)
			break
		case .flowLayout:
			let vc = BasicFlowViewController(coordinator: self.viewModel)
			self.pushViewController(vc, animated: true)
		case .emojiCollection:
			let vc = EmojiViewController(coordinator: self.viewModel)
			self.pushViewController(vc, animated: true)
		}
	}
	
}

