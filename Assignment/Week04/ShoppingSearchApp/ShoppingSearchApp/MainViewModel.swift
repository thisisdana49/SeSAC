//
//  MainViewModel.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 2/6/25.
//

import Foundation
import RxCocoa
import RxSwift

final class MainViewModel: BaseViewModel {
    
    struct Input {
        let searchBarText: ControlProperty<String>
        let returnKeyTap: ControlEvent<Void>
    }
    
    struct Output {
        let searchResult: Driver<String>
        let error: Driver<String>
        //        let outputSearchBarText: Observable<String?> = Observable(nil)
        //        let outputPushVC: Observable<String?> = Observable(nil)
    }
    
//    private let searchResult = PublishSubject<String>() // mark - scope issue
//    let errorSubject = PublishSubject<String>()
    
    func transform(input: Input) -> Output {
        let searchResult = PublishRelay<String>()
        let errorSubject = PublishSubject<String>()
        
        input.returnKeyTap
            .withLatestFrom(input.searchBarText)
            .debug("returnKeyTap")
            .subscribe(onNext: { text in
                if text.count < 3 {
                    errorSubject.onNext("검색어는 3글자 이상이어야 합니다.")
//                    self.errorSubject.onNext("검색어는 3글자 이상이어야 합니다.")
                } else {
                    print("searchResult")
                    searchResult.accept(text)
//                    self.searchResult.accept(text)
                }
            })
            .disposed(by: disposeBag)
        
        return Output(searchResult: searchResult.asDriver(onErrorJustReturn: ""),
                      error: errorSubject.asDriver(onErrorJustReturn: ""))
    }
    
//    private func pushViewController(keyword: String?) {
//        if let text = keyword, !text.isEmpty{
//            if text.starts(with: " ") {
////                AlertManager.shared.showAlert(message: "검색어는 공백으로 시작할 수 없습니다.", onConfirm: {
//                searchResult.accept("")
////                }
////            , over: self)
//                return
//            } else if text.count < 2 {
////                AlertManager.shared.showAlert(message: "두 글자 이상 입력해 주세요.", onConfirm: {
//                searchResult.accept("")
////                }, over: self)
//                return
//            }
//            searchResult.accept(text)
//        } else {
//            // TODO: 그외 상황?
//        }
//    }
    
}
