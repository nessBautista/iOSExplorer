//
//  MainView.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 12/07/22.
//

import SwiftUI

struct MainView: View {
	@ObservedObject var viewModel: MainViewModel
    var body: some View {
		List {
			ForEach(viewModel.listItems) {item in
				item.view
					.onTapGesture {
						self.viewModel.goTo(item.screen)
					}
			}
		}
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}
