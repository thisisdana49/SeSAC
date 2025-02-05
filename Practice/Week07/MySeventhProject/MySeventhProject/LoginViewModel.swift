//
//  NumberViewModel.swift
//  MySeventhProject
//
//  Created by 조다은 on 2/5/25.
//


import Foundation

class Field<T> {
    
    private var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(closure: @escaping (T) -> Void) {
        // bind에 작성한 구문이 바로 동작하게끔 하고 싶은 경우
        // 주석 여부에 따라 결과가 달라짐, 바로 동작하지 않게끔 하려면 주석 처리
//        closure(value)
        self.closure = closure
    }
    
}

class NumberViewModel {
    
    // ViewController에서 사용자가 받아온 값 그 자체
    var inputField: Field<String?> = Field(nil)
    // VC의 Label에 보여줄 최종 텍스트
    var outputText = Field("")
    // VC의 Label에 사용할 Color => UIColor?를 어떻게 하나
    // 숫자(HEX)로 주거나, BoolType으로 주거나 등
    // 아니면 그냥 UIColor를 주거나하는 것은 개발자의 선택 사항
    var outputTextColor = Field(false)
    
    init() {
        inputField.bind { text in
            print("inputfield", text)
            self.validation()
        }
    }
    
    private func validation() {
        // 공백 = 값을 입력해 주세요
        // 문자 - 숫자를 입력헤 주세요
        // 숫자 범위 - 100만원 이하의 값을 작성해주세요
        // 콤마 - 123,456
        
        // 1) Optional
        guard let text = inputField.value else {
            outputText.value = ""
            outputTextColor.value = false
            return
        }
        
        // 2) Empty
        if text.isEmpty {
            outputText.value = "Please Input value"
            outputTextColor.value = false
            return
        }
        
        // 3) Number of Not
        guard let num = Int(text) else {
            outputText.value = "숫자만 입력해주세요"
            outputTextColor.value = false
            return
        }
        
        // 4) 0 ~ 1,000,000
        if num > 0, num <= 1000000 {
            let format = NumberFormatter()
            format.numberStyle = .decimal
            let result = format.string(from: num as NSNumber)!
            outputText.value = "₩" + result
            outputTextColor.value = true
        } else {
            outputText.value = "1,000,000 이하를 입력해 주세요."
            outputTextColor.value = false
        }
    }
    
}
