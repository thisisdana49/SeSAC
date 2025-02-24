//
//  NetworkManager.swift
//  SeSACRxThreads
//
//  Created by 조다은 on 2/24/25.
//

import Foundation
import RxCocoa
import RxSwift

struct Movie: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Decodable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Decodable {
    let movieNm, openDt: String
}

enum APIError: Error {
    case invalidURL
    case unknownResponse
    case statusError
}
/*
 completionHandler(Model?)
 
 */
final class NetworkManager {
    
    static let share = NetworkManager()
    
    private init() { }
    
    func callBoxOffice(date: String) -> Observable<Movie> {
        
        return Observable<Movie>.create { value in
            //            value.onNext(<#T##element: Movie##Movie#>)
            //            value.onError(<#T##error: any Error##any Error#>)
            
            let url =  "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=90d82c149d143407371a05bd4d76e2f2&targetDt=\(date)"
            
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
                        let result = try JSONDecoder().decode(Movie.self, from: data)
                        value.onNext(result)
                        value.onCompleted()
                        // flatMap으로 나갈 경우 옵저버블이 계속 쌓임
                        // 값이 전달되었다면 disposed 되도록 해주어야 함 => 스트림 누수 방지
                    } catch {
                        value.onError(APIError.unknownResponse)
                    }
                } else {
                    value.onError(APIError.unknownResponse)
                }
            }.resume()
            return Disposables.create()
        }
        
        //    func callBoxOffice(date: String,
        //                       completionHandler: @escaping ((Result<Movie, APIError>) -> Void)
        //    ) {
        //        let urlString =  "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(Key.apiKey)&targetDt=\(date)"
        //        guard let url = URL(string: urlString) else {
        //            completionHandler(.failure(.invalidURL))
        //            return
        //        }
        //
        //        URLSession.shared.dataTask(with: url) { data, response, error in
        //            if let error = error {
        //                completionHandler(.failure(.unknownResponse))
        //                return
        //            }
        //
        //            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
        //                completionHandler(.failure(.statusError))
        //                return
        //            }
        ////            if let data = data, let appData = try? JSONDecoder().decode(Movie.self, from: data) {
        //            if let data = data {
        //                do {
        //                    let result = try JSONDecoder().decode(Movie.self, from: data)
        //                    completionHandler(.success(result))
        //                } catch {
        //                    completionHandler(.failure(.unknownResponse))
        //                }
        //            } else {
        //                completionHandler(.failure(.unknownResponse))
        //            }
        //        }.resume()
        //    }
        
    }
}
