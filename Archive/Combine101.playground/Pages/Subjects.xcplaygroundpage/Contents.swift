//: [Previous](@previous)

import Foundation
import Combine

//PasstroughSubject
let subject = PassthroughSubject<Int, Never>()
let subscription = subject
    .sink{print($0)}
subject.send(99)

//Connect a subject to a publisher and publish the value 100
Just(100)
    .subscribe(subject)

let anotherSubject = CurrentValueSubject<String, Never>("I am a....")
let anotherSubscription = anotherSubject
    .sink{print($0)}
anotherSubject.send("Subject")
        

let myRange = (0...3)
let _ = myRange.publisher
    .sink(receiveCompletion: {print("completion: \($0)")},
          receiveValue: {print("value:\($0)")})
    
//: [Next](@next)
