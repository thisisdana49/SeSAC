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
