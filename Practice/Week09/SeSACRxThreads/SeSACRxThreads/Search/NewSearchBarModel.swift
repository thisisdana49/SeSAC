//
//  NewSearchBarModel.swift
//  SeSACRxThreads
//
//  Created by 조다은 on 2/24/25.
//

import Foundation
import RxCocoa
import RxSwift

final class NewSearchBarModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let searchTap: ControlEvent<Void>
        let searchText: ControlProperty<String> // Observable이나 UI에 특화, Trait 종류 중 하나
    }
    
    struct Output {
        let list: Observable<[DailyBoxOfficeList]>
    }
    
    // map, withLatestFrom, flatMap, flatMapLatest
    func transform(input: Input) -> Output {
        let list = PublishSubject<[DailyBoxOfficeList]>()
        
        input.searchTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .map {
                guard let text = Int($0) else {
                    return 20250223
                }
                print(text)
                return text
            }
            .map { "\($0)" }
            .flatMap {  // 구독에 구독과 같은 중첩 구조를 사용하지 않기 위해 map 대신에 flatMap을 사용
                // Observable
                NetworkManager.share.callBoxOffice(date: $0)
                    .debug("movie")
                // Single
//                NetworkManager.share.callBoxOfficeWithSingle(date: $0)
//                    .catch { error in
//                        return Single.just(Movie(boxOfficeResult: BoxOfficeResult(dailyBoxOfficeList: [])))
//                    }
//                    .debug("single movie")
            }
            .catch { error in
                // 무조건 하나의 데이터를 주는게 아니라,에러 상황에 따라 적절한 데이터를 반환
//                        switch error as? APIError {
//                        case .invalidURL:
//                        case .statusError:
//                        case .unknownResponse:
//                        default:
//                        }
                
                print("movie error", error)
                return Observable.just(Movie(boxOfficeResult: BoxOfficeResult(dailyBoxOfficeList: [])))
                // Observable.just는 유한한, 한 번만 보내는 객체이기 때문에 tap 입장에서는 이제 끝난 것으로 인식하고 dispose 되는 것
            }
            .debug("tap")
            .subscribe(with: self) { owner, value in
                print("next searchTap", value)
                list.onNext(value.boxOfficeResult.dailyBoxOfficeList)
            } onError: { owner, error in
                print("onError searchTap")
            } onCompleted: { owner in
                print("onCompleted searchTap")
            } onDisposed: { owner in
                print("onDisposed searchTap")
            }
            .disposed(by: disposeBag)
        
        return Output(list: list)
    }
    
    
    func transform2(input: Input) -> Output {
        let list = PublishSubject<[DailyBoxOfficeList]>()
        
        input.searchTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .map {
                guard let text = Int($0) else {
                    return 20250223
                }
                print(text)
                return text
            }
            .map { "\($0)" }
            .flatMap {
                NetworkManager.share.callBoxOfficeWithSingle2(date: $0)
            }
            .debug("tap")
            .subscribe(with: self) { owner, value in
                print("next searchTap", value)
                switch value {
                case .success(let movie):
                    list.onNext(movie.boxOfficeResult.dailyBoxOfficeList)
                case .failure(let error):
                    list.onNext([])
                }
            } onError: { owner, error in
                print("onError searchTap")
            } onCompleted: { owner in
                print("onCompleted searchTap")
            } onDisposed: { owner in
                print("onDisposed searchTap")
            }
            .disposed(by: disposeBag)
        
        return Output(list: list)
    }
    
//    func transform2(input: Input) -> Output {
//        //        let list = Observable.just(["sampleData1", "sampleData2", "sampleData3"])
//        let list = PublishSubject<[DailyBoxOfficeList]>()
//        
//        // 20250101
//        input.searchTap
//            .throttle(.seconds(1), scheduler: MainScheduler.instance)
//            .withLatestFrom(input.searchText)
//            .distinctUntilChanged() // 같은 내용일 경우에는 방출되지 않도록
//            .map {
//                guard let text = Int($0) else { return 20250223 }
//                return text
//            }
//            .debug("text")
//            .map { return "\($0)" }
//            .flatMap {
//                // 그냥 map일 경우 observable타입으로 나옴 -> 한 번 더 구독 필요
//                // 다르게 검색을 할 때마다 구독이 새로 생겨남, 이전 구독이 지속되고 있다...
//                
//                // 네트워크 통신
//                NetworkManager.shared.callBoxOffice(date: $0)
//            }
//            .debug("tap")
//            .subscribe(with: self) { owner, value in
//                print("next", value)
//                list.onNext(value.boxOfficeResult.dailyBoxOfficeList)
//            } onError: { owner, error in
//                print("error", error)
//            } onCompleted: { owner in
//                print("onCompleted")
//            } onDisposed: { owner in
//                print("onDisposed")
//            }
//            .disposed(by: disposeBag)
//        
//        return Output(list: list)
//    }
}
