//: [Previous](@previous)

import Foundation

testSyncPerformsOnTheSameThread()
//testSolutionToDeadLock()
//testSerialQueue()
//testPrivateConcurrentQueue()

func testSyncPerformsOnTheSameThread(){
    //Sync performs the tasks from the same thread where it is called
    //Even though the syn is call on the serialQueue, the execution is made on the main thread
    var val = 42
    let serialQueue = DispatchQueue(label: "gdc.utilities.serial.com")
    func changeValue(){
        dispatchPrecondition(condition: .onQueue(.main))
        sleep(1)
        val = 0
    }
    
    //You can test this by avoiding the execution of changeValue()
    //if it is about to be executed on the main thread
    val
    serialQueue.sync {
        changeValue()
    }
    val
}
func testSolutionToDeadLock(){
    var val = 42 //initial value
    let serialQueue = DispatchQueue(label: "gdc.utilities.serial.com")
    func changeValue(){
        sleep(1)
        val = 0
    }

    /* The function changeValue function is executed on a serial queue, off the main queue
     But `val` is executed inmediately in the main thread, so it shows 42.
     This is a traditional deadlock
     */
    serialQueue.async {
        changeValue()
    }
    val
    
    
    
    /*The solution is to hold the execution of the main thread until the task has finished
     We can do this by changing the execution of changeValue() to a synchronous execution
     */
    val = 42
    serialQueue.sync {
        changeValue()
    }
    val
}

func testPrivateConcurrentQueue() {
    let concurrentQueue = DispatchQueue(label: "gdc.utilities.serial.com", attributes: .concurrent)
    concurrentQueue.async {
        task1 {
            print("completed task1 on ConcurrentQueue")
        }
    }
    concurrentQueue.async {
        task2 {
            print("completed task2 on ConcurrentQueue")
        }
    }
}

func testSerialQueue(){
    //We are running these task on a serial queue
    let serialQueue = DispatchQueue(label: "gdc.utilities.serial.com")
    serialQueue.async {
        task1(onCompletion: {
            print("Done 1")
        })
    }

    serialQueue.async {
        task2(onCompletion: {
            print("Done 2")
        })
    }
}

func task1(onCompletion:(()->(Void))?){
    sleep(3)
    print("hello 1")
    onCompletion?()
}

func task2(onCompletion:(()->(Void))?){
    print("hello 2")
    onCompletion?()
}




//: [Next](@next)
