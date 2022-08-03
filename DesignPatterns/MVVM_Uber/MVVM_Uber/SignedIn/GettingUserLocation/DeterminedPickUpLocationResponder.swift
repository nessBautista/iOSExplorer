//
//  DeterminedPickUpLocationResponder.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 29/07/22.
//

import Foundation

public protocol DeterminedPickUpLocationResponder {
  func pickUpUser(at location: Location)
}
