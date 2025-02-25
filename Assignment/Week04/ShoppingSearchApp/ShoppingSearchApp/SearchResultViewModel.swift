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
    
    var keyword: BehaviorRelay<String>
    
    struct Input {
        let fetchData: Observable<Void>
//        let inputSortButtonTapped: Observable<Int> = Observable(0)
    }
    
    struct Output {
        let resultProduct: Driver<[ItemModel]>
//        let outputItemTotal: Observable<Int> = Observable(0)
//        let outputScrollToTop: Observable<Void?> = Observable(nil)
    }
    
    let sortStandards = ["sim", "date", "dsc", "asc"]
    var sortStandard: String = "sim"
    var start: Int = 1
    var display: Int = 100
//    // TODO: 연산 프로퍼티?
//    let outputTotalText: Observable<String> = Observable("")
    
    init(keyword: String) {
        self.keyword = BehaviorRelay(value: keyword)
    }
    
    func transform(input: Input) -> Output {
        let resultProduct = PublishSubject<[ItemModel]>()
        
        input.fetchData
            .debug("fetchData")
            .withLatestFrom(keyword)
            .flatMap { [weak self] _ in
                NetworkManager.share.callSearch(searchWord: self?.keyword.value, sortWith: self?.sortStandard, start: self?.start, display: self?.display)
            }
            .map { value -> [ItemModel] in
                let itemModel = ItemModel(name: "Search Results", items: value.items)
                return [itemModel]
            }
            .bind(to: resultProduct)
            .disposed(by: disposeBag)
        
        return Output(resultProduct: resultProduct.asDriver(onErrorDriveWith: .empty()))

//        inputSortButtonTapped.lazyBind { [weak self] value in
//            self?.start = 1
//            self?.sortStandard = (self?.sortStandards[value])!
//            self?.fetchData()
//        }
    }
    
    private func fetchData() {
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
        
        
//        NetworkManager.shared.searchItem(searchWord: keyword, sortWith: sortStandard, start: start, display: display) { value in
//            if self.start == 1 {
//                self.item = value
//                if let total = self.item?.total {
//                    self.mainView.totalLabel.text = "\(total.formatted(.number))개의 검색 결과"
//                }
//            } else {
//                self.item?.items.append(contentsOf: value.items)
//            }
//            self.mainView.collectionView.reloadData()
//            
//            if self.start == 1 {
//                self.mainView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
//            }
//        }
    }
    
}
