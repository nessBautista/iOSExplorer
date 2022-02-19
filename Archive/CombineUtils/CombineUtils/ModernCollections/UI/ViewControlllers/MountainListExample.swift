//
//  MountainListExample.swift
//  CombineUtils
//
//  Created by Nestor Hernandez on 12/02/21.
//

import UIKit

class MountainListExample: UIViewController {

    //MARK: - Variables
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, BasicGridViewModel.Mountain>! = nil
    let searchBar = UISearchBar(frame: .zero)
    var collectionView: UICollectionView! = nil
    var viewModel = BasicGridViewModel()
    var nameFilter: String?
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
        performQuery(with: nil)                
    }
    
    //MARK: - UI Configuration
    func configureHierarchy() {
        view.backgroundColor = .systemBackground
        let layout = self.getMountainsExampleLayout()
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        view.addSubview(searchBar)

        let views = ["cv": collectionView, "searchBar": searchBar]
        var constraints = [NSLayoutConstraint]()
        constraints.append(contentsOf: NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[cv]|", options: [], metrics: nil, views: views))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(
            withVisualFormat: "H:|[searchBar]|", options: [], metrics: nil, views: views))
        constraints.append(contentsOf: NSLayoutConstraint.constraints(
            withVisualFormat: "V:[searchBar]-20-[cv]|", options: [], metrics: nil, views: views))
        constraints.append(searchBar.topAnchor.constraint(
            equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1.0))
        NSLayoutConstraint.activate(constraints)
        collectionView.delegate = self
        self.collectionView = collectionView

        searchBar.delegate = self
    }
    
    //MARK: - Data Source Configuration
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView
            .CellRegistration<LabelCell, BasicGridViewModel.Mountain> {
                                (cell, indexPath, mountain) in
                                
                cell.label.text = mountain.name
        }
        
        dataSource = UICollectionViewDiffableDataSource
                    <Section, BasicGridViewModel.Mountain>(collectionView: collectionView) {
            
                    (collectionView: UICollectionView,
                    indexPath: IndexPath,
                    identifier: BasicGridViewModel.Mountain) -> UICollectionViewCell? in
            
            return collectionView
                    .dequeueConfiguredReusableCell(using: cellRegistration,
                                                   for: indexPath,
                                                   item: identifier)
        }
    }
    
    // MARK: - Query
    func performQuery(with filter: String?) {
        let mountains = viewModel.filteredMountains(with: filter).sorted { $0.name < $1.name }

        var snapshot = NSDiffableDataSourceSnapshot<Section, BasicGridViewModel.Mountain>()
        snapshot.appendSections([.main])
        snapshot.appendItems(mountains)
        dataSource.apply(snapshot, animatingDifferences: true)
        /*
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let newMountains = mountains.map({BasicGridViewModel.Mountain(name:("\($0.name)+Test"),height: $0.height)})
            
            var snapshot = NSDiffableDataSourceSnapshot<Section, BasicGridViewModel.Mountain>()
            snapshot.appendSections([.main])
            snapshot.appendItems(newMountains)
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
         */
    }

}

extension MountainListExample: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        print("willDisplay:\(indexPath)")
    }
}

extension MountainListExample: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performQuery(with: searchText)
    }
}
