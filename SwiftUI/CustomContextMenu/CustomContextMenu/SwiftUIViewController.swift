//
//  SwiftUIViewControllerf.swift
//  CustomContextMenu
//
//  Created by Nestor Hernandez on 28/07/22.
//

import Foundation
import SwiftUI
open class SwiftUIViewController<Content: View>: UIHostingController<Content>{
	override public init(rootView: Content) {
		super.init(rootView: rootView)
	}
	
	@available(*, unavailable, message: "Not Implemented")
	public required init?(coder aDecoder: NSCoder) {
		fatalError("Not Implemented")
	}
}
