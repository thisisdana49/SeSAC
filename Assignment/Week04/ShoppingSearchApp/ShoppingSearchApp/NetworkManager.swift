//
//  NetworkManager.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/16/25.
//

import Foundation
import Alamofire
import RxSwift

enum APIError: Error {
    case invalidURL
    case unknownResponse
    case statusError
    case apiError(message: String, code: String)
}

final class NetworkManager {
    
    static let share = NetworkManager()
    
    private init() {}
    
    func callSearch(searchWord: String, sortWith sortStandard: String, start: Int, display: Int) -> Single<ProductResponse> {
        return Single.create { value in
            
            let url = "https://openapi.naver.com/v1/search/shop.json?query=\(searchWord)&sort=\(sortStandard)&start=\(start)&display=\(display)"
            let header: HTTPHeaders = [
                "X-Naver-Client-Id": Key.naverClientID,
                "X-Naver-Client-Secret": Key.naverClientSecret
            ]
            
            AF.request(url, method: .get, headers: header)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: ProductResponse.self) { response in
                switch response.result {
                case .success(let item):
                    value(.success(item))
                case .failure(let error):
                    if let data = response.data,
                       let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let errorMessage = json["errorMessage"] as? String,
                       let errorCode = json["errorCode"] as? String {
                        value(.failure(APIError.apiError(message: errorMessage, code: errorCode)))
                    } else {
                        value(.failure(APIError.unknownResponse))
                    }
                }
            }
            return Disposables.create()
        }
    }
    
    func searchItem(searchWord: String, sortWith sortStandard: String, start: Int, display: Int, completionHandler: @escaping (ProductResponse) -> Void) {
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(searchWord)&sort=\(sortStandard)&start=\(start)&display=\(display)"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": Key.naverClientID,
            "X-Naver-Client-Secret": Key.naverClientSecret
        ]
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: ProductResponse.self) { response in
            switch response.result {
            case .success(let value):
                completionHandler(value)

            case .failure(let error):
                print(error)
            }
        }
    }
}
