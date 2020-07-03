import UIKit

let startString = "2010-12-01"
let endString = "2010-12-10"

let s1 = "2010-12-14"


let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "yyyy-mm-dd"
let start = dateFormatter.date(from: startString)!
let end = dateFormatter.date(from: endString)!
let input1 = dateFormatter.date(from: s1)!

let range = start...end

if range.contains(input1) {
    print("has it")
}

//var dict:[Range<Date>:Int] = [:]
//dict[range] = 1
//print(dict)
var a = "ana"
var b = "aza"
var array = [b,a]
if a < b {
    print(a)
    print(b)
}
