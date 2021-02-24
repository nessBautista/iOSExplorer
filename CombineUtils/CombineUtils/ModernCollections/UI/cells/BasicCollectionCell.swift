//
//  BasicCollectionCell.swift
//  CombineUtils
//
//  Created by Nestor Hernandez on 12/02/21.
//

import UIKit

class BasicCollectionCell: UICollectionViewCell {

    var imageView: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView = UIImageView(frame: self.contentView.bounds)        
        self.contentView.addSubview(imageView)
        self.imageView.anchor(top: self.contentView.topAnchor,
                              leading: self.contentView.leadingAnchor,
                              trailing: self.contentView.trailingAnchor,
                              bottom: self.contentView.bottomAnchor)
    }

    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    override func prepareForReuse() {
       
        self.imageView.image = nil
    }
}
