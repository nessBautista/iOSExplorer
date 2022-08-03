//
//  LazyTreeVisualizerViewController.swift
//  GridsLab
//
//  Created by Nestor Hernandez on 01/07/22.
//

import Foundation
class LazyTreeVisualizerViewController: SwiftUIViewController<LazyTreeVisualizerView>{
	let viewModel = LazyTreeVisualizerViewModel()
	init(){
		super.init(rootView: LazyTreeVisualizerView(viewModel: viewModel))
	}
}
