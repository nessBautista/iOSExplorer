//: [Previous](@previous)

import Foundation

struct Product: Comparable {
    var name: String
    var kind: String
    var value: Int
    
    static func < (lhs: Product, rhs: Product) -> Bool {
        if lhs.value != rhs.value {
            return lhs.value < rhs.value
        }
        return false
    }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.value == rhs.value
    }
}

let keyPath = \Product.name

let product = Product(name: "iPhone 11", kind: "Apple", value: 10)
let phones = [Product(name: "iPhone 11", kind: "Apple", value: 10),
              Product(name: "iPhone 11 PRO", kind: "Apple", value: 15),
              Product(name: "Galaxy 11", kind: "Samsung", value: 9),
              Product(name: "Google", kind: "Google", value: 7)]
              
product[keyPath: \.kind]

extension Sequence {
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        self.sorted { (a, b) -> Bool in
           return a[keyPath: keyPath] < b[keyPath: keyPath]
        }
    }
}

let sortedPhones = phones.sorted(by:\.value)
let sortedPhonesTitles = phones.map(\.name)
//: [Next](@next)
