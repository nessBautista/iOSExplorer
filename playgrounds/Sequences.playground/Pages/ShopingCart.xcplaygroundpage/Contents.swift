//: [Previous](@previous)

import Foundation

enum CategoryType {
    case vegetables
    case dairy
}
struct Product {
    var name:String
    var category: CategoryType
}
struct ProductCollection {
    typealias DictionaryType = [Category : [Product]]

    // Underlying, private storage, that is the same type of dictionary
    // that we previously was using at the call site
    private var products = DictionaryType()

    // Enable our collection to be initialized with a dictionary
    init(products: DictionaryType) {
        self.products = products
    }
}

extension ProductCollection:Collection {
    
    typealias  Index = DictionaryType.Index
    typealias Element = DictionaryType.Element
    
    var startIndex: Index {
        return products.startIndex
    }
    
    var endIndex: Index {
        return products.endIndex
    }
    subscript(index: Index) -> Iterator.Element {
        get { return products[index] }
    }
    
    // Method that returns the next index when iterating
    func index(after i: Index) -> Index {
        return products.index(after: i)
    }
}

print("heey")

//: [Next](@next)
