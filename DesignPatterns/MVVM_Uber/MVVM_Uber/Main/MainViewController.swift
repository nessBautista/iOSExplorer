//
//  MainViewController.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 29/07/22.
//

import Foundation
import Combine
class MainViewController: NiblessViewController {
	// State
	var subscriptions = Set<AnyCancellable>()
	// Dependenceis
	let viewModel: MainViewModel
	let launchViewController: LaunchViewController
	var signedInViewController: SignedInViewController?
	let makeSignedInViewController: (UserSession) -> SignedInViewController
	let makeOnboardingViewController: ()->(OnBoardingViewController)
	var onboardingViewController: OnBoardingViewController?
	
	init(viewModel: MainViewModel,
		 launchViewController: LaunchViewController,
		 onboardingViewControllerFactory: @escaping () -> OnBoardingViewController,
		 signedInViewControllerFactory:@escaping (UserSession) -> SignedInViewController){
		self.viewModel = viewModel
		self.launchViewController = launchViewController
		self.makeOnboardingViewController = onboardingViewControllerFactory
		self.makeSignedInViewController = signedInViewControllerFactory
		super.init()
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		self.observeViewModel()
	}
	
	private func observeViewModel() {
	  let publisher = viewModel.$view.eraseToAnyPublisher()
	  subscribe(to: publisher)
	}
	
	func subscribe(to publisher: AnyPublisher<MainView, Never>) {
	  publisher
		.receive(on: DispatchQueue.main)
		.sink { [weak self] view in
		  guard let strongSelf = self else { return }
		  strongSelf.present(view)
		}.store(in: &subscriptions)
	}
	
	public func present(_ view: MainView) {
	  switch view {
	  case .launching:
		  self.presentLaunching()
	  case .onboarding:
		  self.presentOnboarding()
	  case .signedIn(let userSession):
		presentSignedIn(userSession: userSession)
	  }
	}
	
	public func presentSignedIn(userSession: UserSession) {
	  remove(childViewController: launchViewController)

	  let signedInViewControllerToPresent: SignedInViewController
	  if let vc = self.signedInViewController {
		signedInViewControllerToPresent = vc
	  } else {
		signedInViewControllerToPresent = makeSignedInViewController(userSession)
		self.signedInViewController = signedInViewControllerToPresent
	  }

	  addFullScreen(childViewController: signedInViewControllerToPresent)

	}
	public func presentLaunching() {
	  addFullScreen(childViewController: launchViewController)
	}
	
	public func presentOnboarding() {
	  let onboardingViewController = makeOnboardingViewController()
	  onboardingViewController.modalPresentationStyle = .fullScreen
	  present(onboardingViewController, animated: true) { [weak self] in
		guard let strongSelf = self else {
		  return
		}

		strongSelf.remove(childViewController: strongSelf.launchViewController)
		if let signedInViewController = strongSelf.signedInViewController {
		  strongSelf.remove(childViewController: signedInViewController)
		  strongSelf.signedInViewController = nil
		}
	  }
	  self.onboardingViewController = onboardingViewController
	}
}
