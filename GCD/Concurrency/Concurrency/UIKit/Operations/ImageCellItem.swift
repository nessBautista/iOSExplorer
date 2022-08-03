//
//  ImageCellItem.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 13/07/22.
//

import Foundation
import UIKit
class ImageCellItem: UICollectionViewCell{
	weak var imageView: UIImageView!
	
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
		self.imageView = image
		self.backgroundColor = .purple
		self.imageView.contentMode = .scaleToFill
	}
	
	override func prepareForReuse() {
		self.imageView.image = nil
	}
	
	func display(_ image: UIImage){
		self.imageView.image = image
	}
	required init?(coder: NSCoder) {
		fatalError("Nop")
	}
}

