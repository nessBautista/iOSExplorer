//
//  TestClient.swift
//  UnsplashClient
//
//  Created by Ness Bautista on 10/07/20.
//  Copyright © 2020 Ness Bautista. All rights reserved.
//

import Foundation

enum TestClientEndpoint{
    case get
    case post(userName:String, tweet:String)
}

extension TestClientEndpoint:EndPointType{
    var environmentBaseURL: String {
        return "https://jsonplaceholder.typicode.com/"
    }
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else {
            fatalError("Couldn't configure base URL")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .get:
            return "get"
        case .post:
            return "posts"
        }
    }
    
    var httpMethod: HttpMethod {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .get:
            return .request
        case .post(let username, let tweet):
            var params:Parameters = ["username":username]
            params["tweet"] = tweet
            return .requestParameters(bodyParameters: params,
                                      bodyEncoding: .jsonEncoding,
                                      urlParameters: nil)
        }
    }
    
    var headers: HttpHeaders? {
        return nil
    }
}

struct TestClient{
    let router = Router<TestClientEndpoint>()
    
    func testPost(userName:String, tweet:String){
        
        router.request(.post(userName: userName, tweet: tweet)){ data, response, error in
            guard error == nil else {
                return
            }
            if let response = response {
                print(response)
            }
            if let data = data {
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    print(json)
                }catch{
                    print(error)
                }
            }
        }
    }
}
