//
//  OnboardingControllerTests.swift
//  MVVM_UberTests
//
//  Created by Nestor Hernandez on 31/07/22.
//

import XCTest
@testable import MVVM_Uber

class OnboardingControllerTests: XCTestCase {
	var sut: OnBoardingViewController!
	
	override func setUpWithError() throws {
		try super.setUpWithError()
		let mainController = getMainViewController()		
		sut = mainController.makeOnboardingViewController()
	}
	
	override func tearDownWithError() throws {
		sut = nil
		try super.tearDownWithError()
	}
	
	func test(){		
		XCTAssertNotNil(sut)
	}
}
