import UIKit

var str = "Hello, playground"

//Lets subclass the Operation class to implement an Asynchronous operation


class AsyncOperation: Operation {
    enum State: String {
        
        case Ready, Executing, Finished
        
        fileprivate var keyPath: String {
            return "is" + rawValue
        }
    }
    
    var state = State.Ready {
        willSet {
            //broadcast the change for the new incomming value
            willChangeValue(forKey: newValue.keyPath)
            //and the current state value
            willChangeValue(forKey: state.keyPath)
        }
        didSet{
            //We also need to broadcast one the change is done
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
}

//Operation Overrides
extension AsyncOperation {
    override var isReady: Bool {
        return super.isReady && state == .Ready
    }
    
    override var isExecuting: Bool {
        return state == .Executing
    }
    
    override var isFinished: Bool {
        return state == .Finished
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override func start() {
        if isCancelled {
            state = .Finished
            return
        }
        main()
        state = .Executing
    }
    
    override func cancel() {
        state = .Finished
    }
}

class SumOperation: AsyncOperation {
    let lhs:Int
    let rhs:Int
    var result:Int?
    
    init(lhs:Int, rhs:Int) {
        self.lhs = lhs
        self.rhs = rhs
        super.init()
    }
    
    override func main() {
        asyncAdd_OpQ(lhs: lhs, rhs: rhs) { (result) in
            self.result = result
            self.state  = .Finished
        }
    }
    
    //Simulate some asynchronous operation, maybe an API Call
    private let additionQueue = OperationQueue()
    public func asyncAdd_OpQ(lhs: Int, rhs: Int, callback: @escaping (Int) -> ()) {
      additionQueue.addOperation {
        sleep(1)
        callback(lhs + rhs)
      }
    }
}

//Use the async operation
let additionQueue = OperationQueue()
let input = [(1,5),(4,5),(8,3),(6,12),(1,1),(5, 8)]
for (lhs, rhs) in input {
    let asyncOp = SumOperation(lhs: lhs, rhs: rhs)
    asyncOp.completionBlock = {
        guard let result = asyncOp.result else {return}
        print("\(lhs) + \(rhs) = \(result)")
    }
    additionQueue.addOperation(asyncOp)
}

