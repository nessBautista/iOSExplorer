//
//  ViewController.swift
//  CombineUtils
//
//  Created by Nestor Hernandez on 30/01/21.
//

import UIKit

class ViewController: UIViewController {

    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, HomeItem>! = nil
    var collectionView: UICollectionView! = nil
    let viewModel = HomeViewModel.initHomeContent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Combine Utils"
        configureHierarchy()
        configureDataSource()
    }
    
    @objc func sendToSearchController(){
        let searchVC = CombineSearchVC()
        searchVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(searchVC,
                                                      animated: true)
        
    }

    @objc func sendToImageList() {
        let searchVC = ImageListViewController()
        searchVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(searchVC,
                                                      animated: true)
    }
    
    func sendToBasicGrid() {
        let searchVC = BasicGrid()
        searchVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(searchVC,
                                                      animated: true)
    }
    
    func sendToBasicGrid02() {
        let searchVC = BasicGrid02()
        searchVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(searchVC,
                                                      animated: true)
    }
    
    func sendToMountainsExample(){
        let mountainsVC = MountainListExample()
        mountainsVC.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(mountainsVC,
                                                      animated: true)
    }
    
    func sendToMultiSection01() {
        let multiSection01 = MultiSection01()
        multiSection01.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(multiSection01,
                                                      animated: true)
    }
    
    func sendToOrthogonalSections() {
        let orthogonalSections = OrthogonalSections()
        orthogonalSections.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(orthogonalSections,
                                                      animated: true)
    }
}

extension ViewController {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}


extension ViewController {
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: getSimpleLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView
                            .CellRegistration<UICollectionViewListCell, HomeItem> {
                                (cell, indexPath, item) in
            
                                var content = cell.defaultContentConfiguration()
                                cell.backgroundColor = .white
                                content.text = "\(item.title)"
                                cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource
                    <Section, HomeItem>(collectionView: collectionView) {
            
                    (collectionView: UICollectionView,
                    indexPath: IndexPath,
                    identifier: HomeItem) -> UICollectionViewCell? in
            
            return collectionView
                    .dequeueConfiguredReusableCell(using: cellRegistration,
                                                   for: indexPath,
                                                   item: identifier)
        }

        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, HomeItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(self.viewModel.content)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            self.sendToSearchController()
        case 1:
            self.sendToImageList()
        case 2:
            self.sendToBasicGrid()
        case 3:
            self.sendToBasicGrid02()
        case 4:
            self.sendToMountainsExample()
        case 5:
            self.sendToMultiSection01()
        case 6:
            self.sendToOrthogonalSections()
        default:
            break
        }
    }
}
