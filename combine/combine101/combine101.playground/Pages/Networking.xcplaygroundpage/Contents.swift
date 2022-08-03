//: [Previous](@previous)
import Combine
import Foundation
struct Todo: Codable {
	let userId, id: Int
	let title: String
	let completed: Bool
}

var subscriptions = Set<AnyCancellable>()
example(of: "DataTaskPublisher"){
	guard let url =  URL(string: "https://jsonplaceholder.typicode.com/todos/1") else {
		return
	}
	
		
	URLSession.shared.dataTaskPublisher(for: url)
		.map(\.data)
		.decode(type: Todo.self, decoder: JSONDecoder())
		.sink { completion in
		if case .failure(let error) = completion {
			print("Retreived data failed with error: \(error)")
		}
		
	} receiveValue: { todos in
		print(todos)
	}

	.store(in: &subscriptions)

}

//: [Next](@next)
