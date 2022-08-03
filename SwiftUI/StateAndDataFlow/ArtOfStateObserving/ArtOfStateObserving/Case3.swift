//
//  Case3.swift
//  ArtOfStateObserving
//
//  Created by Nestor Hernandez on 12/03/22.
//

import SwiftUI
struct InnerItem {
	var title: String
	var color: Color
	var id: Int

	mutating func updateTitle(_ title: String){
		self.title = title
	}
}

class ViewModel: ObservableObject {
	@Published var item1: InnerItem
	var item2: InnerItem
	var item3: InnerItem

	
	init(item1:InnerItem, item2:InnerItem, item3: InnerItem) {
		self.item1 = item1
		self.item2 = item2
		self.item3 = item3
	}
}

struct Case3: View {
	@ObservedObject var vm:ViewModel = ViewModel(item1: InnerItem(title: "one", color: Color.red, id: 1),
													item2: InnerItem(title: "two", color: Color.green, id:2),
													item3: InnerItem(title: "three", color: Color.blue, id:3))
    var body: some View {
		VStack(){
			Text("Item List")
				.padding()
			
				HStack{
					Text("\(vm.item1.title)")
					Rectangle().fill(vm.item1.color)
					Text("\(vm.item1.id)")
				}
				HStack{
					Text("\(vm.item2.title)")
					Rectangle().fill(vm.item2.color)
					Text("\(vm.item2.id)")
				}
				HStack{
					Text("\(vm.item3.title)")
					Rectangle().fill(vm.item3.color)
					Text("\(vm.item3.id)")
				}
			
		}.onAppear{
			DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
				
				self.vm.item1.color = Color.orange
				//self.vm.item2.color = Color.orange
				
			}
		}
    }
}

struct Case3_Previews: PreviewProvider {
    static var previews: some View {
        Case3()
    }
}
