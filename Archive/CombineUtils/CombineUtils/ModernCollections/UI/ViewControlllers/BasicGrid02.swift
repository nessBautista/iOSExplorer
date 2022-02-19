//
//  BasicGrid02.swift
//  CombineUtils
//
//  Created by Nestor Hernandez on 14/02/21.
//

import UIKit
import Combine
class BasicGrid02: UIViewController {
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, BasicGridViewModel.ImageViewModel>! = nil
    let searchBar = UISearchBar(frame: .zero)
    var collectionView: UICollectionView! = nil
    var viewModel = BasicGridViewModel()
    var nameFilter: String?
    let defaultImage = UIImage(imageLiteralResourceName: "3")
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.viewModel.subscriptions.forEach({$0.cancel()})
        self.viewModel.subscriptions.removeAll()
        self.dataSource = nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        self.configureHierarchy()
        self.configureDataSource()
    }
    

    func configureHierarchy() {
        view.backgroundColor = .systemBackground
        let layout = self.getSimpleLayout()
        self.collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView
            .CellRegistration<BasicCollectionCell02, BasicGridViewModel.ImageViewModel> {
                                (cell, indexPath, imageModel) in
                
                // This Pattern uses a parent view model to trigger the image download
                // The childVM publishes the image to UI subscriptors in the cell
                
                /* The image fetching responsability  is activated to by ParentViewModel
                 Childs VMs (ImageViewModels) fetch the images and publish the result to
                 a subscriber in the cell (a ImageView). We have to subscriber types:
                    - The one in each cell (subscribing at the load(:) method)
                    - The Set of Subscriptios stored at the ParentVM(BaseGridViewModel)
                    which have the same number as the array of childsVMs (ImageViewModels)
                 
                 --> Keep in mind that the reference to the cell view model should be weak
                 
                 */
                cell.load(vm: imageModel)
                self.viewModel.fetchImage02(for: indexPath.row)
        }
        
        dataSource = UICollectionViewDiffableDataSource
                    <Section, BasicGridViewModel.ImageViewModel>(collectionView: collectionView) {
            
                    (collectionView: UICollectionView,
                    indexPath: IndexPath,
                    identifier: BasicGridViewModel.ImageViewModel) -> UICollectionViewCell? in
            
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BasicCollectionCell02", for: indexPath) as! BasicCollectionCell02
//
//                return cell
            print(indexPath)
            return collectionView
                    .dequeueConfiguredReusableCell(using: cellRegistration,
                                                   for: indexPath,
                                                   item: identifier)
        }
        
        //Initialize with data
        self.viewModel.buildImageViewModels()
        var snapshot = NSDiffableDataSourceSnapshot<Section, BasicGridViewModel.ImageViewModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.viewModel.imageViewModels)
        dataSource.apply(snapshot)
    }

}

extension BasicGrid02: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        
    }
    
 
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
               
    }
}
