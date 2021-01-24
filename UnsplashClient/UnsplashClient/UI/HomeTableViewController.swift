//
//  HomeTableViewController.swift
//  UnsplashClient
//
//  Created by Ness Bautista on 07/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
        
    private var pendingSearchTask:DispatchWorkItem?
    @IBOutlet weak var searchBar: UISearchBar!
    var router:RouterCoordinator?
    var homePresenter:HomePresenterProtocol?
    var onDidTapLike:((PhotoVM)->())?
    func config(router:RouterCoordinator, homePresenter:HomePresenterProtocol){
        self.router = router
        self.homePresenter = homePresenter
        //self.homePresenter?.delegate = self
        self.tableView.register(UINib(nibName: "HomePhotoCell", bundle: nil), forCellReuseIdentifier: "HomePhotoCell")
        self.tableView.rowHeight = 350
        self.tableView.prefetchDataSource = self
        self.searchBar.delegate = self
        self.onDidTapLike = { photo in
            print("Got the photo:\(photo.user.username)")
            self.homePresenter?.likePhoto(id: photo.id, onCompletion: { (response) in
                print(response)
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homePresenter?.loadFeed(isSearching: false)
        //self.homePresenter?.loadFeed_publisher(isSearching: false)
        
        //Testing Post method
        //let client = TestClient()
        //client.testPost(userName: "GlazzingFox", tweet: "HelloWorld!")
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
        cell?.onDidTapLike = onDidTapLike
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
        homePresenter?.loadFeed(isSearching: self.searchBar.text?.isEmpty == false)
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
            let photo = self.homePresenter?.photos[indexPath.row] {
            cell.load(photo)
        }
    }
}

extension HomeTableViewController: UISearchBarDelegate{
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {        
        guard searchText.isEmpty == false else {return}
        self.pendingSearchTask?.cancel()
        
        let searchTask = DispatchWorkItem {
            self.searchFor(searchText)
        }
        self.pendingSearchTask = searchTask
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + .milliseconds(500), execute: searchTask)
            
            
    }
    
    fileprivate func searchFor(_ searchText:String){
        print("Looking for term:\(searchText)")
        self.homePresenter?.startSearchingPhoto(query: searchText)
    }
}
