//: [Previous](@previous)

import Combine

example(of: "PassthroughSubject") {
  // 1
  enum MyError: Error {
	case test
  }

  // 2
  final class StringSubscriber: Subscriber {
	typealias Input = String
	typealias Failure = MyError

	func receive(subscription: Subscription) {
	  subscription.request(.max(2))
	}

	func receive(_ input: String) -> Subscribers.Demand {
	  print("Received value (custom)", input)
	  // 3
	  return input == "World" ? .max(1) : .none
	}

	func receive(completion: Subscribers.Completion<MyError>) {
	  print("Received completion (custom)", completion)
	}
  }

  // 4
	let subscriber = StringSubscriber()
	let subject = PassthroughSubject<String, MyError>()
	
	// 6 - Subscription 1 via custom subscriber
	subject.subscribe(subscriber)
	
	// 7 Subscription 2 via custom sink
	let subscription = subject
		.sink(
			receiveCompletion: { completion in
				print("Received completion (sink)", completion)
			},
			receiveValue: { value in
				print("Received value (sink)", value)
			}
		)
	
	subject.send("Hello")
	subject.send("World")
	// 8
	subscription.cancel()

	// 9
	subject.send("Still there?")
	
	subject.send(completion: .finished)
	subject.send("How about another one?")
	
	
}
//: [Next](@next)
