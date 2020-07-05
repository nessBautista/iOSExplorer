//
//  ImageFilterOutputOperation.swift
//  OperationQueueEx02_AsyncOpsWithDependencies
//
//  Created by Ness Bautista on 04/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import UIKit

class ImageFilterOutputOperation:ImageFilterOperation{
    fileprivate let completion:((UIImage?)->())
    
    init(completion: @escaping (UIImage?) ->()) {
        self.completion = completion
        super.init(image: nil)
    }
    
    override func main() {
      if isCancelled { return }
      completion(filterInput)
    }
}
