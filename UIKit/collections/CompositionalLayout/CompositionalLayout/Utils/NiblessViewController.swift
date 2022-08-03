//
//  NiblessViewController.swift
//  CompositionalLayout
//
//  Created by Nestor Hernandez on 09/07/22.
//

import Foundation
import UIKit
open class NiblessViewController: UIViewController {
	public init(){
		super.init(nibName: nil, bundle: nil)
	}
	
	@available(*, unavailable, message: "Not implemented")
	public required init?(coder: NSCoder) {
		fatalError("Not implemented")
	}
}
