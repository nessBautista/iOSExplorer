//: [Previous](@previous)


import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # Creating a Complex Operation
//: ## Subclassing `Operation`
//: Allows you more control over precisely what the `Operation` is doing
let inputImage = UIImage(named: "dark_road_small.jpg")
// TODO: Create and run TiltShiftOperation

class TiltShiftOperation:Operation{
    private let inputImage:UIImage?
    var outputImage:UIImage?
    private static let context = CIContext() //Accoding to apple context is thread safe
    
    init(image: UIImage?) {
        inputImage = image
        super.init()
    }
    
    override func main() {
        guard let inputImage = self.inputImage,
            let filter = TiltShiftFilter(image: inputImage),
            let output = filter.outputImage else {
            print("Failed to generate titl shift image")
            return
        }
        let fromRect = CGRect(origin: .zero, size: inputImage.size)
        
        guard let cgImage = TiltShiftOperation.context.createCGImage(output, from: fromRect) else {
            print("no CGImage generated")
            return
        }
        outputImage = UIImage(cgImage: cgImage)
    }
}


let tsOp = TiltShiftOperation(image:inputImage)
duration {
    tsOp.start()
}
tsOp.outputImage

PlaygroundPage.current.finishExecution()


//: [Next](@next)
