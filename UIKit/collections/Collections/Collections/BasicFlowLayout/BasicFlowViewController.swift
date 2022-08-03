//
//  BasicFlowViewController.swift
//  Collections
//
//  Created by Nestor Hernandez on 09/07/22.
//

import Foundation
import UIKit
class BasicFlowViewController: NiblessViewController {
	enum Section {
		case main
	}
	 
	let viewModel: BasicFlowViewModel
	let coordinator: AppNavigation
	var collection: UICollectionView!
	var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
	init(viewModel: BasicFlowViewModel = BasicFlowViewModel(), coordinator: AppNavigation){
		self.viewModel = viewModel
		self.coordinator = coordinator
		super.init()
	}
	
	override func loadView() {
		super.loadView()
		let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
		collection.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(collection)
		NSLayoutConstraint.activate([
			collection.topAnchor.constraint(equalTo: view.topAnchor),
			collection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
		self.collection = collection
		self.collection.delegate = self
		self.collection.register(EmojiCell.self, forCellWithReuseIdentifier: "EmojiCell")
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		self.coordinator.goTo(.home)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.configureDataSource()
	}
	
	private func configureDataSource(){
		self.dataSource = UICollectionViewDiffableDataSource(collectionView: self.collection, cellProvider: { collectionView, indexPath, item in
			guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCell", for: indexPath) as? EmojiCell else {
				return UICollectionViewCell()
			}
			cell.loadEmoji("\(item)")
			return cell
		})
		
		var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
		snapshot.appendSections([.main])
		snapshot.appendItems((1...100).map{$0})
		self.dataSource.apply(snapshot)
	}
}
extension BasicFlowViewController: UICollectionViewDelegate{
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		print(indexPath)
	}
}
