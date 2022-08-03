//
//  GettingUsersLocationViewModel.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 29/07/22.
//

import Foundation
import Combine
class GettingUsersLocationViewModel {
	
	// Dependencies
	let locator: Locator
	let determinedPickupLocationResponder: DeterminedPickUpLocationResponder
	// State
	public var errorMessages: AnyPublisher<ErrorMessage, Never> {
	  errorMessagesSubject.eraseToAnyPublisher()
	}
	private let errorMessagesSubject = PassthroughSubject<ErrorMessage, Never>()
	private(set) var subscriptions = Set<AnyCancellable>()
	
	init(locator: Locator,
		 determinedPickupLocationResponder: DeterminedPickUpLocationResponder){
		self.locator = locator
		self.determinedPickupLocationResponder = determinedPickupLocationResponder
	}
	
	func getCurrentLocation() {
		self.locator.getUsersCurrentLocation()
			.receive(on: RunLoop.main)
			.sink { completion in
				if case .failure(let error) = completion {
					self.errorMessagesSubject.send(error)
				}
			} receiveValue: { location in
				self.determinedPickupLocationResponder
					.pickUpUser(at: location)
			}
			.store(in: &subscriptions)
	}
}
