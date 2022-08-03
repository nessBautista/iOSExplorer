//
//  HomeViewController.swift
//  Collections
//
//  Created by Nestor Hernandez on 08/07/22.
//

import Foundation
import UIKit
class HomeViewController: NiblessViewController {
	let viewModel: HomeViewModel
	let coordinator: AppNavigation
	var collection: UICollectionView!
	
	init(viewModel: HomeViewModel, coordinator: AppNavigation){
		self.viewModel = viewModel
		self.coordinator = coordinator
		super.init()
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		self.view.backgroundColor = .orange
	}
	
	override func loadView() {
		super.loadView()
		let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
		collection.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(collection)
		
		NSLayoutConstraint.activate([
			collection.topAnchor.constraint(equalTo: self.view.topAnchor),
			collection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
			collection.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
			collection.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
		])
		self.collection = collection
		self.collection.delegate = self
		self.collection.dataSource = self
		self.collection.register(MyCell.self, forCellWithReuseIdentifier: "MyCell")
	}
}
extension HomeViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		self.viewModel.homeItems.count
	}
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? MyCell else {
			return UICollectionViewCell()
		}
		let item = self.viewModel.homeItems[indexPath.row]
		cell.load(item)
		return cell
	}
}
extension HomeViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard indexPath.row < self.viewModel.homeItems.count else {
			return
		}
		let screen = self.viewModel.homeItems[indexPath.row]
		self.coordinator.goTo(screen.menuOption)
	}
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		CGSize(width: collectionView.bounds.size.width - 16, height: 120)
	}
}

class MyCell: UICollectionViewCell {
	weak var label: UILabel?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		contentView.addSubview(label)
		NSLayoutConstraint.activate([
			label.topAnchor.constraint(equalTo: contentView.topAnchor),
			label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
		])
		self.label = label
		self.label?.font = UIFont.systemFont(ofSize: 26)
		self.label?.textAlignment = .left
		self.label?.backgroundColor = .blue
	}
	
	required init?(coder: NSCoder) {
		fatalError("Not implemented")
	}
	
	func load(_ item: HomeItem){
		self.label?.text = item.menuOption.rawValue
	}
}
