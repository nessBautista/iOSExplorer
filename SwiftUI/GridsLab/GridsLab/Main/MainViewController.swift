//
//  MainViewController.swift
//  GridsLab
//
//  Created by Nestor Hernandez on 13/06/22.
//

import Foundation
import UIKit
import Combine

class MainViewController: SwiftUIViewController<MainView>{
	var subscriptions = Set<AnyCancellable>()
	let viewModel: MainViewModel = MainViewModel()
	init(){
		super.init(rootView: MainView(viewModel: viewModel))
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.listenViewModel()
	}
	
	private func listenViewModel(){
		let publisher = self.viewModel.$appState.removeDuplicates().eraseToAnyPublisher()
		self.subscribe(to: publisher)
	}
	
	private func subscribe(to publisher: AnyPublisher<AppNavigationState, Never>){
		publisher
			.sink { screen in
				self.navigate(to: screen)
			}
			.store(in: &self.subscriptions)
	}
	
	func navigate(to screen: AppNavigationState) {
		var vcScreen: UIViewController?
		switch screen {
		case .home:
			self.presentedViewController?.dismiss(animated: true, completion: nil)
		case .lab1:
			vcScreen = Lab1ViewController(coordinator: self.viewModel)
		case .lab2:
			vcScreen = Lab2ViewController(coordinator: self.viewModel)
		case .lab3:
			vcScreen = Lab3ViewController(coordinator: self.viewModel)
		case .lab4:
			vcScreen = LazyGridsViewController(coordinator: self.viewModel)
		case .lab5:
			vcScreen =  DemoFlowLayoutViewController()
		case .lab6:
			vcScreen =  LazyTreeVisualizerViewController()
		}
		
		if let vc = vcScreen {
			self.presentViewController(vc)
		}
	}
	
	func presentViewController(_ vc: UIViewController){
		vc.modalPresentationStyle = .fullScreen
		self.present(vc, animated: true, completion: nil)
	}
	
	
}
