//
//  BasicCell.swift
//  CombineUtils
//
//  Created by Nestor Hernandez on 08/02/21.
//

import UIKit
import Combine
class BasicCell: UITableViewCell {
    @IBOutlet weak var cellImage: UIImageView!
    weak var viewModel: ImageViewModel?
    var subscription: AnyCancellable?
    let defaultImage: UIImage = {
        return UIImage(named: "2")!
    }()
    
    override func prepareForReuse() {
        self.subscription?.cancel()
        self.viewModel = nil
        print("cancelling for reusing \(viewModel?.url)")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.UIConfig()
    }
    
    func UIConfig(){
        self.selectionStyle = .none
    }
    
    func load(){
        self.subscription = self.viewModel?.$image.sink(receiveValue: { (image) in
            print("got image")
            self.cellImage.image = image
        })
//        self.subscription = self.viewModel?.$image
//            .assign(to: \.image, on: self.cellImage)
        self.viewModel?.fetchImage()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
