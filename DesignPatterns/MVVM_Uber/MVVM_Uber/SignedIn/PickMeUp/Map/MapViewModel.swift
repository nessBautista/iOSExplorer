//
//  MapViewModel.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 03/08/22.
//

import Foundation


struct MapViewModel {

  // MARK: - Properties
  var pickupLocationAnnotations: [MapAnnotation]
  var dropoffLocationAnnotations: [MapAnnotation]
  var availableRideLocationAnnotations: [MapAnnotation]

  // MARK: - Methods
  init(pickupLocationAnnotations: [MapAnnotation] = [],
	   dropoffLocationAnnotations: [MapAnnotation] = [],
	   availableRideLocationAnnotations: [MapAnnotation] = []) {
	self.pickupLocationAnnotations = pickupLocationAnnotations
	self.dropoffLocationAnnotations = dropoffLocationAnnotations
	self.availableRideLocationAnnotations = availableRideLocationAnnotations
  }
}
