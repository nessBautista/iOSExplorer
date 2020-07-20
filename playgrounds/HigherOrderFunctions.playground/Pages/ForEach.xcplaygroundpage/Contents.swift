//: [Previous](@previous)

import Foundation

/*:
 # ForEach
 
 We can understand the forEach as a for-in loop over the elements of a collection. For example
 */
let numbers = [2, 5, 3, 9, 15, 12, 8, 17, 20, 11]
 
for number in numbers {
    number.isMultiple(of: 2) ? print("\(number) is even") : print("\(number) is odd")
}

/*:
The forEach equivalent would be
*/
numbers.forEach({$0.isMultiple(of: 2) ? print("\($0) is even") : print("\($0) is odd")})

/*:
 It often happens to have conditions or to unwrap optionals conditionally inside loops, and we come to the need to break or continue the loop using the break and continue statements respectively as a result of these conditions. Consider the following example:
 */
let numbersWithNil = [5, 15, nil, 3, 9, 12, nil, nil, 17, nil]
 
for number in numbersWithNil {
    guard let number = number else {
        print("Found nil")
        continue
    }
    print("The double of \(number) is \(number * 2)")
}
/*:
 The continue statement shown in the previous code tells the program to move on to the next iteration in case unwrapping number fails in the guard (and after all other operations specified in the else case are finished). Doing the same though in the forEach function is not possible; continue and break statements cannot be used there. Instead, return statement is the only one allowed. Using it, the program will exit from the current closure, however subsequent calls to forEach will be made normally in case there are more elements in the collection. Here’s the equivalent of the above:
 */

numbersWithNil.forEach { (number) in
    guard let number = number else {
        print("forEachOperation:Found nil")
        return
    }
    print("forEachOperation:The double of \(number) is \(number * 2)")
}
//: [Next](@next)
