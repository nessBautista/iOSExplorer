//
//  UnsplashClient.swift
//  UnsplashClient
//
//  Created by Ness Bautista on 07/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import Foundation
import Combine
enum UnsplashEndpoit{    
    case photos(page:Int, per_page:Int, order_by:String?)
    case getPhoto(id:Int)
    case getRandomPhoto
    case getPhotoStatistics(id:Int)
    case updatePhoto(id:Int)
    case likePhoto(id:String)
    case unlikePhoto(id:String)
    case search(query:String, page:Int)
}

extension UnsplashEndpoit:EndPointType{
    var environmentBaseURL: String {
        switch UnsplashClient.environment {
        case .qa:
            return "https://api.unsplash.com/"
        case .staging:
            return "https://api.unsplash.com/"
        case .production:
            return "https://api.unsplash.com/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {
            fatalError("Couldn't configure base URL")
        }
        return url
    }
    var path: String {
        switch self {
        case .photos(_, _, _):
            return "photos"
        case .getPhoto(let id):
            return "photos/\(id)"
        case .getRandomPhoto:
            return "photos/random"
        case .getPhotoStatistics(let id):
            return "photos/\(id)/statistics"
        case .updatePhoto(let id):
            return "photos/\(id)"
        case .likePhoto(let id):
            return "photos/\(id)/like"
        case .unlikePhoto(let id):
            return "photos/\(id)/like"
        case .search(let query, let page):
            return "search/photos"
        }
        
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .photos(_, _, _):
            return .get
        case .getPhoto(_):
            return .get
        case .getRandomPhoto:
            return .get
        case .getPhotoStatistics(_):
            return .get
        case .updatePhoto(_):
            return .put
        case .likePhoto(let id):
            return .post
        case .unlikePhoto(let id):
            return .delete
        case .search(let query, let page):
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .photos(let page, let per_page, let order_by):
            var urlParams:Parameters = ["page":page]
            urlParams["per_page"] = per_page
            if let orderBy = order_by {
                urlParams["order_by"] = orderBy
            }
            urlParams["client_id"] = UnsplashClient.UnsplashAPIKey
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: urlParams)
        case .getPhoto(_):
            return .request
        case .getRandomPhoto:
            return .request
        case .getPhotoStatistics(_):
            return .request
        case .updatePhoto(_):
            return .request
        case .likePhoto(let id):
            let urlParams:Parameters = ["client_id":UnsplashClient.UnsplashAPIKey]
            //urlParams["id"] = id
                        
            return .requestParameters(bodyParameters: nil,
            bodyEncoding: .urlEncoding,
            urlParameters: urlParams)
            
        case .unlikePhoto(_):
            return .request
        case .search(let query, let page):
            var urlParams:Parameters = ["client_id":UnsplashClient.UnsplashAPIKey]
            urlParams["query"] = query
            urlParams["page"] = page
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: urlParams)
        }
    }
    
    var headers: HttpHeaders? {
        return ["Authorization":"Client-ID \(UnsplashClient.UnsplashAPIKey)"]
//        switch self {
//        case .photos(_, _, _):
//            return "photos"
//        case .getPhoto(let id):
//            return "photos/\(id)"
//        case .getRandomPhoto:
//            return "photos/random"
//        case .getPhotoStatistics(let id):
//            return "photos/\(id)/statistics"
//        case .updatePhoto(let id):
//            return "photos/\(id)"
//        case .likePhoto(let id):
//            return "photos/\(id)/like"
//        case .unlikePhoto(let id):
//            return "photos/\(id)/like"
//        }
    }
    
    
}

struct UnsplashClient {
    static var environment: NetworkEnvironment = .staging
    static let UnsplashAPIKey = "TVaxbYcLeYTX5HSSlOASUAuZyQ_StH1sfsxehsWL_Oc"
    let router = Router<UnsplashEndpoit>()
    
    func getPhotos(page:Int, completion:@escaping([Photo]?, String?)-> Void) {
        router.request(.photos(page: page, per_page: 10, order_by: nil)) { data, response, error in
            
            guard error == nil else {
                completion(nil, "Please check your network connection.")
                return
            }
             
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    print(responseData)
                    let jsonData = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                    print(jsonData)
                    let photos = try? JSONDecoder().decode([Photo].self, from: responseData)
                    completion(photos,nil)
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
            

        }
    }
    typealias getPhotosResponse = (photos:[Photo]?, errorDescription:String?)
//    func getPhotos(page:Int) -> AnyPublisher<getPhotosResponse, Error> {
//        router.requestPublisher(.photos(page: page, per_page: 10, order_by: nil))
//            .flatMap { (data, response) -> AnyPublisher<getPhotosResponse, Error> in
//                var serializedData: getPhotosResponse = ([Photo](), nil)
//                var error = APIError.unknownError
//
//                return AnyPublisher(
//                    Fail<getPhotosResponse, Error>(error: URLError(.cannotParseResponse))
//                )
//
//            }.eraseToAnyPublisher()
//
//    }
    func getPhotos(page:Int) -> AnyPublisher<getPhotosResponse, Error> {
        router.requestPublisher(.photos(page: page, per_page: 10, order_by: nil))
            .mapError({ (error) -> Error in
                return APIError.unknownError
            })
            .map { (data, response) in
                //let jsonData = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                let photos = try? JSONDecoder().decode([Photo].self, from: data)
                let serializedData: getPhotosResponse = (photos, nil)
                return serializedData
            }.eraseToAnyPublisher()
    }
    
    func likePhoto(id:String, completion:@escaping(String?)-> Void) {
        router.request(.likePhoto(id: id)) { (data, response, error) in
            
        }
    }
    
    func searchPhoto(query:String, page:Int, completion:@escaping([Photo]?, String?)->Void){
        router.request(.search(query: query, page: page)) { (data, response, error) in
            guard error == nil else {
                completion(nil, "Please check your network connection.")
                return
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    print(responseData)
                    let jsonData = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                    print(jsonData)
                    
                    let queryResponse = try? JSONDecoder().decode(UnsplashQueryResponse.self, from: responseData)
                    completion(queryResponse?.results,nil)
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
    enum Result<String>{
        case success
        case failure(String)
    }
}

