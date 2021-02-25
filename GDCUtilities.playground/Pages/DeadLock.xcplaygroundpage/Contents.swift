//: [Previous](@previous)

import Foundation
let mainQueue = DispatchQueue.main
let serialQueue = DispatchQueue.global(qos: .userInitiated)
let concurrentQueue1 = DispatchQueue(label: "gdc.utilities.concurrent1.com", attributes: .concurrent)
let concurrentQueue2 = DispatchQueue(label: "gdc.utilities.concurrent2.com", attributes: .concurrent)

var flag:Bool = false
/**
 Sync method, stops the current queue. If the task you are running within sync, requires
 something to be completed at the current queue, you will create a deadlock.
 */

// In the example below:
// A task is sent from concurrentQueue1 to concurrentQueue2
// Sync will freeze execution on concurrentQueue1
// The task on concurrentQueue2 has a dependency with a thread
// in concurrentQueue1, this creates a loop or: DeadLock
func deadLock(){
    dispatchPrecondition(condition: .onQueue(.main))
    
    concurrentQueue1.async {
        dispatchPrecondition(condition: .onQueue(concurrentQueue1))
        
        //This will stop the current thread
        concurrentQueue2.sync {
            dispatchPrecondition(condition: .onQueue(concurrentQueue2))
            
            while(flag == false) {
                print("waiting for flag sets to true")
            }
        }
        
        dispatchPrecondition(condition: .onQueue(concurrentQueue1))
        flag = true
        print("done")
    }
}

deadLock()
//: [Next](@next)

