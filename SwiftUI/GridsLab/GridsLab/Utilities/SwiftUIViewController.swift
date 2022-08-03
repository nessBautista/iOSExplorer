//
//  SwiftUIViewController.swift
//  GridsLab
//
//  Created by Nestor Hernandez on 13/06/22.
//

import Foundation
import SwiftUI
open class SwiftUIViewController<Content: View>: UIHostingController<Content>{
	
	override public init(rootView: Content) {
		super.init(rootView: rootView)
	}
	
//	@MainActor @objc required dynamic public init?(coder aDecoder: NSCoder) {
//		fatalError("init(coder:) has not been implemented")
//	}
	@available(*, unavailable,
	  message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
	)
	
	@available(*, unavailable,
	  message: "Loading this view controller from a nib is unsupported in favor of initializer dependency injection."
	)
	public required init?(coder aDecoder: NSCoder) {
	  fatalError("Loading this view controller from a nib is unsupported in favor of initializer dependency injection.")
	}
}
