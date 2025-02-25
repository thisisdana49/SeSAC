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
}

final class NetworkManager {
    
    static let share = NetworkManager()
    
    private init() {}
    
    func callSearch(searchWord: String?, sortWith sortStandard: String?, start: Int?, display: Int?) -> Single<ProductResponse> {
        return Single.create { value in
            
            let url = "https://openapi.naver.com/v1/search/shop.json?query=\(searchWord!)&sort=\(sortStandard!)&start=\(start!)&display=\(display!)"
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
                    print(error)
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
