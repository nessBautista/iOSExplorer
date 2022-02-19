//: [Previous](@previous)

import Foundation
import PlaygroundSupport
/*:
# Data Task with URLRequest
 ### Create a URLRequest. Needs to be a var, so we can modify its properties
*/
let session = URLSession(configuration: .ephemeral)

var request = URLRequest(url: URL(string:"https://jsonplaceholder.typicode.com/posts")!)
request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
request.networkServiceType = .background
request.allowsCellularAccess = false //preserves user data
/*:
 ### Configure the request as a POST request using JSON
 */
request.httpMethod = "POST"
request.addValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
/*:
 ### POST requests need http body
*/
let post = Post(userId: 1, id: 12, title: "US", body: "All together now")
do {
    let jsonEncoder = JSONEncoder()
    let data = try jsonEncoder.encode(post)
    request.httpBody = data
}catch let encodeError as NSError {
    print("Encode error: \(encodeError)")
    PlaygroundPage.current.finishExecution()
}

/*:
 ### Now you can proceed to create a data task
*/

let postTask = session.dataTask(with: request){data, response, error in
    //defer{PlaygroundPage.current.finishExecution()}
    print("asdasdasd")
    guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 201 else {
        return
    }
    
    if let raw = try? String(data: data, encoding: String.Encoding.utf8), let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) {
        print(raw)
        print(json)
    }
    
    do {
        let jsonDecoder = JSONDecoder()
        let post = try jsonDecoder.decode(Post.self, from: data)
        print(post)
    } catch let error as NSError {
        print("Decode error: \(error)")
        return
    }
}

postTask.currentRequest?.httpMethod
postTask.currentRequest?.allHTTPHeaderFields
postTask.currentRequest?.httpBody
postTask.resume()

//: [Next](@next)
