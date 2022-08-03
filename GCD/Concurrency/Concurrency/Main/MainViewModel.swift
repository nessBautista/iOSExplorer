//
//  MainViewModel.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 12/07/22.
//

import Foundation
enum ScreenOption {
	case home
	case example1
	case example2
	case example3
}
class MainViewModel: ObservableObject {
	var listItems:[ListItem]
	@Published var screen: ScreenOption = .home
	init(){
		self.listItems = [
			ListItem(title:"UKit-Image Download",
					 description: "Use of dispatch Queues to fill a grid with multiple Downloaded Images", screen: .example1),
			ListItem(title:"SwiftUI-Image Download",
								   description: "Use of dispatch Queues to fill a grid with multiple Downloaded Images", screen: .example2),
			ListItem(title:"UIKit- Operations",
								   description: "Download and apply filter to image using operations", screen: .example3)
		]
	}
}

protocol AppNavigation {
	func goTo(_ screen: ScreenOption)
}

extension MainViewModel: AppNavigation {
	func goTo(_ screen: ScreenOption) {
		self.screen = screen
	}
}
