//
//  UpbitMarketService.swift
//  LaunchProject
//
//  Created by 조다은 on 3/26/25.
//

import Foundation
import Combine

class UpbitMarketService {
    
    func fetchMarket() -> AnyPublisher<Markets, Error> {
        guard let url = URL(string: "https://api.upbit.com/v1/market/all") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Markets.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main) // RxSwift ObserveOn
            .eraseToAnyPublisher()
    }
    
}
