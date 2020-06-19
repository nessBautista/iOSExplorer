import Foundation
import PlaygroundSupport

struct Post: Codable {
    let userId: Int
    let id:Int
    let title:String
    let body:String
}

struct PostResponse:Decodable {
    let id:Int
    let post:Post
}

let jsonDecoder = JSONDecoder()
let jsonEncodeer = JSONEncoder()
/*:
# URL Session
Create an URL session with ephemeral configuration. An ephemeral session configuration object is similar to a default session configuration (see default), except that the corresponding session object doesn’t store caches, credential stores, or any session-related data to disk. Instead, session-related data is stored in RAM. The only time an ephemeral session writes data to disk is when you tell it to write the contents of a URL to a file.
*/

let session = URLSession(configuration: .ephemeral)

/*:
 # Data Task with url
 Create a DataTask using just an url with default configuration:
 */

let task = session.dataTask(with: URL(string:"https://jsonplaceholder.typicode.com/posts")!){ data, response, error in
    guard let data = data else {return}
    do{
        
        let posts = try jsonDecoder.decode([Post].self, from: data)
        print(posts.count)
    }catch let decodeError as NSError {
        print(decodeError)
    }
            
}
task.currentRequest?.url
task.currentRequest?.description
task.currentRequest?.httpMethod
task.currentRequest?.allowsCellularAccess // = false //error: currentRequest is read only
task.currentRequest?.httpShouldHandleCookies
task.currentRequest?.timeoutInterval
task.currentRequest?.cachePolicy
task.currentRequest?.networkServiceType
task.currentRequest?.allHTTPHeaderFields
task.currentRequest

task.resume()

/*:
# Data Task with URLRequest
 ### Create a URLRequest. Needs to be a var, so we can modify its properties
*/
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
    let data = try jsonEncodeer.encode(post)
    request.httpBody = data
}catch let encodeError as NSError {
    print("Encode error: \(encodeError)")
    PlaygroundPage.current.finishExecution()
}

/*:
 ### Now you can proceed to create a data task
*/
let postTask = session.dataTask(with: request){data, response, error in
    defer{PlaygroundPage.current.finishExecution()}
    
    guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 201 else {
        return
    }
    
    if let raw = try? String(data: data, encoding: String.Encoding.utf8), let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) {
        print(raw)
        print(json)
    }
    
    do {
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


