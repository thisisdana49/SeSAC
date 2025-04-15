//
//  NetworkManager.swift
//  SampleProject
//
//  Created by 조다은 on 4/7/25.
//

import Foundation
import Alamofire

protocol NetworkProvider {
    func fetchLotto(completionHandler: @escaping (Lotto) -> Void)
}

class LottoViewModel {
    private let networkManager: NetworkProvider
    
    init(networkManager: NetworkProvider) {
        self.networkManager = networkManager
    }
    
    func transform() {
        networkManager.fetchLotto { lotto in
            print(lotto)
        }
    }
}

class NetworkManager: NetworkProvider {
   
   static let shared = NetworkManager()
   
   private init() { }
    
   let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1000"
   
   func fetchLotto(completionHandler: @escaping (Lotto) -> Void) {
       AF.request(url).responseDecodable(of: Lotto.self) { response in
           switch response.result {
           case .success(let success):
               completionHandler(success)
           case .failure(let failure):
               print(failure)
           }
       }
   }
}
