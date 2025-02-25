//
//  NetworkManager.swift
//  EveryLotto
//
//  Created by 조다은 on 2/24/25.
//

import Foundation
import RxCocoa
import RxSwift

enum APIError: Error {
    case invalidURL
    case unknownResponse
    case statusError
}

final class NetworkManager {
    
    static let share = NetworkManager()
    private init() { }
    
    // 서버 점검으로 인한 더미 데이터...🫠
    private let isMock = false
    
    func callLotto(round: String) -> Observable<Lotto> {
        
        if self.isMock {
            let mockData = Lotto(
                drwNo: 1154,
                drwNoDate: "2025-01-11",
                drwtNo1: 4,
                drwtNo2: 8,
                drwtNo3: 22,
                drwtNo4: 26,
                drwtNo5: 32,
                drwtNo6: 38,
                bnusNo: 27
            )
            return Observable.just(mockData)
        }
        
        return Observable<Lotto>.create { value in

            let url =  "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(round)"
            
            guard let url = URL(string: url) else {
                value.onError(APIError.invalidURL)
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error {
                    value.onError(APIError.unknownResponse)
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    value.onError(APIError.statusError)
                    return
                }
                
                if let data {
                    do {
                        let result = try JSONDecoder().decode(Lotto.self, from: data)
                        dump(result)
                        value.onNext(result)
                        value.onCompleted()
                    } catch {
                        value.onError(APIError.unknownResponse)
                    }
                } else {
                    value.onError(APIError.unknownResponse)
                }
            }.resume()
            return Disposables.create()
        }
    }
    
    func callLottoWithSingle(round: String) -> Single<Lotto> {
        
        if isMock {
            let mockData = Lotto(
                drwNo: 1154,
                drwNoDate: "2025-01-11",
                drwtNo1: 4,
                drwtNo2: 8,
                drwtNo3: 22,
                drwtNo4: 26,
                drwtNo5: 32,
                drwtNo6: 38,
                bnusNo: 27
            )
            return Single.just(mockData)
        }
        
        return Single<Lotto>.create { value in

            let url =  "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(round)"
            
            guard let url = URL(string: url) else {
                value(.failure(APIError.invalidURL))
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error {
                    print(error)
                    value(.failure(APIError.unknownResponse))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    value(.failure(APIError.unknownResponse))
                    return
                }
                
                if let data {
                    do {
                        let result = try JSONDecoder().decode(Lotto.self, from: data)
                        value(.success(result))
                    } catch {
                        value(.failure(APIError.unknownResponse))
                    }
                } else {
                    value(.failure(APIError.unknownResponse))
                }
            }.resume()
            return Disposables.create()
        }

    }

}
