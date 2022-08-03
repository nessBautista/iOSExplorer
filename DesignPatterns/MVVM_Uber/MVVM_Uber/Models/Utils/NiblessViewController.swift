//
//  NiblessViewController.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 29/07/22.
//

import Foundation
import UIKit
open class NiblessViewController: UIViewController {
	public init(){
		super.init(nibName: nil, bundle: nil)
	}
	
	@available(*, unavailable, message: "Not Implemented")
	public required init?(coder: NSCoder) {
		fatalError()
	}
}
