//
//  AppDelegate.swift
//  GridsLab
//
//  Created by Nestor Hernandez on 13/06/22.
//

import Foundation
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate{
	var window: UIWindow?
	
	func applicationDidFinishLaunching(_ application: UIApplication) {
		self.window = UIWindow(frame: UIScreen.main.bounds)
		self.window?.makeKeyAndVisible()
		let rootVC = MainViewController()
		self.window?.rootViewController = rootVC
	}
}
