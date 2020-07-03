//: [Previous](@previous)

import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # Explore Operations
//: An `Operation` represents a 'unit of work', and can be constructed as a `BlockOperation` or as a custom subclass of `Operation`.
//: ## BlockOperation
//: Create a `BlockOperation` to add two numbers
var result: Int?
// TODO: Create and run sumOperation
BlockOperation()
let sumOperation = BlockOperation {
    result = 2 + 3
    sleep(2)
}

duration {
    sumOperation.start()
}
result

//: Create a `BlockOperation` with multiple blocks:
// TODO: Create and run multiPrinter

let multiPrinter = BlockOperation()
multiPrinter.addExecutionBlock {print("Hello"); sleep(2)}
multiPrinter.addExecutionBlock {print("How"); sleep(2)}
multiPrinter.addExecutionBlock {print("are"); sleep(2)}
multiPrinter.addExecutionBlock {print("you"); sleep(2)}
multiPrinter.addExecutionBlock {print("doing?"); sleep(2)}

duration {
    multiPrinter.start()
}
PlaygroundPage.current.finishExecution()
//: [Next](@next)
