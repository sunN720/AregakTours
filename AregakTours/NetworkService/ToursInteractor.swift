import Foundation

protocol ToursInteractorAdaptor {
    
    func fetchTours(_ onComplete: @escaping ([Tour]?, Error?) -> Void)
    func fetchLocalTours(_ onComplete: @escaping ([Tour]?, Error?) -> Void)
}

struct ToursInteractor: ToursInteractorAdaptor, NetworkRequest {
    
    let service: NetworkAdaptor
    
    func fetchTours(_ onComplete: @escaping ([Tour]?, Error?) -> Void) {
        //let uri = "\(apiUri)/historical/close.json?&start=\(startAt)&end=\(endAt)"
        let url = apiLocalUrl
        service.request(url) { (response, error) in
            
        }
    }
   
    func fetchLocalTours(_ onComplete: @escaping ([Tour]?, Error?) -> Void) {
        if let path = Bundle.main.path(forResource: "tours", ofType: "json") {
            do {
                 let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                do {
                    let result = try JSONDecoder().decode([Tour].self, from: data)
                    
                    DispatchQueue.main.async {
                        onComplete(result, nil)
                    }
                    
                }catch let error {
                    
                    print(error.localizedDescription)
                }
            }catch let error {
                
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filepath")
        }
    }
    
}
