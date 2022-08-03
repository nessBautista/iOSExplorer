//
//  LaunchViewModel.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 29/07/22.
//

import Foundation
import Combine

class LaunchViewModel{
	let userSessionRepository: UserSessionRepository
	let notSignedInResponder: NotSignedInResponder
	let signedInResponder: SignedInResponder
	private(set) var subscriptions = Set<AnyCancellable>()
	
	init(userSessionRepository: UserSessionRepository,
		 notSignedInResponder: NotSignedInResponder,
		 signedInResponder: SignedInResponder
	){
		self.userSessionRepository = userSessionRepository
		self.notSignedInResponder = notSignedInResponder
		self.signedInResponder = signedInResponder
	}
	
	func loadUserSession(){
		self.userSessionRepository
			.readUserSession()
			.sink { userSession in
				self.goToNextScreen(userSession: userSession)
			}.store(in: &self.subscriptions)
	}
	
	private func goToNextScreen(userSession: UserSession?){
		switch userSession {
		case .none:
			self.notSignedInResponder.notSignedIn()
		case .some(let userSession):
			self.signedInResponder.signedIn(to: userSession)
		}
	}
}
