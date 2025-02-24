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
        let list: Observable<[String]>
    }
    
    // map, withLatestFrom, flatMap, flatMapLatest
    func transform(input: Input) -> Output {
        let list = Observable.just(["dummy", "data", "list"])
        
        input.searchTap
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()jk환
                guard let text = Int($0) else {
                    return 20250223
                }
                return text
            }
            .map { return "\($0)" }
            .map {
                
            }
            .subscribe(with: self) { owner, value in
                print("next searchTap", value)
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
    
}
