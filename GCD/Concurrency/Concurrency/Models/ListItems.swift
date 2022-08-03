//
//  ListItems.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 12/07/22.
//

import Foundation

struct ListItem: Hashable, Identifiable {
	var id:UUID = UUID()
	var title: String
	var description: String
	var screen: ScreenOption
}

import SwiftUI
extension ListItem {
	var view: some View {
		VStack {
			Text("\(self.title)")
				.font(.title)
				.bold()
			Text("\(self.description)")
				.font(.body)
		}
		
	}
}
