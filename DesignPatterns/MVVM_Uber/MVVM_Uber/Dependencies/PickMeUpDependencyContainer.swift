//
//  PickMeUpDependencyContainer.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 02/08/22.
//

import Foundation
class PickMeUpDependencyContainer {
	
	// from parent
	let signedInViewModel: SignedInViewModel
	let imageCache: ImageCache
	// long lived
	let pickMeUpViewModel: PickMeUpViewModel
	let mapViewModel:PickMeUpMapViewModel
	// Context
	let pickupLocation: Location
	
	init(signedInDependencyContainer: SignedInDependencyContainer,
		 pickupLocation: Location) {
		
		func makePickMeUpMapViewModel()->PickMeUpMapViewModel {
			PickMeUpMapViewModel(pickupLocation: pickupLocation)
		}
		
		func makePickmeUpViewModel()->PickMeUpViewModel {
			PickMeUpViewModel()
		}
		self.signedInViewModel = signedInDependencyContainer.signedInViewModel
		self.pickupLocation = pickupLocation
		self.pickMeUpViewModel = makePickmeUpViewModel()
		self.mapViewModel = makePickMeUpMapViewModel()
		self.imageCache = signedInDependencyContainer.cache
		
	}
	
	func makePickMeUpViewController()->PickMeUpRootViewController{
		let mapViewController = self.makePickMeUpMapViewController()
		return PickMeUpRootViewController(location: self.pickupLocation,
								   viewModel: self.pickMeUpViewModel,
								   mapViewController: mapViewController)
	}
	
	func makePickMeUpMapViewController()->PickMeUpMapViewController {		
		return PickMeUpMapViewController(viewModelFactory: self,
										 imageCache: self.imageCache)
	}
	
	func makePickMeUpMapViewModel()->PickMeUpMapViewModel {
		self.mapViewModel
	}
}

extension PickMeUpDependencyContainer: PickMeUpMapViewModelFactory {}

protocol PickMeUpViewControllerFactory {
  //func makeDropoffLocationPickerViewController() -> DropoffLocationPickerViewController
}
protocol PickMeUpMapViewModelFactory {
  
  func makePickMeUpMapViewModel() -> PickMeUpMapViewModel
}
