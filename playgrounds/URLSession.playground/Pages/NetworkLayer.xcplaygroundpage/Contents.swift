//: [Previous](@previous)

import Foundation

/*:
# Network Layer using a Protocol-Oriented Approach

*/

public typealias NetworkRouterCompletion = (_ data: Data?, _ response:URLResponse?, _ error: Error? ) -> ()










protocol NetworkRouter:class {
    associatedtype EndPoint:EndPointType
    func request(_ route: EndPoint, onCompletion: @escaping NetworkRouterCompletion)
    func cancel()
}

class Router<EndPoint:EndPointType>:NetworkRouter {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, onCompletion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                
                onCompletion(data, response,error)
            })
        } catch {
            onCompletion(nil,nil,error)
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }

    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    fileprivate func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders:HTTPHeaders?, request: inout URLRequest){
        guard let headers = additionalHeaders else {return}
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}












//////////////
enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}
struct NetworkManager {
    static let environment: NetworkEnvironment = .production
    static let MovieAPIKey = "key"
    private let router = Router<MovieApi>()
    
    func getNewMovies(page: Int, completion: @escaping (_ movie: [Movie]?,_ error: String?)->()){
        router.request(.newMovies(page: page)) { data, response, error in
            
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode(MovieApiResponse.self, from: responseData)
                        completion(apiResponse.movies,nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
}


struct MovieApiResponse {
    let page: Int
    let numberOfResults: Int
    let numberOfPages: Int
    let movies: [Movie]
}

extension MovieApiResponse: Decodable {
    
    private enum MovieApiResponseCodingKeys: String, CodingKey {
        case page
        case numberOfResults = "total_results"
        case numberOfPages = "total_pages"
        case movies = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieApiResponseCodingKeys.self)
        
        page = try container.decode(Int.self, forKey: .page)
        numberOfResults = try container.decode(Int.self, forKey: .numberOfResults)
        numberOfPages = try container.decode(Int.self, forKey: .numberOfPages)
        movies = try container.decode([Movie].self, forKey: .movies)
        
    }
}




public enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum MovieApi {
    case recommended(id:Int)
    case popular(page:Int)
    case newMovies(page:Int)
    case video(id:Int)
}

extension MovieApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://api.themoviedb.org/3/movie/"
        case .qa: return "https://qa.themoviedb.org/3/movie/"
        case .staging: return "https://staging.themoviedb.org/3/movie/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .recommended(let id):
            return "\(id)/recommendations"
        case .popular:
            return "popular"
        case .newMovies:
            return "now_playing"
        case .video(let id):
            return "\(id)/videos"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .newMovies(let page):
            return .requestParameters(bodyparameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["page":page,
                                                      "api_key":NetworkManager.MovieAPIKey])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

//: [Next](@next)
