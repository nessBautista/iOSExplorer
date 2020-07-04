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
      let tsImage = imageList[indexPath.row]
      let imageProvider = TiltShiftImageProvider(tiltShiftImage: tsImage)
      
      cell.tiltShiftImage = imageList[indexPath.row]
      cell.updateImageViewWithImage(imageProvider.image)
    }
  
    return cell
  }
}

