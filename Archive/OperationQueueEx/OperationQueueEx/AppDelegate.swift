//
//  AppDelegate.swift
//  OperationQueueEx
//
//  Created by Ness Bautista on 02/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = UINavigationController(rootViewController: ListViewController(nibName: "ListViewController", bundle: nil))
        
        return true
    }




}

