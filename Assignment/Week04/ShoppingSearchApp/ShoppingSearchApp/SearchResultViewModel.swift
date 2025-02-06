//
//  SearchResultViewModel.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 2/6/25.
//

import Foundation

class SearchResultViewModel {
    
    let inputViewDidLoad: Observable<Void?> = Observable(nil)
    let inputStart: Observable<Int> = Observable(1)
    
    var outputItem: Observable<Item?> = Observable(nil)
    var outputItemTotal: Observable<Int> = Observable(0)
    var outputScrollToTop: Observable<Void?> = Observable(nil)
    
    var keyword: String?
    // TODO: 연산 프로퍼티?
    var totalText: String = ""
    
    init() {
        inputViewDidLoad.lazyBind { [weak self] _ in
            self?.fetchData()
        }
    }
    
    private func fetchData() {
        guard let searchWord = keyword else { return }
        print(#function, searchWord)
        NetworkManager.shared.searchItem(searchWord: searchWord, sortWith: "sim", start: self.inputStart.value, display: 30) { [weak self] value in
            if self?.inputStart.value == 1 {
                dump(value)
                self?.outputItem.value = value
                self?.totalText = "\(value.total.formatted(.number))개의 검색 결과"
            } else {
                self?.outputItem.value?.items.append(contentsOf: value.items)
            }
            
            if self?.inputStart.value == 1 {
                self?.outputScrollToTop.value = ()
            }
        }
        
        
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
