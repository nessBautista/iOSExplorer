//
//  Case1.swift
//  ArtOfStateObserving
//
//  Created by Nestor Hernandez on 12/03/22.
//

import SwiftUI

struct OneItem {
	var title: String
	var color: Color
	var id: Int
	mutating func updateTitle(_ title: String){
		self.title = title
	}
}

struct Case1: View {
	@State var items:[OneItem] = [OneItem(title: "one", color: Color.red, id: 1),
						   OneItem(title: "two", color: Color.green, id: 2),
						   OneItem(title: "three", color: Color.blue, id: 3)]
    var body: some View {
		VStack{
			Text("Item List")
				.padding()
				HStack{
					Text("\(items[0].title)")
					Rectangle().fill(items[0].color)
					Text("\(items[0].id)")
				}
				HStack{
					Text("\(items[1].title)")
					Rectangle().fill(items[1].color)
					Text("\(items[1].id)")
				}
				HStack{
					Text("\(items[2].title)")
					Rectangle().fill(items[2].color)
					Text("\(items[2].id)")
				}
		}
		.onAppear{
			DispatchQueue.main.asyncAfter(deadline: .now()+3) {
				items[0].updateTitle("one+")
			}
		}
		
    }
}

struct Case1_Previews: PreviewProvider {
    static var previews: some View {
        Case1()
    }
}
