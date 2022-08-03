//
//  PickMeUpView.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 02/08/22.
//

import SwiftUI

struct PickMeUpView: View {
    var body: some View {
		VStack {
			Spacer()
			Text("Map View")
				.font(.title)
		}
		.background(Color.green)
		.frame(maxWidth:.infinity, maxHeight: .infinity)
        
    }
}

struct PickMeUpView_Previews: PreviewProvider {
    static var previews: some View {
        PickMeUpView()
    }
}
