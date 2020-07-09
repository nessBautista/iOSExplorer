//
//  AppDelegate.swift
//  UnsplashClient
//
//  Created by Ness Bautista on 07/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    fileprivate(set) var dependencyRegister: DependencyRegister?

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        //Init dependencies
        self.initDependencies()
        //set root VC
        self.setRootVC()
        
        return true
    }
    
    fileprivate func setRootVC(){
        let vc = (self.dependencyRegister?.container.resolve(MainTabBarController.self))!
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = UINavigationController(rootViewController: vc)
    }
}

//MARK: Dependency registry
extension AppDelegate{
    func initDependencies(){
        if self.dependencyRegister == nil {
            dependencyRegister = DependencyRegister()
        }
    }
}
