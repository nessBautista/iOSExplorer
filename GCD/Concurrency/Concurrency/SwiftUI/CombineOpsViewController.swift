//
//  CombineOpsViewController.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 13/07/22.
//

import Foundation
class CombineOpsViewController: SwiftUIViewController<CombineOpsView>{
	let viewModel: CombineOpsViewModel
	
	init(viewModel: CombineOpsViewModel = CombineOpsViewModel()){
		self.viewModel = viewModel
		super.init(rootView: CombineOpsView(viewModel: self.viewModel))
	}
}
