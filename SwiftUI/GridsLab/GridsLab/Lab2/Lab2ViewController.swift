//
//  Lab2ViewController.swift
//  GridsLab
//
//  Created by Nestor Hernandez on 14/06/22.
//

import Foundation
class Lab2ViewController: SwiftUIViewController<Lab2View> {
	let coordinator: AppNavigation
	
	init(coordinator: AppNavigation){
		self.coordinator = coordinator
		super.init(rootView: Lab2View(coordinator: self.coordinator))
	}
	
}
