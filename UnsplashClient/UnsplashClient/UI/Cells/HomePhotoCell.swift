//
//  HomePhotoCell.swift
//  UnsplashClient
//
//  Created by Ness Bautista on 08/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import UIKit

class HomePhotoCell: UITableViewCell {

    @IBOutlet weak var imgThumb: UIImageView!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func load(_ photoVM: PhotoVM?){
        if let photo = photoVM {
            self.loadIndicator.stopAnimating()
            self.textLabel?.text = photo.description
            self.imgThumb.image = photo.thumbImg
        } else {
            self.loadIndicator.startAnimating()
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
