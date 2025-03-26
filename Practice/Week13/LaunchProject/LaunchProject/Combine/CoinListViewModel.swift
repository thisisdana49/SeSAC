//
//  CoinListViewModel.swift
//  LaunchProject
//
//  Created by 조다은 on 3/26/25.
//

import Foundation
import Combine

class CoinListViewModel {
    
    private let marketService: UpbitMarketService
    
    init(marketService: UpbitMarketService) {
        self.marketService = marketService
    }
    
    // Observable - Publisher(pr) - AnyPublisher(struct)
    struct Input {
        let viewOnTask: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let markets: AnyPublisher<Markets, Never>
        let error: AnyPublisher<String?, Never>
        let isLoading: AnyPublisher<Bool, Never>
    }
    
    // 반환 타입이 복잡하고 로직이 변경되면 반환 타입도 변경됨(콘트리트 타입)
    // 구체적으로 명시해야하는 Publisher
    // 어떤 타입인지는 알지만 너무 길고 귀찮음...
    // -> Swift 5.1 Type Eraser (Some, Any, AnyView, AnyPublisher...)
    // 역 제네릭 타입이라고도 불림
    // 제네릭 : 선언할 당시에도 타입이 뭐가 들어올지 모름. 실제 실행할 때 알 수 있음
    // Type Eraser: Opaque Type, 선언할 당시에도 타입을 알고 있다. 근데 보이지 않게 숨기는 것.
    //    func test() -> Publishers.FlatMap<URLSession.DataTaskPublisher, Publishers.SetFailureType<Just<URL>, URLSession.DataTaskPublisher.Failure>> {
    //        let url = URL(string: "https://api.upbit.com/v1/market/all")!
    //        let a  = Just(url)
    //            .flatMap { URLSession.shared.dataTaskPublisher(for: $0) }
    //        return a
    //    }
    
    func test() -> AnyPublisher<String, Never> {
        return Just("Jack").eraseToAnyPublisher()
    }
    
    func transform(input: Input) -> Output {
        let loadingSubject = CurrentValueSubject<Bool, Never>(false)
        let errorSubject = CurrentValueSubject<String?, Never>(nil)
        
        let marketPublisher = input.viewOnTask
            .handleEvents(receiveSubscription: { _ in
                loadingSubject.send(true)
            })
            .flatMap { [weak self] _ -> AnyPublisher<Markets, Never> in
                guard let self = self else {
                    return Empty().eraseToAnyPublisher()
                }
                
                return self.marketService.fetchMarket()
                    .handleEvents(
                        receiveCompletion: { completion in
                            loadingSubject.send(false)
                            
                            if case .failure(let error) = completion {
                                errorSubject.send(error.localizedDescription)
                            }
                        }
                    )
                    .catch { _ -> AnyPublisher<Markets, Never> in
                        return Just([]).eraseToAnyPublisher()
                    }
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        
        // 이벤트를 받으면 로딩을 띄워주는 기능
        // 네트워크 통신을 성공하면 Markets 정보 담기
        /// 에러가
        
        return Output(markets: marketPublisher,
                      error: errorSubject.eraseToAnyPublisher(),
                      isLoading: loadingSubject.eraseToAnyPublisher())
    }
    
}
