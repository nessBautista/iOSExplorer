//
//  NiblessView.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 29/07/22.
//

import Foundation
import UIKit

open class NiblessView: UIView {
	public override init(frame: CGRect) {
		super.init(frame: frame)
	}
	
	@available(*, unavailable, message: "Not implemented")
	public required init?(coder: NSCoder) {
		fatalError()
	}
}
