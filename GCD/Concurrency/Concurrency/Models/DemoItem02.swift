//
//  DemoItem02.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 13/07/22.
//

import Foundation
import SwiftUI
struct DemoItem02: Hashable, Identifiable{
	var id: UUID = UUID()
	var imageURL: URL
	var rawImage: Data?
}

//extension DemoItem02 {
//	func cellView<Cell: View>(@ViewBuilder _ :(CombineOpsViewModel) -> Cell)->some View {
//		
//	}
//	
//	func contextMenu<MenuItems: View>(
//		@ViewBuilder menuItems: (CombineOpsViewModel) -> MenuItems
//	) -> some View {
//		Text("")
//	}
//}
