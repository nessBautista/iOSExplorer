//
//  VGrid.swift
//  GridsLab
//
//  Created by Nestor Hernandez on 12/03/22.
//

import SwiftUI
struct Item: Identifiable{
	let id:UUID = UUID()
	var title: String
	var color: Color {
		if self.colorId == 2 {
			return Color.blue
		}
		return self.colorId == 0 ? Color.black : Color.white
	}
	var colorId:Int = 0
	
}
class ViewModel: ObservableObject {
	@Published var data:[[Item]]
	
	init(rows: Int, columns: Int){
		self.data = []
		for y in 0..<rows {
			var row:[Item] = []
			for x in 0..<columns{
				var item = Item(title: "x:\(x), y:\(y)")
				item.colorId = Int.random(in: 0..<2)
				row.append(item)
			}
			self.data.append(row)
		}
	}
}
struct VGrid: View {
	@StateObject var vm: ViewModel = ViewModel(rows:10, columns: 5)
    var body: some View {
			
		LazyVGrid(columns: [GridItem(.fixed(400),
									spacing: 16)],
				  spacing: 16) {
			ForEach(0..<self.vm.data.count){ y in
				LazyHGrid(rows: [GridItem(.adaptive(minimum: 80))], 	  spacing: 16) {
					
					ForEach(0..<self.vm.data[y].count){x in
						
						RoundedRectangle(cornerRadius: 10)
							.fill(self.vm.data[y][x].color)
							.frame(width: 50,height:50)
							.onTapGesture {
								self.vm.data[y][x] = Item(title:"x:\(x), y:\(y)",
								colorId: 2)
								print(self.vm.data[y][x].title)
							}
						
					}
				}.frame(maxWidth: .infinity)
				
			}
			
		}
		.padding(16)
		.background(Color.orange)
		
    }
}

struct VGrid_Previews: PreviewProvider {
    static var previews: some View {
        VGrid()
    }
}
