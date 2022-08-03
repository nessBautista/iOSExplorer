//
//  HomeView.swift
//  Layouts
//
//  Created by Nestor Hernandez on 10/07/22.
//

import SwiftUI

struct HomeView: View {
	@ObservedObject var viewModel: HomeViewModel
	var coordinator: AppNavigation?
    var body: some View {
		List{
			ForEach(viewModel.data){ item in
				Text("\(item.name)")
					.onTapGesture {
						self.coordinator?.navigateTo(item.screen)
					}
			}
			.navigationTitle("Home")
		}
		.background(Color.blue)
			
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
