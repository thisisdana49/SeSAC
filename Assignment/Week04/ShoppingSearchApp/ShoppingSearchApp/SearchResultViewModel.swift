//
//  SearchResultViewModel.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 2/6/25.
//

import Foundation
import RxCocoa
import RxSwift

final class SearchResultViewModel: BaseViewModel {
    
    private(set) var keyword: BehaviorRelay<String>
    private var sortStandard: BehaviorRelay<String> = BehaviorRelay(value: "sim")
    private let errorSubject = PublishSubject<String>()
    private let scrollToTop = PublishSubject<Void>()
    
    struct Input {
        let fetchData: Observable<Void>
        let sortButtonTapped: Observable<Int>
    }
    
    struct Output {
        let resultProduct: Driver<[ItemModel]>
        let totalProduct: Driver<String>
        let error: Driver<String>
        let scrollToTop: Driver<Void>
    }
    
    let sortStandards = ["sim", "date", "dsc", "asc"]
    var start: Int = 1
    var display: Int = 100
    
    init(keyword: String) {
        self.keyword = BehaviorRelay(value: keyword)
    }
    
    func transform(input: Input) -> Output {
        let resultProduct = PublishRelay<[ItemModel]>()
        let totalProduct: BehaviorRelay<String> = BehaviorRelay(value: "")
        
        input.fetchData
            .flatMap { [weak self] _ in
                self?.fetchProducts() ?? Single.just(ProductResponse(total: 0, start: 0, items: []))
            }
            .map { value -> [ItemModel] in
                totalProduct.accept("\(value.total) 개의 검색 결과")
                let itemModel = ItemModel(items: value.items)
                return [itemModel]
            }
            .bind(to: resultProduct)
            .disposed(by: disposeBag)
        
        input.sortButtonTapped
            .do(onNext: { [weak self] index in
                self?.sortStandard.accept(self?.sortStandards[index] ?? "sim")
            })
            .debug("sortStandard")
            .flatMap { [weak self] _ in
                self?.fetchProducts() ?? Single.just(ProductResponse(total: 0, start: 0, items: []))
            }
            .map { [weak self] value -> [ItemModel] in
                totalProduct.accept("\(value.total) 개의 검색 결과")
                self?.scrollToTop.onNext(())
                let itemModel = ItemModel(items: value.items)
                return [itemModel]
            }
            .bind(to: resultProduct)
            .disposed(by: disposeBag)
        
        return Output(resultProduct: resultProduct.asDriver(onErrorDriveWith: .empty()),
                      totalProduct: totalProduct.asDriver(),
                      error: errorSubject.asDriver(onErrorDriveWith: .empty()),
                      scrollToTop: scrollToTop.asDriver(onErrorJustReturn: ()))
        
        //        inputSortButtonTapped.lazyBind { [weak self] value in
        //            self?.start = 1
        //            self?.sortStandard = (self?.sortStandards[value])!
        //            self?.fetchData()
        //        }
    }
    
    private func fetchProducts() -> Single<ProductResponse> {
        return NetworkManager.share.callSearch(searchWord: keyword.value,
                                               sortWith: sortStandard.value,
                                               start: start,
                                               display: display)
        .debug()
        .catch { [weak self] error in
            if let apiError = error as? APIError {
                switch apiError {
                case .invalidURL:
                    return Single.error(APIError.invalidURL)
                case .unknownResponse:
                    return Single.just(ProductResponse(total: 0, start: 0, items: []))
                case .statusError:
                    return Single.just(ProductResponse(total: 0, start: 0, items: []))
                case .apiError(let message, let code):
//                    print("API Error - Message: \(message), Code: \(code)")
                    self?.errorSubject.onNext(message)
                    return Single.just(ProductResponse(total: 0, start: 0, items: []))
                }
            } else {
                return Single.just(ProductResponse(total: 0, start: 0, items: []))
            }
        }
    }
    
}
//    private func fetchData() {
//        NetworkManager.share.searchItem(searchWord: keyword, sortWith: sortStandard, start: self.start, display: self.display) { [weak self] value in
//            if self?.start == 1 {
//                self?.outputItem.value = value
//                print(#function, value.total)
//                self?.outputTotalText.value = "\(value.total.formatted(.number))개의 검색 결과"
//            } else {
//                self?.outputItem.value?.items.append(contentsOf: value.items)
//            }
//
//            if self?.start == 1 {
//                self?.outputScrollToTop.value = ()
//            }
//        }
//    }
