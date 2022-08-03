//
//  NiblessNavigationController.swift
//  Layouts
//
//  Created by Nestor Hernandez on 09/07/22.
//

import Foundation
import UIKit
open class NiblessNavigationController: UINavigationController {
	public override init(rootViewController: UIViewController){
		super.init(rootViewController: rootViewController)
	}
	
	@available(*, unavailable, message: "nop, sorry")
	public required init?(coder aDecoder: NSCoder) {
		fatalError("Nop")
	}
}

open class NiblessTabBarViewController: UITabBarController {
	public init(){
		super.init(nibName: nil, bundle: nil)
	}
	
	@available(*, unavailable, message: "nope")
	public required init?(coder: NSCoder) {
		fatalError("Nope")
	}
}
