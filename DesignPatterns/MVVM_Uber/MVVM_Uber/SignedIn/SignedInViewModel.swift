//
//  SignedInViewModel.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 29/07/22.
//

import Foundation
import Combine

class SignedInViewModel: ObservableObject {
	@Published public private(set) var view: SignedInView = .gettingUsersLocation
}

extension SignedInViewModel: DeterminedPickUpLocationResponder {
	func pickUpUser(at location: Location) {
		self.view = .pickMeUp(pickupLocation: location)
	}
}
