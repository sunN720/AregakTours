import Foundation

protocol NetworkRequest {
    
    var headers: [String: String] { get }
    var apiUri: String { get }
}

extension NetworkRequest {
    
    var headers: [String: String] { return ["": ""] }
    var apiUri: String { return "https://api.coindesk.com/v1/bpi" }
    var apiLocalUrl: String {
        let filePath = Bundle.main.path(forResource: "tours", ofType: "json")
        if let filePath = filePath {
            return filePath
        }
        return ""
    }
}
