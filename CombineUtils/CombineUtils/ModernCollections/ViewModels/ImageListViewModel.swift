//
//  ImageListViewModel.swift
//  CombineUtils
//
//  Created by Nestor Hernandez on 08/02/21.
//

import Foundation

class ImageListViewModel {
    lazy var urls:[String] = {
        //Extrac urls from plist file
        guard let plist = Bundle.main.url(forResource: "Photos", withExtension: "plist"),
              let contents = try? Data(contentsOf: plist),
              let serial = try? PropertyListSerialization.propertyList(from: contents, format: nil),
              let serialUrls = serial as? [String] else {
          print("Something went horribly wrong!")
          return []
        }
        return serialUrls
    }()
    
    func getImageViewModels() -> [ImageViewModel] {
        let vms = self.urls.map({ImageViewModel(strUrl: $0)})
        return vms
    }
    
    func getUrlFor(indexPath: IndexPath) -> URL?{
        let index = indexPath.row
        
        guard index < self.urls.count,
              let url = URL(string: self.urls[index]) else {
            return nil
        }
        
        return url
    }
}
