//
//  SwiftUIViewController.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 02/08/22.
//

import SwiftUI
open class SwiftUIViewController<Content:View>: UIHostingController<Content>{
	override public init(rootView: Content) {
		super.init(rootView: rootView)
	}
	
	@available(*, unavailable, message: "Not implemented")
	public required init?(coder aDecoder: NSCoder) {
		fatalError()
	}
}
