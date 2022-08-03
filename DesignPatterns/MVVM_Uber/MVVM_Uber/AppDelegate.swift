//
//  AppDelegate.swift
//  MVVM_Uber
//
//  Created by Nestor Hernandez on 29/07/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?
	let container = DependencyContainer()
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		self.window = UIWindow(frame: UIScreen.main.bounds)
		self.window?.rootViewController = container.makeMainViewController()
		self.window?.makeKeyAndVisible()
		return true
	}

	


}

