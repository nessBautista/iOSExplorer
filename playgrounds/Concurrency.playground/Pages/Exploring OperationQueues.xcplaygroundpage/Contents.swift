//: [Previous](@previous)

import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
//: # Explore OperationQueue
//: `OperationQueue` is responsible for scheduling and running a set of operations, somewhere in the background.
//: ## Creating a queue
//: Creating a queue is simple, using the default initializer; you can also set the maximum number of queued operations that can execute at the same time:
// TODO: Create printerQueue
let printerQueue = OperationQueue()
// TODO later: Set maximum to 2
printerQueue.maxConcurrentOperationCount = 2 //it will execute 2 operations at a time.
//: ## Adding `Operations` to Queues
/*: `Operation`s can be added to queues directly as closures
 - important:
 Adding operations to a queue is really "cheap"; although the operations can start executing as soon as they arrive on the queue, adding them is completely asynchronous.
 \
 You can see that here, with the result of the `duration` function:
 */
// TODO: Add 5 operations to printerQueue
duration {
    printerQueue.addOperation {print("Hello"); sleep(2)}
    printerQueue.addOperation {print("How"); sleep(2)}
    printerQueue.addOperation {print("are"); sleep(2)}
    printerQueue.addOperation {print("you"); sleep(2)}
    printerQueue.addOperation {print("doing?"); sleep(2)}
}

duration {
    //Careful, waitUntilAllOperationsAreFinished() blocks the current thread
    printerQueue.waitUntilAllOperationsAreFinished()
}


// TODO: Measure duration of all operations

PlaygroundPage.current.finishExecution()


//: [Next](@next)
