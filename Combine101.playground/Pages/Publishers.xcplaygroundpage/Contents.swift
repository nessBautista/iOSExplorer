//: [Previous](@previous)

import Foundation
import Combine

// A simple publisher using Just, to produce once for each subscriber
let _ = Just("Hello world")
    .sink{ value in
        print("value is \(value)")
    }


//
let notification = Notification(name: .NSSystemClockDidChange, object: nil, userInfo: nil)
let notificationClockPublisher = NotificationCenter.default.publisher(for: .NSSystemClockDidChange)
    .sink(receiveValue: {value in
        print("value is \(value)")
    })
//Trigger notification event
NotificationCenter.default.post(notification)


//Map operation
[1,5,9]
    .publisher
    .map({$0*$0})
    .sink{print($0)}

//Use `decode()`with `map()` to convert a REST responses to an object
let url = URL(string: "http://jsonplaceholder.typicode.com/posts")!

struct Task:Decodable {
    let id: Int
    let title: String
    let userId: Int
    let body:String
}

let dataPublisher =  URLSession.shared.dataTaskPublisher(for: url)
    .map({$0.data})
    .decode(type: [Task].self, decoder: JSONDecoder())
let cancellableSink = dataPublisher
    .sink { (completion) in
        print(completion)
        
    } receiveValue: { (items) in
        print("Number of Received posts: \(items.count)")
        print("Result: \(items[0].title)")
    }


//: [Next](@next)
