//
//  Lab2ViewModel.swift
//  GridsLab
//
//  Created by Nestor Hernandez on 14/06/22.
//

import Foundation
import Combine


class Lab2ViewModel: ObservableObject{
	
	var subscriptions = Set<AnyCancellable>()
	@Published var fixedStruct = FixedStruct()
	
	
	init(){
		
	}
}

struct FixedStruct {
	var numberOfColumns = 5
	var numberOfFixedItems: Int = 20
	var spaceBetweenRows: Float = 0
	var spaceBetweenColumns: Float = 0
	var cellWitdh: Float = 50
	var cellHeight: Float = 75
}
