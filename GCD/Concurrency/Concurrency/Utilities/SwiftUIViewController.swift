//
//  NiblessViewController.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 12/07/22.
//

import Foundation
import SwiftUI
open class SwiftUIViewController<Content: View>: UIHostingController<Content>{
	public override init(rootView: Content){
		super.init(rootView: rootView)
	}
	
	@available(*, unavailable, message: "Nope")
	public required init?(coder aDecoder: NSCoder) {
		fatalError("Nope")
	}
}
