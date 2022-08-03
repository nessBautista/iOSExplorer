//
//  RemoteUserSession.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 29/07/22.
//

import Foundation
public typealias AuthToken = String

public struct RemoteUserSession: Codable {

  // MARK: - Properties
  let token: AuthToken

  // MARK: - Methods
  public init(token: AuthToken) {
	self.token = token
  }
}

extension RemoteUserSession: Equatable {
  
  public static func ==(lhs: RemoteUserSession, rhs: RemoteUserSession) -> Bool {
	return lhs.token == rhs.token
  }
}
