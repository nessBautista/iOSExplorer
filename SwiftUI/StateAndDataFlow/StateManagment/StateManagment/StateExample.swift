//
//  StateExample.swift
//  StateManagment
//
//  Created by Nestor Hernandez on 20/04/22.
//

import SwiftUI
struct MyStruct {
	
	init(property1:String, property2:String){
		self.id = UUID()
		self.property1 = property1
		self.property2 = property2
		print("Initializing: \(self.id)")
	}
	var id: UUID
	var property1: String
	var property2: String
}

class MyObservableClass: ObservableObject {
	static var count: Int = 0
	init(property1:String = "Property1", property2:String = "Property2"){
		self.property1 = property1 + "- \(MyObservableClass.count)"
		self.property2 = property2 + "- \(MyObservableClass.count)"
	}
	@Published var property1:String = "Property1"
	var property2:String = "Property2"
}
struct StateExample: View {
	@ObservedObject var myVar = MyObservableClass()
    var body: some View {
		VStack {
			TextWrapper(value: $myVar.property1)
			TextWrapper(value: $myVar.property2)
		}.onAppear {
			DispatchQueue.main.asyncAfter(deadline: .now() + 4 ){
				self.myVar.property1 = "New Property 1"
			}
		}
	}
}
struct TextWrapper: View {
	@Binding var value: String
	var body: some View {
		Text("\(value)")
	}
}
struct StateExample_Previews: PreviewProvider {
    static var previews: some View {
		StateExample()
    }
}
