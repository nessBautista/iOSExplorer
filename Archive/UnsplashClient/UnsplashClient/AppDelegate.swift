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
        
        
         NotificationCenter.default.addObserver(self, selector: #selector(logoutUser), name: NSNotification.Name(rawValue: "logout"), object: nil)
        if AppClient.shared.loginStatus() == false {
            self.logoutUser()
        } else {
            //set root VC
            self.setRootVC()
        }
        
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

//MARK: Logout
extension AppDelegate{
    @objc func logoutUser(){
        let loginVC = LoginViewController(nibName: "LoginViewController", bundle: nil)
        self.replaceRootViewController(loginVC)
    }
    
    fileprivate func replaceRootViewController(_ vc: UIViewController, animated: Bool = false){
        let transition = animated ? CATransition() : nil
        transition?.type = CATransitionType.fade
        self.window?.set(rootViewController: vc, withTransition: transition)
    }
}

extension UIWindow {

    /// Fix for http://stackoverflow.com/a/27153956/849645
    func set(rootViewController newRootViewController: UIViewController, withTransition transition: CATransition? = nil) {

        let previousViewController = rootViewController

        if let transition = transition {
            // Add the transition
            layer.add(transition, forKey: kCATransition)
        }

        rootViewController = newRootViewController

        // Update status bar appearance using the new view controllers appearance - animate if needed
        if UIView.areAnimationsEnabled {
            UIView.animate(withDuration: CATransaction.animationDuration()) {
                newRootViewController.setNeedsStatusBarAppearanceUpdate()
            }
        } else {
            newRootViewController.setNeedsStatusBarAppearanceUpdate()
        }

        if #available(iOS 13.0, *) {
            // In iOS 13 we don't want to remove the transition view as it'll create a blank screen
        } else {
            // The presenting view controllers view doesn't get removed from the window as its currently transistioning and presenting a view controller
            if let transitionViewClass = NSClassFromString("UITransitionView") {
                for subview in subviews where subview.isKind(of: transitionViewClass) {
                    subview.removeFromSuperview()
                }
            }
        }
        if let previousViewController = previousViewController {
            // Allow the view controller to be deallocated
            previousViewController.dismiss(animated: false) {
                // Remove the root view in case its still showing
                previousViewController.view.removeFromSuperview()
            }
        }
    }
}
