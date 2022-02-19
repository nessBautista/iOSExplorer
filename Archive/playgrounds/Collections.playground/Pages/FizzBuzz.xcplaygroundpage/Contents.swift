//: [Previous](@previous)

import Foundation

struct FizzBuzz: Collection{
    //We need an associated type for the index.
    //The requirment is that it is comparable
    //Let's make it explicit by using the typealias
    typealias Index = Int
    
    //Continuing with comforming to the Collection protocol
    //We need to define an start and an end index
    var startIndex: Index {
        return 1
    }
    //For this particular example, we know that we will go from 1 to 100 element
    //thus the end index should be ONE PAST THE LAST INDEX (= 101)
    var endIndex: Index {
        return 101
    }
    
    //Define the method for advancing the index
    //Remember to keep things under O(1) complexity
    func index(after i: Index) -> Index{
        return i + 1
    }
    
    //Define the subscript operator
    subscript(index:Index)-> String {
        precondition(indices.contains(index), "out of range")
        switch(index.isMultiple(of: 3), index.isMultiple(of: 5)){
        case (false, false):
            return String(describing: index)
        case (false, true):
            return "Buzz"
        case (true, false):
            return "Fizz"
        case (true, true):
            return "FizzBuzz"
        }
    }
}

//You know have a fizzBuzz collection and you can iterate through it:
for element in FizzBuzz(){
    print(element)
}

//: [Next](@next)
