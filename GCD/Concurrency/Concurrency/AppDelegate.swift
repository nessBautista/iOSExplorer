//
//  AppDelegate.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 12/07/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		self.window = UIWindow(frame: UIScreen.main.bounds)
		self.window?.rootViewController = MainViewController()
		self.window?.makeKeyAndVisible()
		
		return true
	}



}

