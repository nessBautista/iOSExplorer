//
//  NotSignedInResponder.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 29/07/22.
//

import Foundation
public protocol NotSignedInResponder {
  
  func notSignedIn()
}
public protocol MainNavigation{
  
	func navigateTo(screen: MainView)
}
