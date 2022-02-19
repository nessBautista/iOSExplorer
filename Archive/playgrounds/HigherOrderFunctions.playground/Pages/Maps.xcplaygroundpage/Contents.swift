//: [Previous](@previous)

import Foundation


/*:
 
 # Maps
 
 This function performs a operation on all the elements of a collection and returns a new collection wih the results of the operation on the original elements.
 
*/

let numbers = [2, 5, 3, 9, 15, 12, 8, 17, 20, 11]
let doubled = numbers.map({$0 * 2})
print("Doubled Numbers:\(doubled)")

let degrees = [20, 45, 160, 360, 84, 215, 178, 185]
let rads = degrees.map { Double($0) * Double.pi / 180.0 }
print("Degrees Conversion:\(rads)")

/*:
 
 ## Example with custom types
 
*/

struct Store {
    let name:String
    let electronicHardware:[String]
}

let target = Store(name:"Target", electronicHardware:["iPhone","iPad", "Flatscreen TVs"])
let bestBuys = Store(name:"Best Buy", electronicHardware:["Big Fridges", "Laptops"])
let bedBathAndBeyond = Store(name:"Bed Bath & Beyond", electronicHardware:[])

//The basic way of getting all the hardward items
let items = target.electronicHardware + bestBuys.electronicHardware + bedBathAndBeyond.electronicHardware
print(items)


//When using 'map' you would get a multidimensional array:
// [["iPhone", "iPad", "Flatscreen TVs"], ["Big Fridges", "Laptops"], []]
let items2 = [target, bestBuys, bedBathAndBeyond].map({$0.electronicHardware})
print(items2)

/*:
 
 # compactMap
 
 It is very similar to map but there is a key difference. The resulting array doesn't contain any nil values.
 Lets see an example, with the array numbersWithNil which contains some nil elements
 
*/

let numbersWithNil = [5, 15, nil, 3, 9, 12, nil, nil, 17, nil]

/*:
 This  line will cause an error:
        let doubledNums = numbersWithNil.map { $0 * 2 }
 
 "error: "value of optional type 'Int?' must be unwrapped to a value of type 'Int'"
 
 This happens because the map's closure returns an optional value that needs to be extracted before operating over it.
 So it's necessary to perform a long version on map.
 */
let doubledNums = numbersWithNil.map { (number) -> Int? in
    if let number = number {
        return number * 2
    } else {
        return nil
    }
}
print("doubledNums with map: \(doubledNums)")
/*:
 You will notice that the output is:  [Optional(10), Optional(30), nil, Optional(6), Optional(18), Optional(24), nil, nil, Optional(34), nil]
 We still are receiving an array with optionals. This is a great chance to see compact Map in action.
 With compact map we still need to check for optional unwrapping, but the result is returned without any nil element:
 
    notNilDoubled:[10, 30, 6, 18, 24, 34]
*/

let notNilDoubled = numbersWithNil.compactMap { $0 != nil ? $0! * 2 : nil }
print("notNilDoubled:\(notNilDoubled)")

/*:
 We can also use a combination of compactMap and map by:
    1. Obtaining an array without  'nil' elements using compactMap
    2. Using map to perform the doubled operation
 */

let notNilDoubled2 = numbersWithNil.compactMap {$0}.map{$0*2}

print("notNilDoubled2: \(notNilDoubled2)")


//Using 'flatMap' will extract all items and return the result in a single array
// ["iPhone", "iPad", "Flatscreen TVs", "Big Fridges", "Laptops"]
let items3 = [target, bestBuys, bedBathAndBeyond].flatMap({$0.electronicHardware})
print(items3)

/*:
 
 # FlatMap
 flatMap is useful when there are collections inside collections, and we want to merge them into one single collection. For example from:
 [[3, 4, 5], [2, 5, 3], [1, 2, 2], [5, 5, 4], [3, 5, 3]]
 to get:
 [3, 4, 5, 2, 5, 3, 1, 2, 2, 5, 5, 4, 3, 5, 3]

 You can use:
*/

    
let marks = [[3, 4, 5], [2, 5, 3], [1, 2, 2], [5, 5, 4], [3, 5, 3]]
let flatMarks =  marks.flatMap({$0})
print("flatMarks: \(flatMarks)")
//: [Next](@next)
