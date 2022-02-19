//
//  RouterCoordinator.swift
//  UnsplashClient
//
//  Created by Ness Bautista on 07/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import UIKit


enum NavigationState {
    case home
    case postDetail
}
protocol RouterCoordinator
{
    func next(args:[String:Any])
    func back()
}

class RouterCoordinatorImpl: RouterCoordinator
{
    var dependencyRegistry:DependencyRegister
    var rootViewcontroller: UIViewController
    private var navigationState:NavigationState = .home
    
    init(registry:DependencyRegister, rootVC:UIViewController)
    {
        self.dependencyRegistry = registry
        self.rootViewcontroller = rootVC
    }
    
    func next(args: [String : Any]) {
        switch self.navigationState {
        case .home:
            break
//            if let post = args["post"] as? Post {
//                self.showPostDetail(post: post)
//            }
        case .postDetail:
            break
        }
    }
    
    func back() {
        switch self.navigationState {
        case .home:
            break
        case .postDetail:
            self.rootViewcontroller.navigationController?.popViewController(animated: true)
            self.navigationState = .home
     
        }
    }
}

extension RouterCoordinatorImpl {
//    func showPostDetail(post:Post){
//        let vc = self.dependencyRegistry.makePostDetailViewController(with: post)
//        self.rootViewcontroller.navigationController?.pushViewController(vc, animated: true)
//        self.navigationState = .postDetail
//    }
}
