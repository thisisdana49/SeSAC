//: [Previous](@previous)

import Foundation
// Testing? Testable?
// => 하는 자체보다 '왜' 해야하는지?
protocol NetworkManagerProvider {
    func callRequest()
}

class NetworkManager: NetworkManagerProvider {
    func callRequest() {
        // Alamofire
    }
}

class MockManager: NetworkManagerProvider {
    func callRequest() {
        // 가짜 데이터 활용
    }
}

// 생성 사용 분리
class LottoViewModel {
    
    let manager: NetworkManagerProvider
    
    init(manager: NetworkManagerProvider) {
        self.manager = manager
    }
    
    func transform() {
        manager.callRequest()
    }
}

import UIKit

class LottoViewController {
    let viewModel: LottoViewModel
    
    init(viewModel: LottoViewModel) {
        self.viewModel = viewModel
    }
    
}

// false: mock, true: 실제 통신
func makeLottoViewController(status: Bool) -> LottoViewController {
    
    let network: NetworkManagerProvider = status ? NetworkManager() : MockManager()
    let viewModel = LottoViewModel(manager: network)
    return LottoViewController(viewModel: viewModel)
}

let network = NetworkManager()
let viewModel = LottoViewModel(manager: network)

viewModel.transform()

/*
 DI, DIP
 Interface
 Concrete Type
 구현체 추상체
 의존 관계
 */

//: [Next](@next)
