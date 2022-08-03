//
//  SUIPhotoListView.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 14/07/22.
//

import SwiftUI

struct SUIPhotoListView: View {
	@ObservedObject var viewModel: SUIPhotoListViewModel
	@State private var photo = ""
    var body: some View {
		NavigationView {
			ScrollView {
				LazyVStack {
					ForEach(viewModel.data){item in
						item.view
					}
				}
			}
			.searchable(text: $viewModel.searchText)
			.navigationTitle("Photo List")
			
		}
		
    }
}

struct SUIPhotoListView_Previews: PreviewProvider {
    static var previews: some View {
        SUIPhotoListView(viewModel: SUIPhotoListViewModel())
    }
}
