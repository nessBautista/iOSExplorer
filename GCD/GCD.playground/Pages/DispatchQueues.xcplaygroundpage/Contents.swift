//: [Previous](@previous)
import Foundation

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

// get userInitiated global dispatch queue
let userQueue = DispatchQueue.global(qos: .userInitiated)
// get default global queue
let defaultQueue = DispatchQueue.global()
// get main queue
let mainQueue = DispatchQueue.main

func task1(){
	print("task1 started in thread:\(Thread.current)")
	sleep(1)
	print("task1 completed in thread:\(Thread.current)")
}

func task2(){
	print("task2 started in thread:\(Thread.current)")
	
	print("task2 completed in thread:\(Thread.current)")
}

print("===== start using the user initiated global queue =====")
duration {
	print("Starting tasks in thread: \(Thread.current)")
	userQueue.async {
		task1()
	}
	userQueue.async {
		task2()
	}
}
sleep(2)

// Create a private serial queue and run Async tasks
let serialQueue = DispatchQueue(label: "com.lab.serial")
print("===== Using my private serial queue (Asynchronous tasks)=====")
duration{
	print("Starting tasks in thread: \(Thread.current)")
	serialQueue.async {
		task1()
	}
	serialQueue.async {
		task2()
	}
}
sleep(2)

// Now run Synchronous task in the private serial queue
print("===== Using my private serial queue (Synchronous tasks) =====")
print("Notice how synchronous tasks will not run in a different thread, but in the same thread from where they are call, in this case being, the main thread")
duration{
	print("Starting tasks in thread: \(Thread.current)")
	serialQueue.sync {
		task1()
	}
	serialQueue.sync {
		task2()
	}
}
sleep(2)

// Create a private concurrent queue
let concurrentQueue = DispatchQueue(label:"com.lab.concurrent", attributes: .concurrent)
print("\n===== Starting private concurrent Queue =====")
duration {
	print("Starting tasks in thread: \(Thread.current)")
	concurrentQueue.async {
		task1()
	}
	concurrentQueue.async {
		task2()
	}
}

sleep(3)
PlaygroundPage.current.finishExecution()
//PlaygroundPage.current.finishExecution()
//: [Next](@next)
