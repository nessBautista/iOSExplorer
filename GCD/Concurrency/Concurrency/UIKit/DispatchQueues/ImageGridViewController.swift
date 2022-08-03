//
//  ImageGridViewController.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 12/07/22.
//

import Foundation
import UIKit
class ImageGridViewController: NiblessViewController {
	enum Section {
		case main
	}
	
	let viewModel: ImageGridViewModel
	weak var collection: UICollectionView!
	var dataSource: UICollectionViewDiffableDataSource<Section, UIGridItem>!

	init(viewModel: ImageGridViewModel = ImageGridViewModel()){
		self.viewModel = viewModel
		super.init()
	}
	
	override func loadView() {
		super.loadView()
		let collection = UICollectionView(frame: .zero,
										   collectionViewLayout: UICollectionViewFlowLayout())
		collection.translatesAutoresizingMaskIntoConstraints = false
		self.view.addSubview(collection)
		NSLayoutConstraint.activate([
			collection.topAnchor.constraint(equalTo: view.topAnchor),
			collection.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collection.trailingAnchor.constraint(equalTo: view.trailingAnchor)
		])
		
		self.collection = collection
		self.collection.register(GridCell.self, forCellWithReuseIdentifier: "GridCell")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.setupDataSource()
	}
	
	private func setupDataSource(){
		let dataSource = UICollectionViewDiffableDataSource<Section, UIGridItem>(collectionView: self.collection) { (collection, indexPath, item) in
			guard let cell = collection
					.dequeueReusableCell(withReuseIdentifier: "GridCell",
										 for: indexPath) as? GridCell else {
				fatalError("Nope")
			}
			
			cell.backgroundColor = .purple
			if let image = self.viewModel.images[indexPath.row] {
					cell.display(image: image)
			} else {
					cell.display(image: nil)
			}
			
			self.downloadImageFor(indexPath)
			return cell
		}
		self.dataSource = dataSource
			
		// inital load
		var snapShot = NSDiffableDataSourceSnapshot<Section, UIGridItem>()
		snapShot.appendSections([.main])
		let gridItems = self.viewModel.urlProvider.urls.map({UIGridItem(url:$0)})
		snapShot.appendItems(gridItems,
							 toSection: .main)
		self.dataSource.apply(snapShot)
	}
	
	func downloadImageFor(_ indexPath: IndexPath){
		let taskA = DispatchWorkItem { [weak self] in
			if let url = self?.viewModel.urlProvider.urls[indexPath.row],
			   let rawImage = try? Data(contentsOf: url),
			   let image = UIImage(data:rawImage){
				self?.viewModel.images[indexPath.row] = image
			}
		}
		
		let taskB = DispatchWorkItem{ [weak self] in
			guard let sSelf = self else {return}
			if sSelf.collection.indexPathsForVisibleItems.contains(indexPath) {
				if let cell = sSelf.collection.cellForItem(at: indexPath) as? GridCell {
					cell.display(image: sSelf.viewModel.images[indexPath.row])
				}
			}
		}
		self.viewModel.dispatcher.setUpDependency(A: taskA, B: taskB)
	}
}

class GridCell: UICollectionViewCell {
	var image: UIImageView?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		let image = UIImageView(frame: .zero)
		image.translatesAutoresizingMaskIntoConstraints = false
		self.contentView.addSubview(image)
		NSLayoutConstraint.activate([
			image.topAnchor.constraint(equalTo: contentView.topAnchor),
			image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
			image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
		])
		self.image = image
	}
	
	func display(image: UIImage?) {
		self.image?.image = image
	}
	override func prepareForReuse() {
		super.prepareForReuse()
		self.image?.image = nil
	}

	public required init?(coder: NSCoder) {
		fatalError("Nope")
	}
}

			
																	
