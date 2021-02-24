//
//  OrthogonalSections.swift
//  CombineUtils
//
//  Created by Nestor Hernandez on 18/02/21.
//

import UIKit

class OrthogonalSections: UIViewController {

    var dataSource: UICollectionViewDiffableDataSource<Int, Int>! = nil
    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.uiConfig()
        self.dataSourceConfig()
    }
    
    func uiConfig() {
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: self.getOrthogonalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        self.view.addSubview(collectionView)
    }
    
    func dataSourceConfig() {
        // Register Cell
        let cellRegistration = UICollectionView.CellRegistration<TextCell, Int> {
            (cell, indexPath, item) in
             
            // load Cell
            cell.label.text = "\(indexPath.section), \(indexPath.item)"
            cell.contentView.backgroundColor = .cornflowerBlue
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.borderWidth = 1
            cell.contentView.layer.cornerRadius = 8
            cell.label.textAlignment = .center
            cell.label.font = UIFont.preferredFont(forTextStyle: .title1)
        }
        
        // Setup datasource
        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView,
                     cellProvider: {
                (collectionView, indexPath, item) -> UICollectionViewCell? in
                let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                                for: indexPath,
                                                                                item: item)
                        return cell
               })
        
        //Init dataSource
        var snapShot = NSDiffableDataSourceSnapshot<Int, Int>()
        var identifierOffset = 0
        let itemsPerSection = 30
        for section in 0..<5{
            snapShot.appendSections([section])
            let maxIdentifier = identifierOffset + itemsPerSection
            snapShot.appendItems(Array(identifierOffset..<maxIdentifier))
            identifierOffset += itemsPerSection
        }
        dataSource.apply(snapShot, animatingDifferences: true)
    }
}

extension OrthogonalSections: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
