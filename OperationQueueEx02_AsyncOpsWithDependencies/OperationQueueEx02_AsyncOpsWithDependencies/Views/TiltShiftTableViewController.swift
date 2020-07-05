//
//  TiltShiftTableViewController.swift
//  OperationQueueEx02_AsyncOpsWithDependencies
//
//  Created by Ness Bautista on 04/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import UIKit
class TiltShiftTableViewController: UITableViewController {
  
    let imageList = TiltShiftImage.loadDefaultData()
    var imageProviders = Set<TiltShiftImageProvider>()
    
    override func viewDidLoad() {
        self.tableView.register(UINib(nibName: "ImageTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageTableViewCell")
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableViewCell", for: indexPath)
        
        if let cell = cell as? ImageTableViewCell {
            
            cell.tiltShiftImage = imageList[indexPath.row]
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ImageTableViewCell else {return}
        let imageProvider = TiltShiftImageProvider(tiltShiftImage: imageList[indexPath.row]) { (image) in
            OperationQueue.main.addOperation {
                cell.updateImageViewWithImage(image)
            }
        }
        self.imageProviders.insert(imageProvider)
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? ImageTableViewCell else {return}
        for provider in imageProviders.filter({$0.tiltShiftImage == cell.tiltShiftImage}) {
            provider.cancel()
            self.imageProviders.remove(provider)
        }
    }
}

