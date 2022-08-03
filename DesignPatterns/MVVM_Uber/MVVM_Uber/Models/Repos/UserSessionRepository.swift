//
//  UserSessionRepository.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 29/07/22.
//

import Foundation
import Combine
protocol UserSessionRepository {
	func readUserSession()->AnyPublisher<UserSession?, Never>
}

class AppUserSessionRepository: UserSessionRepository {
	func readUserSession()->AnyPublisher<UserSession?, Never>{
		return Future<UserSession?, Never>{ promise in
			return promise(.success(UserSession.guessSession))
		}.eraseToAnyPublisher()
	}
}
