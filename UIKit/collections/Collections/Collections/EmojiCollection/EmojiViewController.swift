//
//  EmojiViewController.swift
//  Collections
//
//  Created by Nestor Hernandez on 08/07/22.
//

import Foundation
import UIKit
class EmojiViewController: NiblessViewController {
	let viewModel: EmojiViewModel =  EmojiViewModel()
	let coordinator: AppNavigation
	var collection: UICollectionView!
	public init(coordinator: AppNavigation){
		self.coordinator = coordinator
		super.init()
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
		self.collection.register(EmojiCell.self, forCellWithReuseIdentifier: "EmojiCell")
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		self.coordinator.goTo(.home)
	}
}

extension EmojiViewController: UICollectionViewDelegateFlowLayout{
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		let side = (UIScreen.main.bounds.width - 15) / 2
		return CGSize(width: side, height: side)
	}
}

extension EmojiViewController: UICollectionViewDelegate {
	
}
extension EmojiViewController: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if let cell = collectionView
						.dequeueReusableCell(withReuseIdentifier: "EmojiCell",
											 for: indexPath) as? EmojiCell {
			cell.loadEmoji(self.viewModel.emoji[indexPath.row])
			return cell
		}
		return UICollectionViewCell()
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		self.viewModel.emoji.count
	}
	
}

class EmojiCell: UICollectionViewCell {
	weak var stackView: UIStackView!
	weak var emojiLabel: UILabel!
	weak var titleLabel: UILabel!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		let stackView = UIStackView(frame: .zero)
		stackView.axis = .vertical
		stackView.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.addSubview(stackView)
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
			stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
		])
		self.stackView = stackView
		
		let emojiLabel = UILabel()
		emojiLabel.textAlignment = .center
		emojiLabel.font = UIFont.systemFont(ofSize: 140)
		self.emojiLabel = emojiLabel
		
		let titleLabel = UILabel()
		titleLabel.text = "Emoji"
		self.titleLabel = titleLabel
		
		// Add View Hierarchy
		stackView.addArrangedSubview(self.emojiLabel)
		stackView.addArrangedSubview(titleLabel)
		// Some color to identify background
		self.contentView.backgroundColor = .gray
	}
	
	
	
	required init?(coder: NSCoder) {
		fatalError("Not implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		self.emojiLabel.text = ""
	}
	
	func loadEmoji(_ emoji: String){
		self.emojiLabel.text = emoji
	}
}
