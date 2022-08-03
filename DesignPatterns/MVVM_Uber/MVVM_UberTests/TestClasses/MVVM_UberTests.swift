//
//  MVVM_UberTests.swift
//  MVVM_UberTests
//
//  Created by Nestor Hernandez on 29/07/22.
//

import XCTest
@testable import MVVM_Uber

func getMainViewController()->MainViewController {
	guard let mainController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?
		.windows
		.first?
			.rootViewController as? MainViewController else {
				assert(false, "No MainController found")
			}
	return mainController
}
