//
//  CollectionDemoViewController.swift
//  CompositionalLayout
//
//  Created by Nestor Hernandez on 09/07/22.
//

import Foundation
import UIKit
class CollectionDemoViewController: NiblessViewController {
	enum Section {
		case main
	}
	let viewModel: CollectionDemoViewModel
	weak var collection: UICollectionView!
	var diffableDataSource: UICollectionViewDiffableDataSource<Section,Int>!
	init(viewModel: CollectionDemoViewModel = CollectionDemoViewModel()){
		self.viewModel = viewModel
		super.init()
	}
	
	override func loadView() {
		super.loadView()
		let collection = UICollectionView(frame: .zero,
									  collectionViewLayout: self.configureLayout())
		collection.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(collection)
		NSLayoutConstraint.activate([
			collection.topAnchor.constraint(equalTo: self.view.topAnchor),
			collection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
			collection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			collection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
		])
		self.collection = collection
		//self.collection.dataSource = self
		self.collection.register(SimpleCell.self, forCellWithReuseIdentifier: "SimpleCell")
		
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		configureDataSource()
	}
	private func configureLayout()->UICollectionViewCompositionalLayout {
		//item
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/5),
											  heightDimension: .fractionalHeight(1))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		// Group
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
											   heightDimension: .absolute(44))
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
													   subitems: [item])
		// section
		let section = NSCollectionLayoutSection(group: group)
		//layout
		return UICollectionViewCompositionalLayout(section: section)
	}
	
	private func configureDataSource() {
		self.diffableDataSource = UICollectionViewDiffableDataSource(collectionView: self.collection,
																	 cellProvider: { collectionView, indexPath, item in
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimpleCell",
													 for: indexPath) as? SimpleCell else {
				return UICollectionViewCell()
			}
			cell.label.text = "\(item)"
			return cell
		})
		var snapShop = NSDiffableDataSourceSnapshot<Section, Int>()
		snapShop.appendSections([.main])
		snapShop.appendItems((1...100).map({$0}))
		self.diffableDataSource.apply(snapShop)
	}
}

extension CollectionDemoViewController: UICollectionViewDataSource {
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		1
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimpleCell", for: indexPath) as? SimpleCell{
			cell.label.text = "The Cell Item"
			return cell
		}
		return UICollectionViewCell()
	}
	
}

class SimpleCell: UICollectionViewCell {
	weak var label: UILabel!
	override init(frame: CGRect){
		super.init(frame: frame)
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.addSubview(label)
		NSLayoutConstraint.activate( [
			label.topAnchor.constraint(equalTo: contentView.topAnchor),
			label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
		])
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 20)
		self.label = label
		self.contentView.backgroundColor = .lightGray
	}
	
	required init?(coder: NSCoder) {
		fatalError("not implemented")
	}
}
