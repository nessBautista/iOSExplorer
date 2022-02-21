
import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()
//MARK: - Default Combine Publishers
// There are different types of publishers
// The most common are the ones that are provided by Combine
// And other frameworks: Notification Center, URLSession, etc.
/*

example(of: "URLSession") {
    let session = URLSession.shared
    let url = URL(string: "https://www.google.com")!
    let publisher = session.dataTaskPublisher(for: url)
    
    publisher.sink { completion in
        print(completion)
    } receiveValue: { (data: Data, response: URLResponse) in
        print(response)
    }.store(in: &subscriptions)
    
}
*/

//MARK: - Made Publishers
/* There other types of publishers you can construct
 from instances of your code, for example
 From Primitives
 - Just -> creates a publisher from a primitive
 For Imperative Code
 - PassthroughtSubject -> Publish new values on demand, you control what is send and the completion event
 - CurrentValueSubject -> same as Passthrough but also Hangs on to the most recent value
 - Future-> to translate async code to Combine Publisher
 */
example(of: "PassthroughSubject") {
    // Create publisher
    let subject = PassthroughSubject<String, Never> ()
    // Create subscription
    let subscription = subject
        .sink(receiveCompletion:{
                print("completion: \($0)")
        },receiveValue: {
            print("receivedValue: \($0)")
        })
    // Send something to the publisher
    subject.send("Hello")
    subject.send("World")
    // Cancel subscription
    subscription.cancel()
    subject.send("still there?")
}

example(of: "CurrentValueSubject") {
    // Create publisher
    let subject = CurrentValueSubject<Int, Never> (0)
    // Create subscription
    let subscription = subject
        .print()
        .sink(receiveCompletion:{
                print("completion: \($0)")
        },receiveValue: {
            print("receivedValue: \($0)")
        })
    print("Current Value: \(subject.value)")
    // Send something to the publisher
    subject.send(1)
    subject.send(2)
    print("Current Value: \(subject.value)")
    // Cancel subscription
    subscription.cancel()
    subject.send(3)
}

example(of: "Future") {
    
    // Create a function that returns a Future Promise
    func futureIncrement(integer: Int,
                         delay: TimeInterval)
                            -> Future<Int, Never> {
        Future<Int, Never> { promise in
            DispatchQueue.global().asyncAfter(deadline: .now()+delay) {
                promise(.success(integer+1))
            }
        }
    }
    
    let publisher = futureIncrement(integer: 1, delay: 3)
    
    publisher
        .sink(receiveValue:{ print("increment \($0)")} )
        .store(in: &subscriptions)
    
}
