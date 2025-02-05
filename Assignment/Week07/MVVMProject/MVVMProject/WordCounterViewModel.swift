//
//  WordCounterViewModel.swift
//  MVVMProject
//
//  Created by 조다은 on 2/5/25.
//

import Foundation

final class WordCounterViewModel {
    
    var inputText: Observable<String?> = Observable(nil)
    var outputCountText = Observable("")
    
    init() {
        inputText.bind { value in
            self.updateCharacterCount()
        }
    }
    
    private func updateCharacterCount() {
        guard let text = inputText.value else { return }
        let count = text.count
        outputCountText.value = "현재까지 \(count)글자 작성중"
    }
    
}
