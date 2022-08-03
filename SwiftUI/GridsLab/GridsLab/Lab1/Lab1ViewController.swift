//
//  Lab1ViewController.swift
//  GridsLab
//
//  Created by Nestor Hernandez on 13/06/22.
//

import Foundation
import SwiftUI

class Lab1ViewController:SwiftUIViewController<Lab1View>{
	let coordinator: AppNavigation
	init(coordinator: AppNavigation){
		self.coordinator = coordinator
		super.init(rootView: Lab1View(coordinator: self.coordinator))
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
}
