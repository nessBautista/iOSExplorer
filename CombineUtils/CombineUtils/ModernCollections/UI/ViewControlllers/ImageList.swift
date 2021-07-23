//
//  File.swift
//  CombineUtils
//
//  Created by Nestor Hernandez on 08/02/21.
//

import Foundation
import UIKit

class ImageListViewController: UITableViewController {
    let viewModel: ImageListViewModel = ImageListViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.register(UINib(nibName: "BasicCell", bundle: nil), forCellReuseIdentifier: "BasicCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.urls.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell")
            as? BasicCell
        if let url = self.viewModel.getUrlFor(indexPath: indexPath) {
            let vm = ImageViewModel(url: url)
            cell?.viewModel = vm
        
            if tableView.indexPathsForVisibleRows?.contains(indexPath) ?? false {
                print("index: \(indexPath.row)")
                cell?.load()
            }
            
        }
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}




