//
//  HomeViewModel.swift
//  CombineUtils
//
//  Created by Nestor Hernandez on 10/02/21.
//

import Foundation

class HomeViewModel {
    var content: [HomeItem]
    
    init(content: [HomeItem]) {
        self.content = content
    }
}

struct HomeItem: Hashable  {
    var title: String = String()
    var description: String?
    private let identifier = UUID()
    
}

extension HomeViewModel {
    static func initHomeContent() -> HomeViewModel {
        let searchWithCombine = HomeItem(title: "Search Bar With Combine")
        let imageDownloads1 = HomeItem(title: "Image downloads: basic")
        let basicGrid = HomeItem(title: "Basic Grid 01")
        let basicGrid02 = HomeItem(title: "Basic Grid 02")
        let mountainsExample = HomeItem(title: "Mountains Example")
        let multiSection01 = HomeItem(title: "MultiSection 01")
        let orthogonalSections = HomeItem(title: "Orthogonal Sections")
        
        let vm = HomeViewModel(content: [searchWithCombine,
                                imageDownloads1,
                                basicGrid,
                                basicGrid02,
                                mountainsExample,
                                multiSection01,
                                orthogonalSections])
        return vm
    }
}
