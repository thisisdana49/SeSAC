//
//  CurrencyViewModel.swift
//  MVVMProject
//
//  Created by 조다은 on 2/5/25.
//

import Foundation

final class CurrencyViewModel {
    
    var inputCurrency: Observable<String?> = Observable(nil)
    var inputConvertButtonTapped: Observable<Void> = Observable(())
    var outputResultText = Observable("")
    
    init() {
        inputConvertButtonTapped.bind { _ in
            self.exchangeCurrency()
        }
    }
    
    private func exchangeCurrency() {
        guard let amountText = inputCurrency.value,
              let amount = Double(amountText) else {
            outputResultText.value = "올바른 금액을 입력해주세요"
            return
        }
        
        let exchangeRate = 1446.0 // 25.02.05 PM 6 기준
        let convertedAmount = amount / exchangeRate
        
        outputResultText.value = String(format: "%.2f USD (약 $%.2f)", convertedAmount, convertedAmount)
    }
    
}
