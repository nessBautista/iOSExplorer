//: [Previous](@previous)

import Foundation
import Combine


struct Post: Codable {
    let userId:Int
    let id:Int
    let title:String
    let body:String
}

let samplePost = Post(userId: 1, id: 1, title: " This is a sample post", body: "Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum")

let url = URL(string:"https://jsonplaceholder.typicode.com/posts")

//Create the publisher
let publisher = URLSession.shared.dataTaskPublisher(for: url!)
    .map{$0.data}
    .decode(type: Array<Post>.self, decoder: JSONDecoder())


//Create the subscription
let cancellable = publisher
    .sink(receiveCompletion: { completion in
        print(String(describing:completion))
    }, receiveValue: { value in
        print("returned value:\(value)")
    })
//: [Next](@next)
