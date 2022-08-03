//
//  MainView.swift
//  GridsLab
//
//  Created by Nestor Hernandez on 13/06/22.
//

import SwiftUI

struct MainView: View {
	@ObservedObject var viewModel: MainViewModel
    
	var body: some View {
		Form {
			ForEach(AppNavigationState.allCases, id: \.self){ item in
				if item != .home {
					FeedItem(title: item.rawValue)
						.onTapGesture {
							self.viewModel.goToScreen(item)
						}
				}
			}
		}
    }
}
struct FeedItem: View {
	let title: String
	var body: some View {
		Text(title)
			.font(.title)
	}
}
//
//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
