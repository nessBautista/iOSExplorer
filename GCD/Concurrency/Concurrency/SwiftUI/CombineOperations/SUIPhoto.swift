//
//  SUIPhoto.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 14/07/22.
//

import Foundation
import SwiftUI

struct SUIPhoto: Identifiable, Hashable{
	var id:UUID = UUID()
	var url: URL
	var title: String
}

extension SUIPhoto {
	@ViewBuilder
	var view: some View {
		VStack{
			Text(self.title)
				.font(.body)
			SUIPhotoCell(viewModel: SUIPhotoCellViewModel(url: self.url))
		}
		
	}
}
struct SUIPhotoCell: View {
	@ObservedObject var viewModel: SUIPhotoCellViewModel
	var body: some View {
		if let img = viewModel.image {
			img
				.resizable()
				.frame(width: 275, height: 275, alignment: .center)
		} else {
			Image(systemName: "photo")
				.resizable()
				.frame(width: 275, height: 275, alignment: .center)
		}
	}
}
