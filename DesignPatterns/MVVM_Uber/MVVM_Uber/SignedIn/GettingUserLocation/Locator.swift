//
//  Locator.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 29/07/22.
//

import Foundation
import Combine
public protocol Locator {
  func getUsersCurrentLocation() -> AnyPublisher<Location, ErrorMessage>
}

public class FakeLocator: Locator {

  // MARK: - Methods
  public init() {}

	public func getUsersCurrentLocation() -> AnyPublisher<Location, ErrorMessage>{
		return Future<Location, ErrorMessage>{ promise in
			DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 1) {
				do {
					let location = try self.getLocation()
					promise(.success(location))
				} catch {
					if let errorMessage = error as? ErrorMessage{
						promise(.failure(errorMessage))
					}
				}
			}
			
			// Or error
			
		}.eraseToAnyPublisher()
	}
	
	private func getLocation()throws ->Location {
		guard self is FakeLocator else {
			let errorMessage = ErrorMessage(title: "Error Getting Location",
											message: "Could not get your location. Please check location settings and try again.")
			throw errorMessage
		}
		let location = Location(id: "0",
								latitude: -33.864308,
								longitude: 151.209146)
		return location
	}
}

