//
//  LazyGridsViewController.swift
//  GridsLab
//
//  Created by Nestor Hernandez on 28/06/22.
//

import Foundation
import UIKit
class LazyGridsViewController: UITabBarController, UINavigationBarDelegate {
	let coordinator: AppNavigation
	let viewModel: LazyGridsViewModel = LazyGridsViewModel()
	
	public init(coordinator: AppNavigation) {
		self.coordinator = coordinator
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		//SetUp Nav bar
		let navBar = UINavigationBar(frame: CGRect(x: 0, y: 35,
												   width: UIScreen.main.bounds.width, height: 75))

		navBar.delegate = self
		view.addSubview(navBar)
		let navItem = UINavigationItem(title: "Lazy Grids")
		let backButton = UIBarButtonItem(title: "Back", primaryAction: UIAction(handler: { _ in
			print("back")
			self.coordinator.goToScreen(.home)
		}))
		navItem.leftBarButtonItem = backButton
		navBar.setItems([navItem], animated: false)
		// Setup Tab Bar
		self.setViewControllers([FlexibleGridViewController(), FixedGridViewController()], animated: true)
		self.tabBar.backgroundColor = .lightGray
		self.tabBar.items?[0].title = "Flexible"
		self.tabBar.items?[1].title = "Fixed"
		
	}
	
	func position(for bar: UIBarPositioning) -> UIBarPosition {
		return .topAttached
	}
}
