//
//  ContentView.swift
//  ArtOfStateObserving
//
//  Created by Nestor Hernandez on 12/03/22.
//

import SwiftUI

struct Item {
	var title: String
	var color: Color
	//var id: Int

	mutating func updateTitle(_ title: String){
		self.title = title
	}
}

class Items: ObservableObject {
	@Published var item1: Item
	var item2: Item
	var item3: Item

	
	init(item1:Item, item2:Item, item3: Item) {
		self.item1 = item1
		self.item2 = item2
		self.item3 = item3
	}
}

struct ContentView: View {
//	@State var item1 = Item(title: "one", color: Color.red, id: 1)
//	@State var item2 = Item(title: "two", color: Color.green, id: 2)
//	@State var item3 = Item(title: "three", color: Color.blue, id: 3)
//	@ObservedObject var item1 = Item(title: "one", color: Color.red, id: 1)
//	@ObservedObject var item2 = Item(title: "two", color: Color.green, id: 2)
//	@ObservedObject var item3 = Item(title: "three", color: Color.blue, id: 3)
	@ObservedObject var items:Items = Items(item1: Item(title: "one", color: Color.red),
											item2: Item(title: "two", color: Color.green),
											item3: Item(title: "three", color: Color.blue))
    
	var body: some View {
		VStack(){
			Text("Item List")
				.padding()
			
				HStack{
					Text("\(items.item1.title)")
					Rectangle().fill(items.item1.color)
					//Text("\(items.item1.id)")
				}
				HStack{
					Text("\(items.item2.title)")
					Rectangle().fill(items.item2.color)
					//Text("\(items.item2.id)")
				}
				HStack{
					Text("\(items.item3.title)")
					Rectangle().fill(items.item3.color)
					//Text("\(items.item3.id)")
				}
			
		}.onAppear{
			DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
				
				// With a Class (reference type)
				//self.item1 = Item(title: "one+", color: Color.red, id: 1)
				
				//self.items.item2 = Item(title: "one+", color: Color.red, id: 1)
				
				self.items.item1.color = Color.orange
				
				
			}
		}
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
