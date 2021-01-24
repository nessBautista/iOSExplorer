//
//  Router.swift
//  UnsplashClient
//
//  Created by Ness Bautista on 07/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import Foundation
import Combine
enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum RemoteError: Error {
    case request(RequestError)

    case response(URLError)

    case decoding(Error)
}
/// Request error definitions
public enum RequestError: Error {
    case badRequest
    case badResponse
    case statusCode(HttpError)
    case unknownError(String)
    case networkError(URLError)

    @available(*, unavailable, renamed: "other")
    case otherError(Error)

    case other(Error?)
}
public enum HttpError: Int {
    // 400 Client Error
    case badRequest = 400
    case unauthorized = 401
    case paymentRequired
    
}
typealias Output = URLSession.DataTaskPublisher.Output

typealias Failure = RemoteError


public typealias NetworkRouterCompletion = (_ data: Data?, _ response:URLResponse?, _ error: Error? ) -> ()

protocol NetworkRouter:class {
    associatedtype EndPoint:EndPointType
    func request(_ route: EndPoint, onCompletion: @escaping NetworkRouterCompletion)
    func cancel()
}



class Router<EndPoint:EndPointType>:NetworkRouter {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, onCompletion: @escaping NetworkRouterCompletion) {
        //TODO: Here we need to specify the type of URL Session: datatask, download task...etc
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
    
    typealias Output =  URLSession.DataTaskPublisher.Output
    func requestPublisher(_ route: EndPoint) -> AnyPublisher<Output, Error> {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            return session.dataTaskPublisher(for: request)
                .mapError { (error) -> Error in
                    switch error.code {
                    case URLError.cannotFindHost:
                    return APIError.networkError(error: error.localizedDescription)
                    default:
                        return APIError.unknownError
                    }
                }
                .flatMap({ (output) -> AnyPublisher<Output, Error> in
                    var result: Result<Output, Error> = .failure(APIError.unknownError)
                    
                    result = .success((data:output.data, response:output.response))
                    return result.publisher.eraseToAnyPublisher()
                })
                .eraseToAnyPublisher()                
        } catch {
            let result: Result<Output, Error> = .failure(APIError.unknownError)
            return result.publisher.eraseToAnyPublisher()
        }
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
            case .download:
                break
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
    
    
    fileprivate func addAdditionalHeaders(_ additionalHeaders:HttpHeaders?, request: inout URLRequest){
        guard let headers = additionalHeaders else {return}
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
    
}






public enum APIError: Error {
    case networkError(error:String)
    case responseError(error:String)
    case unknownError
}
