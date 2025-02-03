//
//  NetworkManager.swift
//  MySeventhProject
//
//  Created by 조다은 on 2/3/25.
//

import Foundation
import Alamofire

struct Lotto: Decodable {
    let drwNo1: String
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func getLotto(successHandler: @escaping (Lotto) -> Void,
                  failHandler: @escaping (AFError) -> Void) {
        
        AF.request("https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1154")
            .validate(statusCode: 200..<500)
            .responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    successHandler(value)
                case .failure(let error):
                    print(error)
                    failHandler(error)
                }
            }
    }
    
    func getLotto2(completionHandler: @escaping (Lotto?, AFError?) -> Void) {
        
        AF.request("https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1154")
            .validate(statusCode: 200..<500)
            .responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    completionHandler(value, nil)
                case .failure(let error):
                    print(error)
                    completionHandler(nil, error)
                }
            }
    }
    
    // 일어나지 않을 상황에 대해서 미리 방지
    func getLotto3(completionHandler: @escaping (Result<Lotto, AFError>) -> Void) {
        
        AF.request("https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1154")
            .validate(statusCode: 200..<500)
            .responseDecodable(of: Lotto.self) { response in
                switch response.result {
                case .success(let value):
                    print(value)
                    completionHandler(.success(value))
                case .failure(let error):
                    print(error)
                    completionHandler(.failure(error))
                }
            }
    }
    
}
