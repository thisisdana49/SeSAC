//
//  LoginViewModel.swift
//  MySeventhProject
//
//  Created by 조다은 on 2/5/25.
//


import Foundation

class LoginViewModel {
    
    // 실시간으로 달라지는 텍스트필드의 값을 전달 받아옴!
    var inputID: Field<String?> = Field(nil)
    var inputPW: Field<String?> = Field(nil)
    var outputValidText = Field("")
    var outputValidationButton = Field(false)

    init() {
        inputID.bind { _ in
            print(#function, "id")
            self.validation()
        }
        inputPW.bind { _ in
            print(#function, "pw")
            self.validation()
        }
    }

    private func validation() {
        guard let id = inputID.value, let pw = inputPW.value else {
            print("it's nil")
            outputValidText.value = "ID와 PW를 입력해 주세요."
            outputValidationButton.value = false
            return
        }
        
        if id.count >= 4 && pw.count >= 4 {
            outputValidText.value = "유효한 ID와 PW 입니다."
            outputValidationButton.value = true
        } else {
            print("ID와 PW는 4자리 이상부터 가능합니다.")
            outputValidText.value = "ID 및 PW는 4자리 이상부터 가능합니다."
            outputValidationButton.value = false
        }
    }
}
