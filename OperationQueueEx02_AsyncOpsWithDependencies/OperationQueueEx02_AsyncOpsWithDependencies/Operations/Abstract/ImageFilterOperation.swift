//
//  ImageFilterOperation.swift
//  OperationQueueEx02_AsyncOpsWithDependencies
//
//  Created by Ness Bautista on 04/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import UIKit

protocol ImageFilterDataProvider {
  var image: UIImage? { get }
}

class ImageFilterOperation: Operation {
  var filterOutput: UIImage?
  fileprivate let _filterInput: UIImage?
  
  init(image: UIImage?) {
    _filterInput = image
    super.init()
  }
  
  var filterInput: UIImage? {
    var image: UIImage?
    if let inputImage = _filterInput {
      image = inputImage
    } else if let dataProvider = dependencies
      .filter({ $0 is ImageFilterDataProvider })
      .first as? ImageFilterDataProvider {
        image = dataProvider.image
    }
    return image
  }
}

extension ImageFilterOperation: ImageFilterDataProvider {
  var image: UIImage? {
    return filterOutput
  }
}
