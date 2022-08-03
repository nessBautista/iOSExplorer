//
//  Lab3ViewController.swift
//  GridsLab
//
//  Created by Nestor Hernandez on 28/06/22.
//

import Foundation
class Lab3ViewController: SwiftUIViewController<Lab3View>{
	let coordinator: AppNavigation
	let vm: Lab3ViewModel = Lab3ViewModel()
	
	init(coordinator: AppNavigation){
		self.coordinator = coordinator
		super.init(rootView: Lab3View(coordinator: self.coordinator, vm: vm))
	}
}
