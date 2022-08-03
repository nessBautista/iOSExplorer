//
//  Lab3View.swift
//  GridsLab
//
//  Created by Nestor Hernandez on 28/06/22.
//

import SwiftUI

struct Lab3View: View {
	var coordinator: AppNavigation?
	@ObservedObject var vm: Lab3ViewModel
    var body: some View {
		NavigationView {
			ScrollView {
				VStack {
					ForEach(0..<vm.data.count) { row in
						HStack {
							ForEach(0..<vm.data[row].count){col in
								RoundedRectangle(cornerRadius: 10)
									.fill(Color.blue)
							}
						}.frame(height:75)
					}
				}
				
			}
			.navigationTitle("Lab3: Grids without LazyGrids")
			.toolbar {
				ToolbarItem(placement: .navigation) {
					Button("Back"){
						self.coordinator?.goToScreen(.home)
					}
				}
			}
		}
		
    }
}

struct Lab3View_Previews: PreviewProvider {
    static var previews: some View {
		Lab3View(vm:Lab3ViewModel())
    }
}
