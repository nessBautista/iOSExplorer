//
//  AppDelegate.swift
//  CombineUtils
//
//  Created by Nestor Hernandez on 30/01/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let vc = ViewController()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController?.view.backgroundColor = .white
        self.window?.rootViewController = UINavigationController(rootViewController: vc)
        
        return true
    }
}

