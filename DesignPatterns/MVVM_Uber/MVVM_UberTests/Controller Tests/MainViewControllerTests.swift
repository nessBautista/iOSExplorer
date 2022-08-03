//
//  MainViewControllerTests.swift
//  MVVM_UberTests
//
//  Created by Nestor Hernandez on 31/07/22.
//

import XCTest
@testable import MVVM_Uber

class MainViewControllerTests: XCTestCase {
	var sut: MainViewController!
	override func setUpWithError() throws {
		try super.setUpWithError()
		sut = getMainViewController()
	}
	
	func givenStateIsLaunching(){
		sut.viewModel.navigateTo(screen: .launching)
	}
	
	func givenStateIsNotSignedIn(){
		sut.viewModel.notSignedIn()
	}
	
	func givenStateIsSignedIn()->UserSession{
		let session = UserSession.guessSession
		sut.viewModel.signedIn(to: session)
		return session
	}
	
	override func tearDownWithError() throws {
		sut = nil
		try super.tearDownWithError()
	}
	
	func testMainControllerCanBeObtained(){
		XCTAssertNotNil(sut)
	}
	
	func testGivenInitialState_mainViewIsLaunching(){
		givenStateIsLaunching()
		let numberOfChildrens = sut.children.count
		XCTAssertEqual(numberOfChildrens, 1)
		XCTAssertEqual(sut.viewModel.view, MainView.launching)
	}
	func testGivenUserNotSignedIn_mainViewIsNotSignedIn(){
		givenStateIsNotSignedIn()
		let numberOfChildrens = sut.children.count
		XCTAssertEqual(numberOfChildrens, 1)
		XCTAssertEqual(sut.viewModel.view, MainView.onboarding)
	}
	
	func testGivenUserSignedIn_mainViewIsSignedIn(){
		let session = givenStateIsSignedIn()
		let numberOfChildrens = sut.children.count
		XCTAssertEqual(numberOfChildrens, 1)
		XCTAssertEqual(sut.viewModel.view, MainView.signedIn(userSession: session))
	}
}
