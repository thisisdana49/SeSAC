//
//  NetworkManager.swift
//  MyFourthProject
//
//  Created by 조다은 on 1/16/25.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}

//    func callKakaoBookAPI(query: String, page: Int) -> Book {
//        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)&size=20&page=\(page)"
//
//        let headers: HTTPHeaders = ["Authorization": "KakaoAK \(apiKey)"]
//        
//        AF.request(url, method: .get, headers: headers)
//            .validate(statusCode: 200..<300)    // default로 숨어있음
//        //            .validate(statusCode: 200..<500)    // success에서 다함께 처리하고 싶다? 넓~게 잡아서 처리함.
//            .responseDecodable(of: Book.self) { response in
//                switch response.result {
//                case .success(let book):
//                    print("success")
//                    return book
//                case .failure(let error):
//                    print(error)
//                }
//            }
//    }
    
    func callKakaoBookAPI(query: String, page: Int, completionHandler: @escaping (Book) -> Void) {
        let url = "https://dapi.kakao.com/v3/search/book?query=\(query)&size=20&page=\(page)"

        let headers: HTTPHeaders = ["Authorization": "KakaoAK \(apiKey)"]
        
        AF.request(url, method: .get, headers: headers)
            .validate(statusCode: 200..<300)    // default로 숨어있음
        //            .validate(statusCode: 200..<500)    // success에서 다함께 처리하고 싶다? 넓~게 잡아서 처리함.
            .responseDecodable(of: Book.self) { response in
                switch response.result {
                case .success(let book):
                    print("success")
                    completionHandler(book)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func randomUser(completionHandler: @escaping (String) -> Void) {
        let url = "https://randomuser.me/api/?results=50"
        AF.request(url, method: .get).responseDecodable(of: User.self) { response in
            switch response.result {
            case .success(let value):
                //                self.nameLabel.text = value.results[Int.random(in: 0..<50)].name.last
                print("success", value.results[0].name.last)
                
                let result = value.results[0].name.last
                completionHandler(result)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
