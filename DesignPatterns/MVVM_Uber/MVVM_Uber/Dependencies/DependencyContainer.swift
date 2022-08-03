//
//  DependencyContainer.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 29/07/22.
//

import Foundation
class DependencyContainer {
	let sharedMainViewModel: MainViewModel
	let sharedUserSessionRepository: UserSessionRepository
	init(){
		func makeUserSessionRepository() -> UserSessionRepository {
			AppUserSessionRepository()
		}
		self.sharedUserSessionRepository = makeUserSessionRepository()
		self.sharedMainViewModel = MainViewModel()
	}

	func makeMainViewController()->MainViewController{
		let launchVC = self.makeLaunchViewController()
		let signedInViewControllerFactory = {session in
			return self.makeSignedInViewController(session)
		}
		let onboardingViewControllerFactory = {
			return OnBoardingViewController()
		}
		
		return MainViewController(viewModel: self.sharedMainViewModel,
								  launchViewController: launchVC,
								  onboardingViewControllerFactory: onboardingViewControllerFactory,
								  signedInViewControllerFactory: signedInViewControllerFactory)
	}
	
	
	func makeLaunchViewController()->LaunchViewController {
		let viewModel = self.makeLaunchViewModel()
		return LaunchViewController(viewModel: viewModel)
	}
	
	func makeLaunchViewModel()->LaunchViewModel {
		LaunchViewModel(userSessionRepository: self.sharedUserSessionRepository,
						notSignedInResponder: self.sharedMainViewModel,
						signedInResponder: self.sharedMainViewModel)
	}
	
	
	func makeSignedInViewController(_ session: UserSession)->SignedInViewController {
		let container = makeSignedInDependencyContainer(session: session)
		return container.makeSignedInViewController()
	}
	
	func makeSignedInDependencyContainer(session: UserSession)->SignedInDependencyContainer {
		SignedInDependencyContainer(session: session,
									appDependencyContainer: self)
	}
}
