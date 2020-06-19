//: [Previous](@previous)

import Foundation

let serialQueue = DispatchQueue(label: "serialqueue.swift.com")
serialQueue.async {
    print("Task 1 started")
    // Do some work..
    print("Task 1 finished")
}
serialQueue.async {
    print("Task 2 started")
    // Do some work..
    print("Task 2 finished")
}

let concurrentQueue = DispatchQueue(label: "concurrentqueue.swift.com", attributes: .concurrent)
serialQueue.async {
    print("concurrent Task 1 started")
    // Do some work..
    print("concurrent Task 1 finished")
}
serialQueue.async {
    print("concurrent Task 2 started")
    // Do some work..
    print("concurrent Task 2 finished")
}
//: [Next](@next)
