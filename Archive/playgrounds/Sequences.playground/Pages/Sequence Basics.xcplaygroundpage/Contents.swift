//: [Previous](@previous)

import Foundation

struct InfiniteIterator:IteratorProtocol{
    let value:Int
    mutating func next() -> Int? {
        return value
    }
}

var iterator = InfiniteIterator(value: 42)
iterator.next()
iterator.next()

struct InfiniteSequence: Sequence {
    let value:Int
    func makeIterator() -> InfiniteIterator {
        return InfiniteIterator(value: value)
    }
}

print("Get 5 values from InfiniteSequence")
let infinite = InfiniteSequence(value: 42)
for value in infinite.prefix(5){
    print(value)
}



//: [Next](@next)
