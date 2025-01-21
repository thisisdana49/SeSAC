//
//  PhotoManager.swift
//  MyFifthProject
//
//  Created by 조다은 on 1/21/25.
//

import Foundation
import Alamofire

// 열거형 - @frozen, @unknown ==> 겨울왕국
// 열거형 케이스가 앞으로 추가될 일이 절대 100% 무슨 일이 있어도 발생하지 않는다면 frozen
// @frozen >>> 컴파일 상의 최적화에 약간의 도움이 됨 => Frozen Enumeration
// 그 반대는 Unfrozen Enumeration이라 부르고, 대부분의 열거형이 이 경우에 해당이 됨


// 열거형 연관값, Associated Value
// => Moya, Alamofire URLRequestConvertible
@frozen enum UnsplashRequest {
    case randomPhoto
    case topic(id: String)
    case photo(id: String)
    
    var baseURL: String {
        return "https://api/unsplash.com/"
    }
    
    var endpoint: URL {
        switch self {
        case .randomPhoto:
            return URL(string: baseURL + "photos/random")!
        case .topic(let id):
            return URL(string: baseURL + "topics/\(id)")!
        case .photo(let id):
            return URL(string: baseURL + "photos/\(id)")!
        }
    }
    
    var header: HTTPHeaders {
        return ["Authorization": "Client-ID \(Key.unsplash)"]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        return [
            "page": "1",
            "order_by": "relevant",
            "color": "white"
        ]
    }
}


class PhotoManager {
    
    static let shared = PhotoManager()
    
    private init() { }

    func callRequest(api: UnsplashRequest) {
        
        AF.request(api.endpoint, method: api.method, headers: api.header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: RandomPhoto.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func getRandomPhoto(api: UnsplashRequest, completionHandler: @escaping (RandomPhoto) -> Void, failHandler: @escaping () -> Void) {
        // parameters: 무조건 쿼리스트링은 아님!
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   // HTTP Body일 수도 있음.
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: RandomPhoto.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                    failHandler()
                }
            }
    }
    
    func getAPhoto(api: UnsplashRequest) {
        AF.request(api.endpoint, method: api.method, headers: api.header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: RandomPhoto.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func getATopic(api: UnsplashRequest) {
        AF.request(api.endpoint, method: api.method, headers: api.header)
            .validate(statusCode: 200..<500)
            .responseDecodable(of: Topic.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
