//
//  NetworkManager.swift
//  WeatherMap
//
//  Created by 조다은 on 2/3/25.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func fetchData<T: Decodable>(
        apiRequest: WeatherAPIRequest,
        requestType: T.Type,
        completionHandler: @escaping (Result<T, AFError>) -> Void) {
        AF.request(apiRequest.endPoint, method: apiRequest.method, parameters: apiRequest.parameters)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(.success(value))
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            }
    }
    
}
