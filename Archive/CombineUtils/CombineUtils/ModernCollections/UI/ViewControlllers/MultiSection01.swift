//
//  MultiSection01.swift
//  CombineUtils
//
//  Created by Nestor Hernandez on 15/02/21.
//

import UIKit

class MultiSection01: UIViewController {

    var dataSource: UICollectionViewDiffableDataSource<MultiSection01LayoutType, Int>! = nil
    var collectionView: UICollectionView! = nil
    
    enum MultiSection01LayoutType: Int, CaseIterable {
        case list, grid5, grid3
        var columnCount: Int {
            switch self {
            case .grid5:
                return 5
            case .list:
                return 1
            case .grid3:
                return 3
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UIConfig()
        self.configureDataSource()
        // Do any additional setup after loading the view.
    }
    
    func UIConfig() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    func configureDataSource() {
        let listCellRegistration = UICollectionView.CellRegistration<ListCell, Int> {
            (cell, indexPath, item) in
            
            cell.label.text = "\(item)"
        }
        
        let textCellRegistration = UICollectionView.CellRegistration<TextCell, Int> {
            (cell, indexPath, item) in
            
            cell.label.text = "\(item)"
            cell.contentView.backgroundColor = .cornflowerBlue
            cell.contentView.layer.borderColor = UIColor.black.cgColor
            cell.contentView.layer.borderWidth = 1
            cell.contentView.layer.cornerRadius = MultiSection01LayoutType(rawValue: indexPath.section)! == .grid5 ? 8 : 0
            cell.label.textAlignment = .center
        }
        
        dataSource = UICollectionViewDiffableDataSource<MultiSection01LayoutType, Int>(collectionView: collectionView, cellProvider: {
            (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            return MultiSection01LayoutType(rawValue: indexPath.section)! == .list ?
                collectionView.dequeueConfiguredReusableCell(using: listCellRegistration,
                                                             for: indexPath,
                                                             item: item) :
                collectionView.dequeueConfiguredReusableCell(using: textCellRegistration,
                                                             for: indexPath,
                                                             item: item)
            
        })
        
        let itemPerSection = 10
        var snapShot = NSDiffableDataSourceSnapshot<MultiSection01LayoutType, Int>()
        MultiSection01LayoutType.allCases.forEach {
            snapShot.appendSections([$0])
            let itemOffset = $0.rawValue * itemPerSection
            let itemUpperBound = itemOffset + itemPerSection
            snapShot.appendItems(Array(itemOffset..<itemUpperBound))
        }
        dataSource.apply(snapShot)
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (section, layoutEnvironemt) -> NSCollectionLayoutSection? in
            
            guard let sectionLayoutType = MultiSection01LayoutType(rawValue: section) else {
                return nil
            }
            let columns = sectionLayoutType.columnCount
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 2,
                                                         leading: 2,
                                                         bottom: 2,
                                                         trailing: 2)
            
            let groupHeight = columns == 1 ?
                NSCollectionLayoutDimension.absolute(44) :
                NSCollectionLayoutDimension.fractionalWidth(0.2)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: groupHeight)
            
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                           subitem: item,
                                                           count: columns)
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 20,
                                                            leading: 20,
                                                            bottom: 20,
                                                            trailing: 20)
            return section
            
            
        }
        return layout
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MultiSection01: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
extension UIColor {
    static var cornflowerBlue: UIColor {
        return UIColor(displayP3Red: 100.0 / 255.0, green: 149.0 / 255.0, blue: 237.0 / 255.0, alpha: 1.0)
    }
}
