//
//  AppDelegate.swift
//  HitTestView
//
//  Created by Nestor Hernandez on 15/07/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?


	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		self.window = UIWindow(frame: UIScreen.main.bounds)
		self.window?.rootViewController = ViewController()
		self.window?.makeKeyAndVisible()
		return true
	}
}

