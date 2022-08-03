//
//  MainViewModel.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 29/07/22.
//

import Foundation
class MainViewModel{
	@Published public private(set) var view: MainView = .launching
}

extension MainViewModel: SignedInResponder, NotSignedInResponder, MainNavigation {
	func signedIn(to userSession: UserSession) {
		self.view = .signedIn(userSession: userSession)
	}
	func notSignedIn() {
		self.view = .onboarding
	}
	
	func navigateTo(screen: MainView) {
		self.view = screen
	}
}

