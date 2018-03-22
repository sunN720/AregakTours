import Foundation

enum RequestHTTPMethod: String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}

protocol NetworkAdaptor {
    
    func request(_ url: String,
                 method: RequestHTTPMethod,
                 parameters: [String: Any]?,
                 headers: [String: String]?,
                 onComplete: @escaping ((Any?, Error?) -> Void))
}

extension NetworkAdaptor {
    
    func request(_ url: String,
                 method: RequestHTTPMethod = .get,
                 parameters: [String : Any]? = nil,
                 headers: [String: String]? = nil,
                 onComplete: @escaping ((Any?, Error?) -> Void)) {
        
        request(url, method: method,
                parameters: parameters,
                headers: headers,
                onComplete: onComplete)
    }
}
