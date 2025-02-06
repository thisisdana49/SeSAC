//
//  MarketViewModel.swift
//  SeSACSevenWeek_2
//
//  Created by Jack on 2/6/25.
//

import Foundation
import Alamofire

final class MarketViewModel {
    
    // 어떤 것을 넣어서 관리해도 상관이 없으니 용량 차이가 있으므로 가장 효율적이라고 볼 수 있는 빈 Tuple을 사용
    let inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    let outputTitle: Observable<String?> = Observable(nil)
    let outputMarket: Observable<[Market]> = Observable([])
    
    init() {
        print("MarketViewModel Init")
        
        inputViewDidLoadTrigger.lazyBind { _ in
            print("now start fetch Data")
            self.fetchUpbitMarketAPI()
        }
        
    }
    
    deinit {
        print("MarketViewModel Deinit")
    }
    
    private func fetchUpbitMarketAPI() {
        let url = "https://api.upbit.com/v1/market/all"
        
        AF.request(url).responseDecodable(of: [Market].self) { response in
            switch response.result {
            case .success(let success):
                self.outputMarket.value = success
                self.outputTitle.value = success.randomElement()?.korean_name
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
