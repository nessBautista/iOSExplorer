//
//  SignedInDependencyContainer.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 29/07/22.
//

import Foundation
class SignedInDependencyContainer {
	// From Parent
	let mainViewModel: MainViewModel
	
	// Context
	let session: UserSession
	
	// Long Lived
	let signedInViewModel: SignedInViewModel
	let locator: Locator
	let cache: ImageCache
	
	init(session: UserSession,
		 appDependencyContainer: DependencyContainer){
		func makeImageCache() -> ImageCache {
		  return InBundleImageCache()
		}
		func makeSignedInViewModel()->SignedInViewModel {
			SignedInViewModel()
		}
		
		self.session = session
		self.mainViewModel = appDependencyContainer.sharedMainViewModel
		
		self.signedInViewModel = makeSignedInViewModel()
		self.locator = FakeLocator()
		self.cache = makeImageCache()
	}
	
	func makeSignedInViewController()->SignedInViewController {
		let vm = self.signedInViewModel
		return SignedInViewController(viewModel: vm,
									  viewControllerFactory: self)
	}
	
	
}

extension SignedInDependencyContainer: SignedInViewControllerFactory {
	func makeGettingUsersLocationViewController() -> GettingUsersLocationViewController {
		GettingUsersLocationViewController(viewModelFactory: self)
	}
	
	func makePickMeUpViewController(pickupLocation: Location) -> PickMeUpRootViewController {
		let pickMeUpDependencyContainer = PickMeUpDependencyContainer(signedInDependencyContainer: self,
																	  pickupLocation: pickupLocation)
		
		return pickMeUpDependencyContainer.makePickMeUpViewController()
	}
}

extension SignedInDependencyContainer: GettingUsersLocationViewModelFactory {
	func makeGettingUsersLocationViewModel()->GettingUsersLocationViewModel {
		GettingUsersLocationViewModel(locator: self.locator,
									   determinedPickupLocationResponder: self.signedInViewModel)
	}
}

// MARK: Factory Protocols
protocol GettingUsersLocationViewModelFactory{
	func makeGettingUsersLocationViewModel() -> GettingUsersLocationViewModel
}
protocol SignedInViewControllerFactory {
  
  func makeGettingUsersLocationViewController() -> GettingUsersLocationViewController
  func makePickMeUpViewController(pickupLocation: Location) -> PickMeUpRootViewController
  //func makeWaitingForPickupViewController() -> WaitingForPickupViewController
}
