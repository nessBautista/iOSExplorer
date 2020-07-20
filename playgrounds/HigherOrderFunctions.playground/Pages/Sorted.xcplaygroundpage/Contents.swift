//: [Previous](@previous)

import Foundation
/*:
 # Sorted
 
 */
let toSort = [5, 3, 8, 2, 10]
 
let sorted = toSort.sorted()
 
print(sorted)

// Prints [2, 3, 5, 8, 10]

let sorted1 = toSort.sorted(by: {$0 > $1})
print(sorted1)

let sorted2 = toSort.sorted(by: >)
print(sorted1)

/*:
 Sorting can be done in dictionaries too. However the resulting collection is not a dictionary, it is an array of tuples where the first value on each tuple is the key and the second is the value
 */
let temperatures = ["Cairo": 19, "London": 7, "New York": 15, "Athens": 14, "Sydney": 28]
let sortedTemperatures = temperatures.sorted(by: {$0.value > $1.value})
print("sortedTemperatures:\(sortedTemperatures)")

/*:
We can create a new dictionary with the sortedTemperatures tuple array. However the keys and values will be in a random and unsorted order again:
*/

let newDictionary = Dictionary(uniqueKeysWithValues: sortedTemperatures)
print("newDictionary:\(newDictionary)")
/*:
 It's also possible to sort the dictionary in terms of its keys (alphabetical order) . This is possible because the keys are Strings and coform to Comparable protocol.
 */
let sortedCities = temperatures.sorted(by: {$0.key < $1.key})
print("Alphabetical sorted:\(sortedCities)")


 
//: [Next](@next)
