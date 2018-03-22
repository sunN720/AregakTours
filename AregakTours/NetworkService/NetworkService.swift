import Foundation

struct NetworkService: NetworkAdaptor {
    
    private let session = URLSession.shared
 
    func request(_ url: String,
                 method: RequestHTTPMethod = .get,
                 parameters: [String : Any]? = nil,
                 headers: [String: String]? = nil,
                 onComplete: @escaping ((Any?, Error?) -> Void)) {
        
        guard let url = URL(string: url) else {
            onComplete(nil, nil)
            return
        }
 
        var request = URLRequest(url: url,
                                cachePolicy: .reloadIgnoringLocalCacheData,
                                timeoutInterval: 30)
        request.httpMethod = method.rawValue
        
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
                onComplete(nil, error)
                return
            }
            
            onComplete(json, error)
        }.resume()
    }
}
