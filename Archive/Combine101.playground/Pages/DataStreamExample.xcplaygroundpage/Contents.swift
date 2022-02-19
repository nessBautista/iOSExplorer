//: [Previous](@previous)

import Foundation
import Combine
import UIKit

/*
let textfield = UITextField()
textfield.isEnabled = false

[true, false,  true]
    .publisher
    .dropFirst(2)
    .assign(to: \.isEnabled, on: textfield)
print(textfield.isEnabled)
*/
var cancellables = Set<AnyCancellable>()
let textField2 = UITextField()
//(1) create a publisher wichi publishes the following boolean array
let array = [true, false, false, false, false, true, true]
let publisher = array.publisher
//2 create a subscriber to assign to the textfield's Enabled property, when
//publisher emits new data
let subscriber = publisher.assign(to: \.isEnabled, on: textField2)

//we need to track how the value isEnabled changes.
//We can do this by transforming our TextField in a publisher
//so it emmits when its value isEnable changes
let cancellable = textField2.publisher(for: \.isEnabled)
    .sink (receiveCompletion: {print("TextField completion:\($0)")},
           receiveValue: {print("Textfield Did Change: \($0)")})


//(3) Add an operator to drop the first 2 elements from the publisher, before the subscriber assigns to the button
let _ = publisher.dropFirst(2).sink { (completion) in
    print("Operator completion value:\(completion)")
} receiveValue: { (value) in
    print("Operator returns: \(value)")
}

//: [Next](@next)
