//
//  Extensions.swift
//  MVVM_UberTests
//
//  Created by Nestor Hernandez on 31/07/22.
//

import Foundation
@testable import MVVM_Uber
extension MainViewController {
	func getSignedInViewController()->SignedInViewController {
		self.children.first(where: {$0 is SignedInViewController}) as! SignedInViewController
	}
	
	func getOnboardingViewController()->OnBoardingViewController {
		self.children.first(where: {$0 is OnBoardingViewController}) as! OnBoardingViewController
	}
}

