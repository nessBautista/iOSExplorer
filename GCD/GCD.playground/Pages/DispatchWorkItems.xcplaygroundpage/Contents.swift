import UIKit
import Foundation

let mainQueue = DispatchQueue.main
let userQueue = DispatchQueue.global(qos: .userInitiated)

func task1(){
	print("Task 1: Started in thread:\(Thread.current)")
	sleep(2)
	print("Task 1: Finished in thread:\(Thread.current)")
	
}

func task2(){
	print("Task 2: Started in thread:\(Thread.current)")
	print("Task 2: Finished in thread:\(Thread.current)")
}

print(">>>> Runing task2 on the background")
userQueue.async{
	task2()
}
sleep(1)

print(">>>> User work items in userQueue")
print(">>>>>>>>>>using wait of dispatch work item")
let workItem = DispatchWorkItem {
	task1()
}


userQueue.async(execute: workItem)
if workItem.wait(timeout: .now() + 1) == .timedOut {
	print("Tired of waiting")
} else {
	print("Work Item Completed")
}
sleep(2)
