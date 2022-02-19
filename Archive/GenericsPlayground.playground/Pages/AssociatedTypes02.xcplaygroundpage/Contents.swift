//: [Previous](@previous)

import Foundation

protocol EndPointType {
    var value: Int {get}
}

class ConcreteEndPoint: EndPointType {
    var value: Int {
        return 5
    }
}

protocol NetworkRouter {
    associatedtype EndPoint: EndPointType
    associatedtype Element
    var value: Int { get }
}

class Router<EndPoint: EndPointType, Element> : NetworkRouter {
        var value: Int {
                return 10
        }

    //Just to be able to use the EndPoint value
        let endpoint: EndPoint

        init(endpoint: EndPoint) {
                self.endpoint = endpoint
        }

        func getEndPointValue() -> Int {
                return self.endpoint.value
        }
}

class A<T> {
    
}



let router = Router<ConcreteEndPoint, Int>(endpoint: ConcreteEndPoint())
router.getEndPointValue()
print("OK")
//: [Next](@next)
