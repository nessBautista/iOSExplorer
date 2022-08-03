//
//  Lab1View.swift
//  GridsLab
//
//  Created by Nestor Hernandez on 13/06/22.
//

import SwiftUI

struct Lab1View: View {
	var coordinator: AppNavigation?
	@State private var showPopover = false
    
	var body: some View {
		NavigationView {
			LazyVGridExample()
				.navigationBarTitleDisplayMode(.large)
				.toolbar {
					ToolbarItem(placement: .navigation){
						backButton
					}
					ToolbarItem(placement: .principal) {
						Text("Laboratory 1").font(.title)
					}
				}
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


struct LazyVGridExample: View {
	let spaceBetweenRows = 5.0
	let spaceBetweenColumns = 10.0
	let cellHeight = 75.0

	var body: some View {
		ScrollView{
			LazyVGrid(columns: fixedColumns(),
					  alignment: .center,
					  spacing: spaceBetweenRows) {
				ForEach(0..<50){ idx in
					ZStack {
						RoundedRectangle(cornerRadius: 15)
							.fill(Color.blue)
						Text("\(idx)")
					}
					.frame(height:cellHeight)
				}
			}
		}
		.background(Color.orange)
	}
	
	func flexibleColumns()->[GridItem] {
		let columns = (0..<4).map({_ in flexGridItem()})
		return columns
	}
	
	func flexGridItem()->GridItem {
		GridItem(.flexible(minimum: 50),
					spacing: spaceBetweenColumns,
					alignment: .center)
	}
	
	func adaptiveColumns()->[GridItem]{
		[GridItem(.adaptive(minimum: 150),
					spacing: spaceBetweenColumns,
					alignment: .center)]
	}
	
	func fixedColumns()->[GridItem] {
		let columns = (0..<4).map({_ in fixedGridItem()})
		return columns
	}

	func fixedGridItem()->GridItem{
		GridItem(.fixed(75))
	}
	
}
struct Lab1View_Previews: PreviewProvider {
    static var previews: some View {
        Lab1View()
    }
}
