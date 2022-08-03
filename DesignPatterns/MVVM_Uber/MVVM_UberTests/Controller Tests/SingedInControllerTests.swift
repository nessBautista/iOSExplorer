//
//  SingedInControllerTests.swift
//  MVVM_UberTests
//
//  Created by Nestor Hernandez on 31/07/22.
//

import XCTest
@testable import MVVM_Uber
class SingedInControllerTests: XCTestCase {
	var sut: SignedInViewController!
	
	override func setUpWithError() throws {
		try super.setUpWithError()
		let mainController = getMainViewController()
		sut = mainController.makeSignedInViewController(UserSession.guessSession)
	}
	
	
	override func tearDownWithError() throws {
		sut = nil
		try super.tearDownWithError()
	}
	
	func testGivenInitialState_screenShowsGettingLocationScreen(){
		sut.viewDidLoad()
		let screen = sut.children.first(where: {$0 is GettingUsersLocationViewController})
		XCTAssertNotNil(screen)
	}
}
