//
//  DependencyRegisteer.swift
//  UnsplashClient
//
//  Created by Ness Bautista on 07/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import Swinject
final class DependencyRegister{
    var container:Container
    
    init(){
        Container.loggingFunction = nil
        self.container = Container()
        self.registerDependencies()
        self.registerViewControllers()
    }
    
    func registerDependencies(){
        container.register(RouterCoordinator.self) { (r, rootVC:UIViewController) -> RouterCoordinator in
            return RouterCoordinatorImpl(registry: self, rootVC: rootVC)
        }.inObjectScope(.container)
        
        //Utilities
        container.register(PendingOperations.self) { (r) -> PendingOperations in
            return PendingOperations()
        }
        
        //API Clients
        container.register(UnsplashClient.self) { (r) -> UnsplashClient in
            return UnsplashClient()
        }
        
        //Bussiness Logic
        container.register(HomeUseCasesProtocol.self) { (r) -> HomeUseCasesProtocol in
            let unsplashClient = r.resolve(UnsplashClient.self)!
            let homeUseCases = HomeUseCases(unsplashClient: unsplashClient)
            return homeUseCases
        }
        
        //Presenters
        container.register(HomePresenterProtocol.self) { (r) -> HomePresenterProtocol in
            let homeUseCases = r.resolve(HomeUseCasesProtocol.self)!
            let pendingOps = PendingOperations()
            return HomePresenter(homeUseCase: homeUseCases, pendingOperations:pendingOps)
        }
    }
    
    func registerViewControllers(){
        
        self.container.register(HomeTableViewController.self) { (r) -> HomeTableViewController in
            let home = HomeTableViewController(nibName: "HomeTableViewController", bundle: nil)
            let router = self.makeRouteCoordinator(rootVC: home)
            let homePresenter = r.resolve(HomePresenterProtocol.self)!
            //let router = r.resolve(RouterCoordinator.self, argument: home)!
            home.config(router: router, homePresenter:homePresenter)
            return home
        }
        
        self.container.register(CollectionListViewController.self) { (r) -> CollectionListViewController in
            return CollectionListViewController(nibName: "CollectionListViewController", bundle: nil)
        }
        
        self.container.register(MainTabBarController.self) { (r) -> MainTabBarController in
            let tabBar = MainTabBarController()
            let home = r.resolve(HomeTableViewController.self)!
            let collections = r.resolve(CollectionListViewController.self)!
            tabBar.configure(home: home, collections: collections)
            return tabBar
        }
        
        
    }
}
extension DependencyRegister {
    func makeRouteCoordinator(rootVC:UIViewController) -> RouterCoordinator {
        return container.resolve(RouterCoordinator.self, argument: rootVC)!
    }
    
    func makeHomePresenter()->HomePresenterProtocol {
        return container.resolve(HomePresenter.self)!
    }
}
