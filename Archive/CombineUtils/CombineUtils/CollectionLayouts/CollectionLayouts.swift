//
//  CollectionLayouts.swift
//  CombineUtils
//
//  Created by Nestor Hernandez on 10/02/21.
//

import Foundation
import UIKit

extension UIViewController {
    func getMountainsExampleLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
            layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection in
            let contentSize = layoutEnvironment.container.effectiveContentSize
            let columns = contentSize.width > 800 ? 3 : 2
            let spacing = CGFloat(10)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(32))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: columns)
            group.interItemSpacing = .fixed(spacing)

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

            return section
        }
        return layout
    }
    func getSimpleLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func getBasicGrid() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5,
                                                     leading: 5,
                                                     bottom: 5,
                                                     trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalWidth(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    func getNestedLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            
            let leadingItem = NSCollectionLayoutItem(layoutSize:
                                                        NSCollectionLayoutSize(widthDimension:
                                                                                .fractionalWidth(0.7),
                                                                               heightDimension: .fractionalHeight(0.5)))
            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                                leading: 10,
                                                                bottom: 10,
                                                                trailing: 10)
            
            let trailingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)))
            trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                                 leading: 10,
                                                                 bottom: 10,
                                                                 trailing: 10)
            
            let trailingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                                           heightDimension: .fractionalHeight(0.5))
            let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: trailingGroupSize,
                                                                 subitem: trailingItem, count: 5)
            
            
            let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [leadingItem, trailingGroup])
            
            let section = NSCollectionLayoutSection(group: nestedGroup)
            return section
        }
        
        return layout
    }
    
    func getOrthogonalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (section, environment) -> NSCollectionLayoutSection? in
            
            //The leading side
            let leadingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                                         heightDimension: .fractionalHeight(1.0))
            let leadingItem = NSCollectionLayoutItem(layoutSize: leadingItemSize)
            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                                leading: 10,
                                                                bottom: 10,
                                                                trailing: 10)
            
            // The Trailing
            let trailingItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3))
            let trailingItem = NSCollectionLayoutItem(layoutSize: trailingItemSize)
            trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10,
                                                                 leading: 10,
                                                                 bottom: 10,
                                                                 trailing: 10)
            
            let trailingGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                                           heightDimension: .fractionalHeight(1.0))
            let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: trailingGroupSize,
                                                                 subitem: trailingItem,
                                                                 count: 2)
            
            // The container of both leading and trailing
            let containerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
                                                       heightDimension: .fractionalHeight(0.4))
            let containerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: containerSize,
                                                                    subitems: [leadingItem,
                                                                               trailingGroup])
            
            //Finally build the section
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.orthogonalScrollingBehavior = .continuous
            return section
        }
        return layout
    }
    
    func getOrthogonalHeaderSectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (section, environment) -> NSCollectionLayoutSection? in
            if (section % 2 ) == 0 {
                // The top Section
                let headerItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                                               heightDimension: .fractionalHeight(1))
                let headerItem = NSCollectionLayoutItem(layoutSize:  headerItemSize)
                headerItem.contentInsets = NSDirectionalEdgeInsets(top: 5,
                                                                   leading: 5,
                                                                   bottom: 5,
                                                                   trailing: 5)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .fractionalWidth(0.25))
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
//                                                               subitems: [headerItem])
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                   subitem: headerItem,
                                                   count: 3)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                return section
                
            } else {
                //The grid section
                // The top Section
                let gridItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25),
                                                               heightDimension: .fractionalWidth(0.25))
                let gridItem = NSCollectionLayoutItem(layoutSize: gridItemSize)
                gridItem.contentInsets = NSDirectionalEdgeInsets(top: 5,
                                                                 leading: 5,
                                                                 bottom: 5,
                                                                 trailing: 5)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                       heightDimension: .fractionalWidth(0.25))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                               subitems: [gridItem])
                
                let section = NSCollectionLayoutSection(group: group)
                return section
            }
        }
        return layout
    }
}
