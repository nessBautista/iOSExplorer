//: [Previous](@previous)

import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

example(of: "collect") {
  ["A", "B", "C", "D", "E"].publisher
		.collect()
		.sink(receiveCompletion: { print($0) },
		  receiveValue: { print($0) })
	.store(in: &subscriptions)
}

example(of: "collect") {
  ["A", "B", "C", "D", "E"].publisher
		.collect(2)
		.sink(receiveCompletion: { print($0) },
		  receiveValue: { print($0) })
	.store(in: &subscriptions)
}

example(of: "map") {
	let formatter = NumberFormatter()
	formatter.numberStyle = .spellOut
	
	[123,4,56].publisher
		.map {
			formatter.string(from: NSNumber(integerLiteral: $0)) ?? String()
		}
		.sink {
			print($0)
		}
		.store(in: &subscriptions)
}

example(of: "mapping key paths") {
	let publisher = PassthroughSubject<Coordinate, Never>()
	publisher
		.map(\.x, \.y)
		.sink { x, y in
			print("x:\(x) y: \(y)")
		}
		.store(in: &subscriptions)
	publisher.send(Coordinate(10,11))
}

example(of: "tryMap") {
	Just("Directory name that doesn't exist")
		.tryMap {
			try FileManager.default
				.contentsOfDirectory(atPath: $0)
		}
		.sink {print($0)}
			receiveValue: {print($0)}
			.store(in: &subscriptions)

}
//: [Next](@next)

