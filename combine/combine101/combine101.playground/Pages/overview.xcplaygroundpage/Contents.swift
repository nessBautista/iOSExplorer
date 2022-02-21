//: [Previous](@previous)

import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()
example(of: "Publisher") {
    // Create a Publisher
    let center = NotificationCenter.default
    let myNotification = Notification.Name("MyNotification")
    let publisher = center.publisher(for: myNotification)
    
    // Create a Subscriber
    let susbcriber = publisher
        .print()
        .sink { _ in
        print("Notification received")
    }
    
    //Trigger a signal to activate the subscription
    center.post(name: myNotification, object: nil)
    
    // end subscription
    susbcriber.cancel()
}

example(of: "Just") {
  // 1
  let just = Just("Hello world!")

  // 2
  _ = just
    .print()
    .sink(
      receiveCompletion: {
        print("Received completion", $0)
      },
      receiveValue: {
        print("Received value", $0)
    })
    
}

example(of: "assign(to:on)") {
    // Create a publisher
    let publisher = ["Hello World!"].publisher
    
    
    // Define a class
    class SomeObject {
        var value: String = "" {
            didSet{
                print(value)
            }
        }
    }
    // Instantiate class
    let object = SomeObject()
    
    // Subscription: Redirect changes from the publisher
    // to a value within our object
    // Creating a subscription out of this
    let subscription = publisher.assign(to: \.value, on: object)
    subscription.cancel()
    
}

example(of: "assign(to:)") {
    // create a publisher
    let publisher = (0..<10).publisher
    
    // Create an object
    class SomeObject {
        @Published var value = 0
    }
    // Instantiate object
    let object = SomeObject()
    // To see when a value changes inside this object
    // We can subscribe to its Published value
    object
        .$value
        .sink {
            print("Received Value: \($0)")
        }.store(in: &subscriptions)
    
    // Create a subscription
    // Notice this form fo `assign` doesn't return a cancellable
    publisher.assign(to: &object.$value)
    
    
    
    
}
//: [Next](@next)
