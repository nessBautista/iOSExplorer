import Foundation

public typealias HTTPHeaders = [String:String]
public typealias Parameters = [String:Any]

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

public enum HTTPTask {
    case request
    
    case requestParameters(bodyparameters:Parameters?, bodyEncoding: ParameterEncoding, urlParameters:Parameters?)
    
    case requestParametersAndHeaders(bodyparameters:Parameters, bodyEncoding: ParameterEncoding, urlParameters:Parameters?, additionalHeaders:HTTPHeaders?)
    
    //case download, upload...
}

public protocol EndPointType {
    var baseURL:URL {get}
    var path: String {get}
    var httpMethod: HTTPMethod {get}
    var task:HTTPTask {get}
    var headers: HTTPHeaders? {get}
}
