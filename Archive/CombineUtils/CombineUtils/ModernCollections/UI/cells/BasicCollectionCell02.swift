//
//  BasicCollectionCell02.swift
//  CombineUtils
//
//  Created by Nestor Hernandez on 14/02/21.
//

import UIKit
import Combine

class BasicCollectionCell02: UICollectionViewCell {
    var imageView: UIImageView!
    var viewModel: BasicGridViewModel.ImageViewModel?
    var subscription: AnyCancellable?
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
    deinit {
        print("deinit:\(viewModel?.identifier) ")
    }
    override func prepareForReuse() {
       
        self.imageView.image = nil
        self.viewModel = nil
        self.subscription?.cancel()
        self.subscription = nil
    }
    
    func load(vm: BasicGridViewModel.ImageViewModel){
        self.viewModel = vm
        self.subscription = self.viewModel?.$image
                            .assign(to: \.image, on: self.imageView)      
    }
}
