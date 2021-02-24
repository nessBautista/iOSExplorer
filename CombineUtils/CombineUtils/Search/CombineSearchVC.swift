//
//  CombineSearchVC.swift
//  CombineUtils
//
//  Created by Nestor Hernandez on 30/01/21.
//

import Foundation
import UIKit
import  Combine

class CombineSearchVC: UIViewController {
    public var subscriptions = Set<AnyCancellable>()
    let searchController = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search Candies"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
        
        let searchPublisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchController.searchBar.searchTextField)
        searchPublisher
            .map ({
                ($0.object as? UISearchTextField)!.text
            })
            .debounce(for: .seconds(1), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { (query) in
                print(query)
            }
            .store(in: &subscriptions)
    }
}

extension CombineSearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    
    }
    
    fileprivate func search(for query:String) {
    
    }
}
