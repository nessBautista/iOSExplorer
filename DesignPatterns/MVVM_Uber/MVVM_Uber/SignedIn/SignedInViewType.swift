//
//  SignedInViews.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 29/07/22.
//

import Foundation
public enum SignedInView {
  
  case gettingUsersLocation
  case pickMeUp(pickupLocation: Location)
  case waitingForPickup
}
