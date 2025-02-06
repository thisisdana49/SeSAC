//
//  MainViewModel.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 2/6/25.
//

import Foundation

class MainViewModel {
    
    let inputReturnKeyTapped: Observable<String?> = Observable(nil)
    
    let outputSearchBarText: Observable<String?> = Observable(nil)
    let outputPushVC: Observable<String?> = Observable(nil)
    
    init() {
        inputReturnKeyTapped.lazyBind { [weak self] value in
            self?.pushViewController(keyword: value)
        }
    }
    
    private func pushViewController(keyword: String?) {
        print(#function)
        if let text = keyword, !text.isEmpty{
            // TODO: 공백 처리
            if text.starts(with: " ") {
//                AlertManager.shared.showAlert(message: "검색어는 공백으로 시작할 수 없습니다.", onConfirm: {
                outputSearchBarText.value = ""
//                }
//            , over: self)
                return
            } else if text.count < 2 {
//                AlertManager.shared.showAlert(message: "두 글자 이상 입력해 주세요.", onConfirm: {
                outputSearchBarText.value = ""
//                }, over: self)
                return
            }
            outputPushVC.value = text
        } else {
        }
    }
    
}
