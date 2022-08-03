//: [Previous](@previous)

import Foundation
import Combine

example(of: "Custom Subscriber") {
	let publisher = (1...6).publisher
	
	final class IntSubscriber: Subscriber {
		typealias Input =  Int
		typealias Failure = Never
		
		func receive(subscription: Subscription) {
			subscription.request(.max(3))
		}
		
		func receive(_ input: Int) -> Subscribers.Demand {
			print("Received value", input)
			return .none
		}
		
		func receive(completion: Subscribers.Completion<Never>) {
			print("Received Completion", completion)
		}
	}
	
	let subscriber = IntSubscriber()
	publisher.subscribe(subscriber)
}

example(of: "Custom Network Subscriber") {
	struct Todo: Codable {
		let userId, id: Int
		let title: String
		let completed: Bool
	}
	
	let session = URLSession.shared
	guard let url =  URL(string: "https://jsonplaceholder.typicode.com/todos/1") else {
		return
	}
	
	let publisher = session.dataTaskPublisher(for: url)
	
	final class NetworkSubscriber: Subscriber {
		typealias Input =  URLSession.DataTaskPublisher.Output
		typealias Failure = URLSession.DataTaskPublisher.Failure
		
		func receive(subscription: Subscription) {
			subscription.request(.max(3))
		}
		
		func receive(_ input: URLSession.DataTaskPublisher.Output) -> Subscribers.Demand {
			print("Received value", input.self)
			guard let response = input.response as? HTTPURLResponse else {
				print("Internal-not received response")
				return .none
			}
			guard response.statusCode >= 200 else {
				print("Internal-not status code less thatn 200")
				return .none
			}
			
			if let output = try? JSONDecoder().decode(Todo.self, from: input.data){
				print("-------------->decoded successfully", output)
				return .max(1)
			}
			
			return .none
		}
		
		func receive(completion: Subscribers.Completion<Failure>) {
			print("Received Completion", completion)
		}
	}
	let subscriber = NetworkSubscriber()
	publisher.subscribe(subscriber)
	
}


//: [Next](@next)
