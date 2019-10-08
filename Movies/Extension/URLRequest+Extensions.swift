import Foundation
import UIKit
import RxSwift
import RxCocoa

enum HTTPMethod: String{
    case post   = "Post"
    case get    = "GET"
    case delete = "DELETE"
    case update = "UPDATE"
}

struct Resource<T: Decodable>{
    let url:URL
    
}

extension URLRequest{
    static func load<T>(resource: Resource<T>) -> Observable<T?>{
        return Observable.from([resource.url])
            .flatMap { url -> Observable<(response: HTTPURLResponse, data: Data)> in
                let request = URLRequest(url: url)
                let result  = URLSession.shared.rx.response(request: request)
                return result
            }.map { (response,data) -> T? in
                
                let type:T? = nil
                
                guard let contents = String(data: data, encoding: .utf8) else{
                    return type
                }
                
                let stringToData = "{\"movies\":\(contents)}".data(using: .utf8)
                
                if response.statusCode == 200{
                    do{
                        return try JSONDecoder().decode(T.self, from: stringToData!)
                    }catch{
                        return type
                    }
                }
                return type
                
            }.asObservable()
    }
}
