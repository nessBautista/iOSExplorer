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
    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblUserLocation: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var btnLike: UIImageView!
    
    var photo:PhotoVM?
    var onDidTapLike:((PhotoVM)->())?
    override func awakeFromNib() {
        super.awakeFromNib()

        self.imgUser.layer.cornerRadius = (self.imgUser.frame.width / 2)
        self.btnLike.isUserInteractionEnabled = true
        self.btnLike.addGestureRecognizer(ActionsTapGestureRecognizer(onTap: {
            print("like image from user:\(self.lblUserName.text)")
            if let photo = self.photo{
                self.onDidTapLike?(photo)
            }
            
        }))
        // Initialization code
    }

    func load(_ photoVM: PhotoVM?){
        if let photo = photoVM {
            self.loadIndicator.stopAnimating()
            self.textLabel?.text = photo.description
            self.imgThumb.image = photo.thumbImg
            self.imgUser.image = photo.user.profileImage
            self.lblUserName.text = photo.user.username
            self.lblUserLocation.text = photo.user.location
            self.lblDescription.text = photo.description
            self.photo = photoVM
            self.btnLike.image = (photoVM?.userLike ?? false) ? UIImage(named:"blueHeartIcon")! : UIImage(named:"blackHeartIcon")!
            
        } else {
            self.loadIndicator.startAnimating()
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
