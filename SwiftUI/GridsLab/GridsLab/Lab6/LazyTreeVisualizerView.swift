//
//  LazyTreeVisualizerView.swift
//  GridsLab
//
//  Created by Nestor Hernandez on 01/07/22.
//

import SwiftUI

struct LazyTreeVisualizerView: View {
	@ObservedObject var viewModel: LazyTreeVisualizerViewModel
    var body: some View {
		NavigationView {
			ScrollView{
				ForEach(0..<viewModel.treeLevels.count, id: \.self){ row in
					LazyVGrid(columns: self.getColumns(for: row), alignment: .center) {
						ForEach(0..<self.viewModel.treeLevels[row].count){ col in
							RoundedRectangle(cornerRadius: 75/2)
								.fill(Color.blue)
								.overlay(Text("\(self.viewModel.treeLevels[row][col])"))
								.frame(height: 20,
									   alignment: .center)
						}
					}
				}.background(Color.green, alignment: .center)
			}.toolbar {
				ToolbarItem(placement: .confirmationAction) {
					Button("Display Tree Levels"){
						viewModel.displayTreeLevels()
					}
				}
			}
			
		}
    }
	
	func getColumns(for row: Int)->[GridItem]{
		//[GridItem(.flexible(minimum: 10))]
		let numberOfItems = self.viewModel.treeLevels[row].count
		return (0...numberOfItems).map({_ in GridItem(.fixed(20))})
	}
}

struct LazyTreeVisualizerView_Previews: PreviewProvider {
    static var previews: some View {
        LazyTreeVisualizerView(viewModel: LazyTreeVisualizerViewModel())
    }
}
