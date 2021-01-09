import UIKit
import Combine
//WORKING WITH SINK AND ASSIGN

//Sink
[1,5,9]
    .publisher
    .sink{print($0)}
    //prints: 1 5 9 

//Assign
let label = UILabel()
Just("John").map{"My name is: \($0)"}
    .assign(to:\.text, on: label)
