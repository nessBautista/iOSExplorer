//
//  PickMeUpMapViewModel.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 02/08/22.
//

import Foundation
class PickMeUpMapViewModel:ObservableObject {
	// MARK: - Properties
	@Published public private(set) var pickupLocation: Location
	@Published public var dropoffLocation: Location? = nil

	// MARK: - Methods
	public init(pickupLocation: Location) {
	  self.pickupLocation = pickupLocation
	}
}
