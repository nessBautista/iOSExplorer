//
//  SignedInViewController.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 29/07/22.
//

import Foundation
import Combine
import UIKit

class SignedInViewController: NiblessViewController {
	
	private var subscriptions = Set<AnyCancellable>()
	
	let viewModel: SignedInViewModel
	let viewControllerFactory: SignedInViewControllerFactory
	var currentChildViewController: UIViewController?
	
	init(viewModel: SignedInViewModel,
		 viewControllerFactory: SignedInViewControllerFactory) {
		self.viewModel = viewModel
		self.viewControllerFactory = viewControllerFactory
		super.init()
	}
	
	override func loadView() {
		super.loadView()
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .purple
		self.subscribe(self.viewModel.$view.eraseToAnyPublisher())
	}
	
	func subscribe(_ publisher: AnyPublisher<SignedInView, Never>){
		publisher
			.sink { view in
				self.present(view)
			}
			.store(in: &self.subscriptions)
	}
	
	func present(_ view: SignedInView) {
		switch view {
		case .gettingUsersLocation:
			let vc = viewControllerFactory.makeGettingUsersLocationViewController()
			self.transition(to: vc)
		case .pickMeUp(let pickupLocation):
			let vc = viewControllerFactory.makePickMeUpViewController(pickupLocation: pickupLocation)
			self.transition(to: vc)
		case .waitingForPickup:
			break
		}
	}
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		currentChildViewController?.view.frame = view.bounds
	}
	
	private func transition(to viewController: UIViewController){
		remove(childViewController: currentChildViewController)
		addFullScreen(childViewController: viewController)
		self.currentChildViewController = viewController
	}
}

