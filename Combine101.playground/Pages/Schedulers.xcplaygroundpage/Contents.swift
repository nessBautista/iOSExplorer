//: [Previous](@previous)

import Foundation
import Combine

let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
let queue = DispatchQueue(label: "a queue")
struct Post: Codable {
    let userId:Int
    let id:Int
    let title:String
    let body:String
}

print("Publisher: On main thread?: \(Thread.current.isMainThread)")
print("Publisher: thread info: \(Thread.current)")

let publisher = URLSession.shared.dataTaskPublisher(for: url!)
    .map {$0.data}
    .decode(type:Array<Post>.self, decoder: JSONDecoder())

let cancellableSink = publisher
    .subscribe(on: DispatchQueue(label: "a queue"))
    //.receive(on:DispatchQueue.main)
    .sink(receiveCompletion: { completion in
        print("receiveCompletion")
        print("Subscriber: on main trhead?: \(Thread.current.isMainThread)")
        print("Subscriber: thread info: \(Thread.current)")
    }, receiveValue: { value in
        print("receiveValue")
        print("Subscriber: on main trhead?: \(Thread.current.isMainThread)")
        print("Subscriber: thread info: \(Thread.current)")
    })
//: [Next](@next)
