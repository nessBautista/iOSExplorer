//
//  MusicGenres.swift
//  Layouts
//
//  Created by Nestor Hernandez on 10/07/22.
//

import Foundation
class MusicGenresViewController: SwiftUIViewController<MusicGenresView>{
	let viewModel: MusicGenresViewModel
	var coordinator: AppNavigation?
	init(viewModel: MusicGenresViewModel = MusicGenresViewModel(),
		 coordinator: AppNavigation?){
		self.viewModel = viewModel
		self.coordinator = coordinator
		super.init(content: MusicGenresView(viewModel: viewModel,
											coordinator: coordinator))
	}
}
