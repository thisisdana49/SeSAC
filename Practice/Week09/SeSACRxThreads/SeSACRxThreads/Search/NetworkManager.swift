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
    
    // Movie -> Result
    func callBoxOfficeWithSingle2(date: String) -> Single<Result<Movie, APIError>> {
        
        return Single<Result<Movie, APIError>>.create { value in

            let url =  "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(Key.apiKey)&targetDt=\(date)"
            
            guard let url = URL(string: url) else {
                value(.failure(APIError.invalidURL))
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error {
//                    value(.failure(APIError.unknownResponse))
                    value(.success(.failure(APIError.unknownResponse)))
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                      (200...299).contains(response.statusCode) else {
                    //value(.failure(APIError.unknownResponse))
                    value(.success(.failure(APIError.invalidURL)))
                    return
                }
                
                if let data {
                    do {
                        let result = try JSONDecoder().decode(Movie.self, from: data)
//                        value(.failure(APIError.unknownResponse))
//                        value(.success(result))
                        value(.success(.success(result)))
                        // flatMap으로 나갈 경우 옵저버블이 계속 쌓임
                        // 값이 전달되었다면 disposed 되도록 해주어야 함 => 스트림 누수 방지
                    } catch {
//                        value(.failure(APIError.unknownResponse))
                        value(.success(.failure(APIError.unknownResponse)))
                    }
                } else {
//                    value(.failure(APIError.unknownResponse))
                    value(.success(.failure(APIError.unknownResponse)))
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

    
    func callBoxOfficeWithSingle(date: String) -> Single<Movie> {
        
        return Single<Movie>.create { value in

            let url =  "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(Key.apiKey)&targetDt=\(date)"
            
            guard let url = URL(string: url) else {
                value(.failure(APIError.invalidURL))
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error {
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
                        let result = try JSONDecoder().decode(Movie.self, from: data)
                        value(.failure(APIError.unknownResponse))
                        value(.success(result))
                        // flatMap으로 나갈 경우 옵저버블이 계속 쌓임
                        // 값이 전달되었다면 disposed 되도록 해주어야 함 => 스트림 누수 방지
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
    
    func callBoxOffice(date: String) -> Observable<Movie> {
        
        return Observable<Movie>.create { value in
            //            value.onNext(<#T##element: Movie##Movie#>)
            //            value.onError(<#T##error: any Error##any Error#>)
            
            let url =  "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(Key.apiKey)&targetDt=\(date)"
            
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
                        value.onError(APIError.statusError)
//                        value.onNext(result)
//                        value.onCompleted()
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
