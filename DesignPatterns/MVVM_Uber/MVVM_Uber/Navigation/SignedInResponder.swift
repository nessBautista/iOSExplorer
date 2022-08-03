//
//  SignedInResponder.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 29/07/22.
//

import Foundation
public protocol SignedInResponder {
  
  func signedIn(to userSession: UserSession)
}
