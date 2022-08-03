//
//  Lab2View.swift
//  GridsLab
//
//  Created by Nestor Hernandez on 14/06/22.
//

import SwiftUI

struct Lab2View: View {
	@StateObject var viewModel: Lab2ViewModel = Lab2ViewModel()
	var coordinator: AppNavigation?
	
    var body: some View {
		NavigationView {
			UIGridController(viewModel: viewModel)
				.navigationBarTitleDisplayMode(.large)
				.navigationTitle("Laboratory 2")
				.toolbar {
					ToolbarItem(placement: .navigation) {
						backButton
					}
				}
			MultipleGrids(vm: self.viewModel)
		}
    }
	
	var backButton: some View {
		HStack(alignment: .top) {
			Button("Go Back"){
				self.coordinator?.goToScreen(.home)
			}
		}
	}
}

struct UIGridController: View {
	@ObservedObject var viewModel: Lab2ViewModel
	@State var fixed: Bool = true
	@State var flexible: Bool = true
	@State var adaptive: Bool = true
	var body: some View {
		VStack {
			HStack(alignment: .top) {				
				Toggle(isOn: self.$fixed) {
					Text("Fixed GridItem")
				}
				Toggle(isOn: self.$flexible) {
					Text("Flexible GridItem")
				}
				Toggle(isOn: self.$adaptive) {
					Text("Adaptive GridItem")
				}
			}
			if fixed {
				VStack {
					Slider(value: self.$viewModel.fixedStruct.spaceBetweenRows,
						   in: (0...100))
					Text("Space Between Rows:\(self.viewModel.fixedStruct.spaceBetweenRows)")
					Slider(value: self.$viewModel.fixedStruct.spaceBetweenColumns,
						   in: (0...50))
					Text("Space Between Columns:\(self.viewModel.fixedStruct.spaceBetweenColumns)")
					
					Slider(value: self.$viewModel.fixedStruct.cellWitdh,
						   in: (50...250))
					Text("Cell Width:\(self.viewModel.fixedStruct.cellWitdh)")
					
					Slider(value: self.$viewModel.fixedStruct.cellHeight,
						   in: (50...250))
					Text("Cell Height:\(self.viewModel.fixedStruct.cellHeight)")
				}
				
				
			}
			if flexible {
				
			}
			if adaptive {
				
			}
				
		}

	}
}

struct MultipleGrids: View {
	@ObservedObject var vm: Lab2ViewModel
	
	var body: some View {
		VStack {
			LazyVGrid(columns: self.fixedGridItems(),
					  alignment: .center,
					  spacing: CGFloat(vm.fixedStruct.spaceBetweenRows)) {
				ForEach(0..<self.vm.fixedStruct.numberOfFixedItems) { idx in
					CellItem(title: "\(idx)",
							 height: CGFloat(vm.fixedStruct.cellHeight))
				}
			}
			
		}
	}
	
	func fixedGridItems()->[GridItem] {
		let cellWidth = CGFloat(vm.fixedStruct.cellWitdh)
		let spaceBetweenColumns = CGFloat(vm.fixedStruct.spaceBetweenColumns)
		
		let items = (0...vm.fixedStruct.numberOfColumns)
			.map({_ in GridItem(.fixed(cellWidth),
								spacing: spaceBetweenColumns)})
		return items
		
	}
}

struct CellItem: View {
	let title: String
	let height: CGFloat
	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: 15)
				.fill(Color.blue)
			Text(title)
		}.frame(height: height)
	}
}
struct Lab2View_Previews: PreviewProvider {
    static var previews: some View {
        Lab2View()
    }
}
