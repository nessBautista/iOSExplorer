//
//  HomeItem.swift
//  Layouts
//
//  Created by Nestor Hernandez on 10/07/22.
//

import Foundation
struct HomeItem {
	let id: UUID = UUID()
	let name: String
	let description: String
	let screen: AppScreen
}

extension HomeItem: Identifiable {

}
