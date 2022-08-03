//
//  NiblessNavigationController.swift
//  Collections
//
//  Created by Nestor Hernandez on 08/07/22.
//

import Foundation
import UIKit
open class NiblessNavigationController: UINavigationController{
	
	public override init(rootViewController: UIViewController){
		super.init(rootViewController: rootViewController)
	}
	
	@available(*, unavailable, message: "Not implemented")
	public required init?(coder aDecoder: NSCoder) {
		fatalError("Not implemented")
	}
}
