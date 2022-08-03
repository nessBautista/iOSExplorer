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

/*assign(to:on) -> Enables you to assign  the received value to KVO compliant
property on an object */
example(of: "assign(to:on)") {
    // Create a publisher
    let publisher = ["Hello World!", "Hi 2"].publisher
    
    
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

/*
assign(to:) is a variation you can use for republish values emitted by
a publisher through another property marked with @Published property wrapper
*/
example(of: "assign(to:)") {
    // This is going to be the main publisher
	// This is the Input
    let publisher = (0..<10).publisher
    
    // This is going to be the Re-Publisher
    class Republisher {
        @Published var value = 0
    }
    // Instantiate object Re-Publisher
    let republisher = Republisher()
    
	// Subscribe to the Re-Publisher
	// This will be the Final Output
	republisher
        .$value
        .sink {
            print("Received Value: \($0)")
        }.store(in: &subscriptions)
    
    // Connect the Main Publisher with the Re-Publisher
    publisher.assign(to: &republisher.$value)
    
}
//: [Next](@next)
