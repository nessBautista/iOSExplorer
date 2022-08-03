//: [Previous](@previous)

import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()
struct Post: Codable {
	var uId:Int
	var id:Int
	var title: String
	var content: String
	
	enum CodingKeys: String, CodingKey{
		case uId = "userId"
		case id
		case title
		case content = "body"
	}
}
struct MyError: Error {
	var content: String
}
let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
URLSession.shared.dataTaskPublisher(for: url)
					.tryMap({ (data, response) in
						try validateResponse(data, response)
					})
					.decode(type: [Post].self, decoder: JSONDecoder())
					.sink { completion in
						if case .finished = completion {
							print("completed")
						}
						if case .failure(let error) = completion {
							if let myError = error as? MyError {
								print(myError.content)
							}
						}
					} receiveValue: { posts in
						posts.forEach({print($0.content)})
					}.store(in: &subscriptions)



func validateResponse(_ data:Data?, _ response: URLResponse) throws -> Data{
//	guard let response = response as? HTTPURLResponse,
//			  response.statusCode == 200 else {
//		throw MyError(content: "HTTP error")
//	}
//	if let data = data {
//		return data
//	}
	throw MyError(content: "Empty data")
}
//: [Next](@next)
