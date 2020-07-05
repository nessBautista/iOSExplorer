//
//  TiltShiftOperation.swift
//  OperationQueueEx02_AsyncOpsWithDependencies
//
//  Created by Ness Bautista on 04/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import Foundation

class TiltShiftOperation:ImageFilterOperation{
    override func main() {
        guard isCancelled == false else {return}
        guard let inputImage = filterInput else {return}
        
        guard isCancelled == false else {return}
        let mask = topAndBottomGradient(inputImage.size)
        
        guard isCancelled == false else {return}
        filterOutput = inputImage.applyBlurWithRadius(5, maskImage: mask)
    }
}
