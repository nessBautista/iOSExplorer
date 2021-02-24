//
//  TiltShiftOperation.swift
//  CombineUtils
//
//  Created by Nestor Hernandez on 08/02/21.
//
import Combine
import UIKit

class TiltShiftOperation: ObservableObject {
    @Published var outputImage: UIImage?
    private static let context = CIContext()
    var inputImage: UIImage?
    
    init(inputImage: UIImage) {
        self.inputImage = inputImage
        if let input = self.inputImage {
            DispatchQueue.global(qos: .userInteractive).async {
               self.filterImage(image: input)
            }
        }
    }
    
    func filterImage(image: UIImage) {
        //Perform filter operation
        guard let filter = TiltShiftFilter(image: image),
              let output = filter.outputImage else {
            self.outputImage = nil
            print("Failed to generate tilt shift image")
            return
        }
        //CIImage -> CGImage
        let fromRect = CGRect(origin: .zero, size: inputImage!.size)
        guard let cgImage = TiltShiftOperation
                .context
                .createCGImage(output, from: fromRect) else {
            self.outputImage = nil
            print("Failed to generate tilt shift image")
            return
        }
        
        let uiImage = UIImage(cgImage: cgImage)
        DispatchQueue.main.async {
            self.outputImage = uiImage
            print(">>> filterImage done <<<")
        }        
        
    }
}
