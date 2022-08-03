//
//  ForEachDemo.swift
//  DemoSwiftUI
//
//  Created by Nestor Hernandez on 10/03/22.
//

import SwiftUI
private struct NamedFont: Identifiable {
	let name: String
	let font: Font
	var id: String { name }
}
private let namedFonts: [NamedFont] = [
	NamedFont(name: "Large Title", font: .largeTitle),
	NamedFont(name: "Title", font: .title),
	NamedFont(name: "Headline", font: .headline),
	NamedFont(name: "Body", font: .body),
	NamedFont(name: "Caption", font: .caption)
]

struct ForEachDemo: View {
	let options:[String] = ["option1", "option2","option3"]
    var body: some View {
		VStack{
			Divider()
			HStack{
				ForEach(0..<10){ item in
					Text("\(item)")
				}
			}
			Divider()
			HStack{
				ForEach(options.indices){idx in
					Text("\(idx)")
				}
			}
		}
    }
}

struct ForEachDemo_Previews: PreviewProvider {
    static var previews: some View {
        ForEachDemo()
    }
}
