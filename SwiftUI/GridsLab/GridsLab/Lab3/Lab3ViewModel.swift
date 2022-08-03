//
//  Lab3ViewModel.swift
//  GridsLab
//
//  Created by Nestor Hernandez on 28/06/22.
//

import Foundation
import Combine
class Lab3ViewModel: ObservableObject {
	@Published var data:[[Int]]
	
	init(){
		self.data = Array(repeating: [], count: 10)
		for y in 0..<10{
			for x in 0..<5 {
				self.data[y].append(x)
			}
		}
	}
}
