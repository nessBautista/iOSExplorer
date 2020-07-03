import UIKit


let testString = "haaacatt"
let range = NSRange(location: 0, length: testString.count)

let regex = try! NSRegularExpression(pattern: "[a-z][0-9]at")

print(regex.firstMatch(in: testString, options: [], range: range))

