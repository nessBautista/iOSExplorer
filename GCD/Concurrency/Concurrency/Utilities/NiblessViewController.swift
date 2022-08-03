//
//  NiblessViewController.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 12/07/22.
//

import UIKit
open class NiblessViewController: UIViewController {
	public init(){
		super.init(nibName: nil, bundle: nil)
	}
	
	@available(*, unavailable, message: "Nope")
	public required init?(coder: NSCoder) {
		fatalError("Nope")
	}
}

