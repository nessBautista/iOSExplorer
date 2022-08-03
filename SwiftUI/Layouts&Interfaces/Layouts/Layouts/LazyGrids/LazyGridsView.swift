//
//  LazyGridsView.swift
//  Layouts
//
//  Created by Nestor Hernandez on 11/07/22.
//

import SwiftUI
enum LayoutType {
	case v
	case h
}
struct LazyGridsView: View {
	@ObservedObject var viewModel: LazyGridsViewModel
	var coordinator: AppNavigation?
	let tw = UIScreen.main.bounds.width
	@State var type: LayoutType? = .v
	
    var body: some View {
		NavigationView {
			ScrollView(self.type == .v ? .vertical :  .horizontal) {
				if self.type == .v {
					verticalGrid
				} else {
					horizontalGrid
				}
			}
			.toolbar {
				ToolbarItem(placement:.navigationBarLeading) {
					Button("Back"){
						self.coordinator?.navigateTo(.home)
					}
				}
				ToolbarItem(placement:.navigationBarTrailing){
					Menu("Options"){
						Button("LazyVGrid"){
							self.type = .v
						}
						Button("LazyHGrid"){
							self.type = .h
						}
					}
				}
				
			}
		}
    }
	
	@ViewBuilder
	var verticalGrid: some View {
		LazyVGrid(columns: [
			GridItem(.adaptive(minimum: 70))
		]){
			ForEach(viewModel.randomSubgenres.shuffled(), content: \.view)
		}.padding(.horizontal)
			.navigationTitle("Lazy Grids")
			.navigationBarTitleDisplayMode(.large)
	}
	
	@ViewBuilder
	var horizontalGrid: some View {
		LazyHGrid(rows: [
			GridItem(.flexible(minimum: 100)),
			GridItem(.flexible(minimum: 100))
		]){
			ForEach(viewModel.randomSubgenres.shuffled(), content: \.view).background(Color.red)
		}.padding(.horizontal)
			.navigationTitle("Lazy Grids")
			.navigationBarTitleDisplayMode(.large)
	}
}

struct LazyGridsView_Previews: PreviewProvider {
    static var previews: some View {
        LazyGridsView(viewModel: LazyGridsViewModel(), coordinator: nil)
    }
}
