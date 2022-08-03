//: [Previous](@previous)

import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()
let answer = 42
example(of: "allSatisfy in Native Publisher") {
	let targetRange = (-1...100)
	let numbers = [-1, 0, 10, 5]
	numbers.publisher
		.allSatisfy { targetRange.contains($0) }
		.sink { print("\($0)") }
}


example(of: "allSatisfy in Just") {
	Just([1,2,3])
		.allSatisfy { values in
			return values.allSatisfy({$0<10})
		}
		.sink {print("\($0)")}
		.store(in: &subscriptions)
}

example(of: "allSatisfy in PasstroughSubject") {
	let subject = PassthroughSubject<[Int], Never>()
	subject
		.allSatisfy { values in
			return values.allSatisfy({$0<10})
		}
		.map({print($0)})
		.sink {print("\($0)")}
		.store(in: &subscriptions)
	subject.send([2,6])
//	subject.send([2,6,10])
//	subject.send([2,6])
//	subject.send([2,6,10])
}


//: [Next](@next)
