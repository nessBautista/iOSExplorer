//: [Previous](@previous)

import Foundation

/*:
 # Reduce
 The purpose of reduce is to produce one valye from the values of all elements in a collection.
 
 */
let numbers = [1,1,1,1,1]
let sum = numbers.reduce(0, {$0 + $1})
print(sum)

/*:
 Remember that the first number of the parameters represents the partial result and not an element in the collection.
 $0 is the partial result and $1 is the element in the array

 More explicitly
 
 */
let sumExplicit = numbers.reduce(0) { (result, number) -> Int in
    return result + number
}
print(sumExplicit)

/*:
 Reduce works with dictionaries as well:
*/
let friendsAndMoney = ["Alex": 150.00, "Tim": 62.50, "Alice": 79.80, "Jane": 102.00, "Bob": 94.20]

let allMoney = friendsAndMoney.reduce(0) { $0 + $1.value}
print("allMoney: \(allMoney)")

/*:
 Watch something interesting in the above line: In order to access each amount in the closure, it’s necessary to use the value property because $1 is not a single value; it’s a (String, Double) key-value pair (a tuple). On the other hand, $0 is a single value as it represents the partial result of the calculation.
 */
//: [Next](@next)
