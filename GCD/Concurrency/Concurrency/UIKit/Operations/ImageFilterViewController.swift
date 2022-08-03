//
//  ImageFilterViewController.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 13/07/22.
//

import Foundation
import UIKit
class ImageFilterViewController: NiblessViewController {
	let viewModel: ImageFilterViewModel
	var collection: UICollectionView!
	var dataSource: UICollectionViewDiffableDataSource<Section, DemoItem>!
	enum Section{
		case main
	}
	
	init(viewModel: ImageFilterViewModel = ImageFilterViewModel()){
		self.viewModel = viewModel
		super.init()
	}
	
	override func loadView() {
		super.loadView()
		let collection = UICollectionView(frame: .zero, collectionViewLayout: self.getCompositionalLayout())
		collection.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(collection)
		NSLayoutConstraint.activate([
			collection.topAnchor.constraint(equalTo: view.topAnchor),
			collection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
		self.collection = collection
		self.collection.register(ImageCellItem.self, forCellWithReuseIdentifier: "ImageCellItem")
		self.setupDataSet()
	}
	
	func getCompositionalLayout()->UICollectionViewCompositionalLayout {
		//item
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
											  heightDimension: .fractionalHeight(1.0))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		//group
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
											   heightDimension: .absolute(200))
		let group =  NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
													  subitems: [item])
		//section
		let section = NSCollectionLayoutSection(group: group)
		return UICollectionViewCompositionalLayout(section: section)
	}
	
	func setupDataSet(){
		let dataSource = UICollectionViewDiffableDataSource<Section, DemoItem>(collectionView: self.collection) { collection, indexPath, item in

			guard let cell = collection.dequeueReusableCell(withReuseIdentifier: "ImageCellItem", for: indexPath) as? ImageCellItem else {
				fatalError()
			}
			let item = self.viewModel.data[indexPath.row]
			let downloadOp = ImageDownloadOperation(url: item.url)
			let filterOp = TiltShiftOperation()
			filterOp.addDependency(downloadOp)
			filterOp.completionBlock = {
				DispatchQueue.main.async {
					guard let cell = self.collection.cellForItem(at: indexPath) as? ImageCellItem, let image = filterOp.output else {
						return
					}
					cell.display(image)
				}
			}
			
			self.viewModel.opQueue.addOperation(downloadOp)
			self.viewModel.opQueue.addOperation(filterOp)
			
			if let image = self.viewModel.data[indexPath.row].image {
				cell.display(image)
			} else {
				cell.display(UIImage(named:"mountains")!)
			}
			return cell
		}
		self.dataSource = dataSource
		// Initial load
		var snapShot = NSDiffableDataSourceSnapshot<Section, DemoItem>()
		snapShot.appendSections([.main])
		snapShot.appendItems(viewModel.data)
		self.dataSource.apply(snapShot)
	}
}
