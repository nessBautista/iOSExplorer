//: [Previous](@previous)

import Foundation

//this returns a type erase sequence of ints
//from a type erased iterator that simple returns a value

func infinite(value:Int) -> AnySequence<Int>{
    return AnySequence<Int> { AnyIterator<Int> {value} }
}

func infiteDetail(value:Int) -> AnySequence<Int> {
    return AnySequence<Int> {
        AnyIterator<Int> {
            return value
        }
    }
}

for value in repeatElement(5, count: 3){
    print(value)
}
//: [Next](@next)
