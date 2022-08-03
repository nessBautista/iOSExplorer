//
//  SwiftUIViewController.swift
//  Layouts
//
//  Created by Nestor Hernandez on 09/07/22.
//

import Foundation
import SwiftUI

open class SwiftUIViewController<Content: View>:UIHostingController<Content>{
	public init(content: Content){
		super.init(rootView: content)
	}
	
	@available(*, unavailable, message: "nop")
	public required init?(coder aDecoder: NSCoder) {
		fatalError("nop")
	}
}
