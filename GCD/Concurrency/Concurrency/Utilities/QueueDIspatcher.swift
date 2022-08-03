//
//  QueueDIspatcher.swift
//  Concurrency
//
//  Created by Nestor Hernandez on 12/07/22.
//

import Foundation
class QueueDispatcher {
	let main = DispatchQueue.main
	let userQueue = DispatchQueue.global(qos: .userInitiated)
	
	func setUpDependency(A: DispatchWorkItem, B: DispatchWorkItem){
		userQueue.async(execute: A)
		A.notify(queue: main, execute: B)
	}
}
