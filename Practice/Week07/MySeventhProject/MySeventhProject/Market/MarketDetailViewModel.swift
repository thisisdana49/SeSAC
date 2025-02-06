//
//  MarketDetailViewModel.swift
//  MySeventhProject
//
//  Created by 조다은 on 2/6/25.
//

import Foundation

final class MarketDetailViewModel {
    
    // Market이 전부 필요할 때
//    var outputMarket: Observable<Market?> = Observable(nil)
    // 이름만이 필요할 때
    var outputMarket: Observable<String?> = Observable(nil)
    
    init() {
        print("Market Detail View Model Init")
    }
    
    deinit {
        print("Market Detail View Model Deinit")
    }
    
}
