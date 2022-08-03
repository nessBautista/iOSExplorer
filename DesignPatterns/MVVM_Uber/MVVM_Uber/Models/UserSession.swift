//
//  UserSession.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 29/07/22.
//

import Foundation
public class UserSession {
	// MARK: - Properties
	public let profile: UserProfile
	public let remoteSession: RemoteUserSession

	// MARK: - Methods
	public init(profile: UserProfile, remoteSession: RemoteUserSession) {
	  self.profile = profile
	  self.remoteSession = remoteSession
	}
	
	static var guessSession : UserSession {
		func makeURL() -> URL {
		  
		  return URL(string: "http://www.koober.com/avatar/johnnya")!
		}

		let profile = UserProfile(name: "Johnny Appleseed",
								  email: "johnny@gmail.com",
								  mobileNumber: "510-736-8754",
								  avatar: makeURL())
		let remoteUserSession = RemoteUserSession(token: "64652626")
		let userSession = UserSession(profile: profile, remoteSession: remoteUserSession)
		return userSession
	}
}


extension UserSession: Equatable {
  
  public static func ==(lhs: UserSession, rhs: UserSession) -> Bool {
	return lhs.profile == rhs.profile &&
		   lhs.remoteSession == rhs.remoteSession
  }
}
