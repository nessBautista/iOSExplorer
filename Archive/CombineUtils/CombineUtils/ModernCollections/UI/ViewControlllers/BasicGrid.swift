//
//  BasicGrid.swift
//  CombineUtils
//
//  Created by Nestor Hernandez on 11/02/21.
//

import UIKit
import Combine
class BasicGrid: UIViewController {
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, BasicGridViewModel.ImageModel>! = nil
    let searchBar = UISearchBar(frame: .zero)
    var collectionView: UICollectionView! = nil
    var viewModel = BasicGridViewModel()
    var nameFilter: String?
    let defaultImage = UIImage(imageLiteralResourceName: "3")
    var subscriptions = Set<AnyCancellable>()
    
    override func viewWillDisappear(_ animated: Bool) {
        self.dataSource = nil
        self.viewModel.subscriptions.forEach({$0.cancel()})
        self.viewModel.subscriptions.removeAll()
        self.subscriptions.forEach({$0.cancel()})
        self.subscriptions.removeAll()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
               
        // This pattern uses the parent VM to trigger the image download
        // When the image is download, it publishes the changes to one array of
        // child models. This ViewController is subscribed to this array and
        // uses a diffable datasource to re-load any changes on this array
        
        //Use the advantage of diffable datasources to reload the grid this way
        //You create the snapshot and let the data source reloads whats needed
        self.viewModel.$imageModels
            .sink { (models) in
                var snapshot = NSDiffableDataSourceSnapshot<Section, BasicGridViewModel.ImageModel>()
                snapshot.appendSections([.main])
                snapshot.appendItems(models)
                self.dataSource.apply(snapshot)
            }
            .store(in: &subscriptions)
    }
    
    func configureHierarchy() {
        view.backgroundColor = .systemBackground
        let layout = self.getBasicGrid()
        self.collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView
            .CellRegistration<BasicCollectionCell, BasicGridViewModel.ImageModel> {
                                (cell, indexPath, imageModel) in
                cell.imageView.image = nil
                if let image = imageModel.image {
                    
                    cell.imageView.image = image
                } else {                    
                    cell.imageView.image = self.defaultImage                    
                    self.viewModel.fetchImage(for: indexPath.row)
                }
        }
        
        dataSource = UICollectionViewDiffableDataSource
                    <Section, BasicGridViewModel.ImageModel>(collectionView: collectionView) {
            
                    (collectionView: UICollectionView,
                    indexPath: IndexPath,
                    identifier: BasicGridViewModel.ImageModel) -> UICollectionViewCell? in
            
            return collectionView
                    .dequeueConfiguredReusableCell(using: cellRegistration,
                                                   for: indexPath,
                                                   item: identifier)
        }
        
        //Initialize with data
        self.viewModel.buildImageModels()
        var snapshot = NSDiffableDataSourceSnapshot<Section, BasicGridViewModel.ImageModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.viewModel.imageModels)
        dataSource.apply(snapshot)
    }
}

extension BasicGrid: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
    }
    
 
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //print("didEndDisplay:\(indexPath.row), total Ops:\(self.viewModel.subscriptionsDictionary.count)")
        //self.viewModel.cancelOperation(for: indexPath.row)
        
    }
}
