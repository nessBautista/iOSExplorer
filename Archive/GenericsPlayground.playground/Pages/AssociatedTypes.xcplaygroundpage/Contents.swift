import UIKit

protocol Stack {
    associatedtype Element
    var count: Int { get }
    mutating func push(_ element: Element)
    mutating func pop() -> Element?
}

struct IntStack: Stack {
    private var array: [Int] = []
    var count: Int {
        return array.count
    }
    
    mutating func push(_ element: Int) {
        array.append(element)
    }
    
    mutating func pop() -> Int? {
        array.popLast()
    }
}

struct MyStack<Item>: Stack {
    private var values: [Item] = []
    
    var count: Int {
        return values.count
    }
    
    mutating func push(_ element: Item) {
        values.append(element)
    }
    
    mutating func pop() -> Item? {
        values.popLast()
    }
}

var myStringStack = MyStack<String>()
myStringStack.push("a")
myStringStack.push("b")
myStringStack.count
myStringStack.pop()
myStringStack.pop()
myStringStack.count
var myIntStack = MyStack<Int>()
myIntStack.push(1)
myIntStack.push(2)
myIntStack.count
myIntStack.pop()
myIntStack.pop()
myIntStack.count

extension Array: Stack {
    mutating func push(_ element: Element) {
        self.append(element)
    }
    
    mutating func pop() -> Element? {
        return self.popLast()
    }
}

func execeuteOperation<Container: Stack>(container: Container) {
    
}

print("Hello")
