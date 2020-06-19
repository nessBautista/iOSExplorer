//: [Previous](@previous)
import Foundation
import PlaygroundSupport

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
        let jsonDecoder = JSONDecoder()        
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

//: [Next](@next)
