import UIKit
import Foundation

let mainQueue = DispatchQueue.main
let userQueue = DispatchQueue.global(qos: .userInitiated)

func task1(){
    print("Task1 started")
    sleep(4)
    print("Task1 finished")
}

func task2(){
    print("Task2 started")
    print("Task2 finished")
}


//Create a dispatch work item
let workItem = DispatchWorkItem {
    task1()
}

//This is executing a dispatch work item
userQueue.async(execute: workItem)

if workItem.wait(timeout: .now() + 3) == .timedOut {
    print("I got tired of waiting")
} else {
    print("Work Item completed")
}
