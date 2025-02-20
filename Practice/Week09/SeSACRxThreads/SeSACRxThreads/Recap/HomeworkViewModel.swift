//
//  HomeworkViewModel.swift
//  SeSACRxThreads
//
//  Created by 조다은 on 2/20/25.
//

import Foundation
import RxCocoa
import RxSwift

final class HomeworkViewModel {
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let searchText: ControlProperty<String>
        let searchButtonTap: ControlEvent<Void>
        let recentText: PublishSubject<String>
    }
    
    struct Output {
        let items: BehaviorSubject<[String]>
        let recent: Driver<[String]>
    }
    
    var items = ["Test"]
    var recents = ["Jack"]
    
    func transform(input: Input) -> Output {
        let itemsList = BehaviorSubject(value: items)
        let recentList = BehaviorRelay(value: recents)
        
        input.searchButtonTap
            .withLatestFrom(input.searchText)
            .map { "\($0)님" }
            .asDriver(onErrorJustReturn: "손님")
            .drive(with: self) { owner, value in
                owner.items.append(value)
                itemsList.onNext(owner.items)
            }
            .disposed(by: disposeBag)
        
        input.recentText
            .bind(with: self) { owner, value in
                owner.recents.append(value)
                recentList.accept(owner.recents)
            }
            .disposed(by: disposeBag)
        
        return Output(items: itemsList,
                      recent: recentList.asDriver())
    }
    
}
