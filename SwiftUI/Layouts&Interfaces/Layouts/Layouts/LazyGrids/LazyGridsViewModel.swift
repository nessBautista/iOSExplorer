//
//  LazyGridsViewModel.swift
//  Layouts
//
//  Created by Nestor Hernandez on 11/07/22.
//

import Foundation
import Combine 
class LazyGridsViewModel: ObservableObject {
	@Published var randomSubgenres: [Genre.Subgenre]
	
	init(){
		self.randomSubgenres = Genre.list.randomElement()!.subgenres
	}
}
