//
//  FlexibleGridView.swift
//  GridsLab
//
//  Created by Nestor Hernandez on 28/06/22.
//

import SwiftUI

struct FlexibleGridView: View {
	let colors:[Color]
    var body: some View {
		ScrollView {
			VStack {
				ForEach(0..<401){ idx in
					colors[idx % colors.count]
						.overlay(Text("\(idx)"))
						.frame(height: 100)
				}
			}
		}
    }
}

struct FlexibleGridView_Previews: PreviewProvider {
    static var previews: some View {
		FlexibleGridView(colors: [.red, .orange, .yellow, .green, .blue, .purple, .gray])
    }
}
