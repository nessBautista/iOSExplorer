//: [Previous](@previous)

import Foundation

let mainQueue = DispatchQueue.main
let userQueue = DispatchQueue.global(qos: .userInitiated)
enum Queues {case mainQ, userQ}
let speficKey = DispatchSpecificKey<Queues>()
mainQueue.setSpecific(key: speficKey, value: .mainQ)
userQueue.setSpecific(key: speficKey, value: .userQ)
func whichQueue(workItem: String){
	switch DispatchQueue.getSpecific(key: speficKey){
	case .mainQ:
		print("\(workItem) is running on main queue")
	case .userQ:
		print("\(workItem) is running on user queue")
	case .none:
		break
	}
}

func task1(){
	print("Task 1: Started in thread:\(Thread.current)")
	sleep(2)
	print("Task 1: Finished in thread:\(Thread.current)")
	
}

func task2(){
	print("Task 2: Started in thread:\(Thread.current)")
	print("Task 2: Finished in thread:\(Thread.current)")
}

// this task represents work performed in the background
let backgroundWorkItem = DispatchWorkItem {
	task1()
	whichQueue(workItem: "backgroundWorkItem")
}
// this task represents work that needs to be performed in the User Interface
let updateUIWorkItem = DispatchWorkItem {
	task2()
	whichQueue(workItem: "updateUIWorkItem")
}

// Build a basic dependency

userQueue.async(execute: backgroundWorkItem)
backgroundWorkItem.notify(queue: mainQueue, execute: updateUIWorkItem)

 

//: [Next](@next)
