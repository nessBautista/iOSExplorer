//
//  HomeTableViewController.swift
//  UnsplashClient
//
//  Created by Ness Bautista on 07/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
        
    var router:RouterCoordinator?
    var homePresenter:HomePresenterProtocol?
    
    func config(router:RouterCoordinator, homePresenter:HomePresenterProtocol){
        self.router = router
        self.homePresenter = homePresenter
        self.homePresenter?.delegate = self
        self.tableView.register(UINib(nibName: "HomePhotoCell", bundle: nil), forCellReuseIdentifier: "HomePhotoCell")
        self.tableView.rowHeight = 120
        self.tableView.prefetchDataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homePresenter?.loadFeed()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.homePresenter?.totalCount ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Get cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomePhotoCell") as? HomePhotoCell
        //Start download the image(if required)
        homePresenter?.startOperation(at: indexPath)
        
        //Load UI
        if isLoadingCell(for: indexPath){
            cell?.load(.none)
        } else {
            cell?.load(self.homePresenter?.getPhoto(at:indexPath))
        }
        return cell ?? UITableViewCell()
    }

}

//MARK: LIST UTILITIES
private extension HomeTableViewController{
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= self.homePresenter?.currentCount ?? 0
    }

    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
      let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
      let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
      return Array(indexPathsIntersection)
    }
}
extension HomeTableViewController:UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
      if indexPaths.contains(where: isLoadingCell) {
        homePresenter?.loadFeed()
      }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        homePresenter?.cancelFeedLoad(for: indexPaths)
    }
}
//MARK: HOME PRESENTER DELEGATE
extension HomeTableViewController:HomePresenterDelegate{
    
    func didReceivePhotos(photos: [PhotoVM])
    {
        self.tableView.reloadData()
    }
 
    func didLoadFeed(with newIndexPathsToReload:[IndexPath]?){
        //Manage the first load
        guard let newIndexPathsToReload = newIndexPathsToReload else {
            self.tableView.reloadData()
            return
        }
        //Manage the next pages
        let indexPathToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        self.tableView.reloadRows(at: indexPathToReload, with: .automatic)
    }
    
    func loadFeedDidFail(message: String) {
        print("------->!!! feed did fail with message:\(message)")
    }
    
    func didLoadImage(for indexPath: IndexPath) {
        if let cell = self.tableView.cellForRow(at: indexPath) as? HomePhotoCell,
            let image = self.homePresenter?.photos[indexPath.row].thumbImg {
            cell.imgThumb.image = image
        }
    }
}

