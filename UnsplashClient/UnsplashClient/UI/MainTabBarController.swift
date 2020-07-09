//
//  MainTabBarController.swift
//  UnsplashClient
//
//  Created by Ness Bautista on 07/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    var homeVC: HomeTableViewController?
    var collectionsVC: CollectionListViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func configure(home:HomeTableViewController, collections: CollectionListViewController){
        self.homeVC = home
        self.collectionsVC = collections
        viewControllers = [homeVC!, collectionsVC!]
    }
    
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
