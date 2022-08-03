//
//  MusicGenresViewModel.swift
//  Layouts
//
//  Created by Nestor Hernandez on 10/07/22.
//

import Foundation
class MusicGenresViewModel: ObservableObject {
	let genres: [Genre]
	
	init(){
		self.genres = Genre.list
	}
}
