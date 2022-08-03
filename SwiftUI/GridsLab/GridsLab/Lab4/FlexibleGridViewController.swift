//
//  FlexibleGridViewController.swift
//  GridsLab
//
//  Created by Nestor Hernandez on 28/06/22.
//

import Foundation
class FlexibleGridViewController: SwiftUIViewController<FlexibleGridView>{
	init(){
		super.init(rootView: FlexibleGridView(colors: [.red, .orange, .yellow, .green, .blue, .purple, .gray]))
	}
}
