//
//  ContentView.swift
//  PizzaDemo
//
//  Created by Nestor Hernandez on 23/06/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
		VStack {
			ZStack {
				Image("Surf Board")
					.resizable()
					.scaledToFit()
				Text("Huli Pizza Company")
					.font(.title)
			}
			Text("Order Pizza")
				.font(.largeTitle)
			Text("Menu")
			
			List(0 ..< 5) { item in
				HStack(alignment: .center, spacing: 10) {
					Image("1_100w")
					Text("Huli Chiken Pizza")
					Spacer()
				}
			}
			Text("Your Order")
			List(0..<5) { idx in
				HStack(alignment: .firstTextBaseline) {
					Text("Your order item here")
					Spacer()
					Text("$0.00")
				}
			}
			
		}.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
		Group {
			ContentView()
			
			ContentView()
				.colorScheme(.dark)
				.background(Color.black)
				.previewDevice("iPad Pro (9.7-inch)")
		}
        
    }
}
