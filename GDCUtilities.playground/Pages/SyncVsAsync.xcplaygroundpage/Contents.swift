//: [Previous](@previous)

import Foundation

let mainQueue = DispatchQueue.main
let userQueue = DispatchQueue.global(qos: .userInitiated)
let concurrentQueue = DispatchQueue(label: "gdc.utilities.concurrent.com", attributes: .concurrent)

/*
 Dispatching a synchronous task from the current thread,
 will block the current thread
 */

func dispatchSyncTask(){
    dispatchPrecondition(condition: .onQueue(.main))
    userQueue.sync {
        dispatchPrecondition(condition: .onQueue(userQueue))
        sleep(2)
        print("1--> performing work on the serial queue")
    }
    dispatchPrecondition(condition: .onQueue(.main))
    print("2--> We continue in the main thread")
}
//dispatchSyncTask()

/*
 Given a concurrent Queue. You can use a barrier to execute
 task as if they were in a serial queue:
 */

func dispatchAsyncTaskWithBarrier(){
    dispatchPrecondition(condition: .onQueue(.main))
    
    //This tasks will stop execution for all tasks after it.
    //until this tasks is finihsed
    concurrentQueue.async(flags: .barrier) {
        dispatchPrecondition(condition: .onQueue(concurrentQueue))
        sleep(5)
        print("1--> Task Executing as Barrier")
    }
    dispatchPrecondition(condition: .onQueue(.main))
    concurrentQueue.async() {
        dispatchPrecondition(condition: .onQueue(concurrentQueue))
        sleep(1)
        print("2.1--> task after barrier ")
    }
    concurrentQueue.async() {
        dispatchPrecondition(condition: .onQueue(concurrentQueue))
        sleep(1)
        print("2.2--> task after barrier")
    }
    userQueue.async {
        print("this task is in a diferent queue, and is not affected by the barrier")
    }
}
//dispatchAsyncTaskWithBarrier()

/*
 Apparently this barrier doesn't work on the main thread
 */
func useBarrierInMain(){
    dispatchPrecondition(condition: .onQueue(.main))
    mainQueue.async(flags: .barrier) {
        dispatchPrecondition(condition: .onQueue(.main))
        sleep(3)
        print("1---> this is a barrier tasks")
    }
    dispatchPrecondition(condition: .onQueue(.main))
    print("2---> executed after barrier")
    
}
//useBarrierInMain()

//Notice that barriers doesn't work on global queues:
//https://developer.apple.com/documentation/dispatch/1452917-dispatch_barrier_sync?language=occ
//Only in the queues you created yourself
func dispatchAsyncTaskWithBarrierInUserQueue(){
    dispatchPrecondition(condition: .onQueue(.main))
    
    //This tasks will stop execution for all tasks after it.
    //until this tasks is finihsed
    userQueue.async(flags: .barrier) {
        dispatchPrecondition(condition: .onQueue(userQueue))
        sleep(5)
        print("1--> Task Executing as Barrier")
    }
    dispatchPrecondition(condition: .onQueue(.main))
    userQueue.async() {
        dispatchPrecondition(condition: .onQueue(userQueue))
        sleep(1)
        print("2.1--> task after barrier ")
    }
    userQueue.async() {
        dispatchPrecondition(condition: .onQueue(userQueue))
        sleep(1)
        print("2.2--> task after barrier")
    }
}
dispatchAsyncTaskWithBarrierInUserQueue()
//: [Next](@next)
