//
//  DemoFlowLayout.swift
//  GridsLab
//
//  Created by Nestor Hernandez on 30/06/22.
//

import Foundation
import UIKit
import Combine

class DemoFlowLayoutViewController: UIViewController{
	weak var collectionView: UICollectionView!
	let viewModel: DemoFlowLayoutViewModel = DemoFlowLayoutViewModel()
	weak var treeActivationButton:UIButton!
	var subscriptions = Set<AnyCancellable>()
	override func loadView() {
		super.loadView()
		// create top button
		let button = UIButton(frame: CGRect(x: 0, y: 300, width: UIScreen.main.bounds.width,
											height: 200))
		button.setTitle("display tree levels", for: .normal)
		button.backgroundColor = .blue
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(displayTreeLevels), for: .touchDown)
		view.addSubview(button)
		self.treeActivationButton = button
		// create collection
		let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
		cv.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(cv)
		self.collectionView = cv
		
		// Button constraints
		NSLayoutConstraint.activate([
			button.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
			button.bottomAnchor.constraint(equalTo: cv.topAnchor),
			button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			button.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
		// Collection constraints
		NSLayoutConstraint.activate([
			cv.topAnchor.constraint(equalTo: button.bottomAnchor),
			cv.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			cv.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			cv.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
	}
	@objc func displayTreeLevels(){
		self.viewModel.treeLevels()
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView.backgroundColor = .white
		
		collectionView.dataSource = self
		collectionView.delegate = self
		
		collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "CollectionCell")
		
		self.observeViewModel()
	}
	private func observeViewModel(){
		self.viewModel.$data.sink { _ in
			self.collectionView.reloadData()
		}.store(in: &subscriptions)
	}
}
extension DemoFlowLayoutViewController: UICollectionViewDataSource {
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		self.viewModel.data.count
	}
	func collectionView(_ collectionView: UICollectionView,
						numberOfItemsInSection section: Int) -> Int {
		self.viewModel.data[section].count
	}
	
	func collectionView(_ collectionView: UICollectionView,
						cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell",
													  for: indexPath) as! CollectionCell
		
		cell.textLabel.text = "\(self.viewModel.data[indexPath.section][indexPath.row])"
		
		return cell
	}
}

extension DemoFlowLayoutViewController: UICollectionViewDelegate{
	
}

class CollectionCell: UICollectionViewCell {
	weak var textLabel: UILabel!
	
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
		
		self.textLabel = label
		self.contentView.backgroundColor = .lightGray
		textLabel.textAlignment = .center
	}
	
	required init?(coder: NSCoder) {
		fatalError("not implemented")
	}
	
}
