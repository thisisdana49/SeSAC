//
//  NumberViewController.swift
//  MySecondApp
//
//  Created by 조다은 on 12/30/24.
//

import UIKit

class NumberViewController: UIViewController {

    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(NSHomeDirectory())
        
        guard let savedNumber = UserDefaults.standard.value(forKey: "numbers") else {
            resultLabel.text = "No Data"
            return
        }
        
        resultLabel.text = "It's \(savedNumber)"
    }

    // 실시간으로 레이블에 내용 반영
    // 입력한 내용이 숫자라면 숫자 그대로 출력
    // 입력한 내용이 문자라면 숫자가 아닙니다 출력
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        guard let inputText = numberTextField.text, let doubleNumber = Double(inputText) else {
            resultLabel.text = numberTextField.text?.count == 0 ? "No Input" : "It's not a number"
            return
        }

        let intNumber = Int(doubleNumber)
        
        if doubleNumber == Double(intNumber) {
            resultLabel.text = "It's \(intNumber)"
        } else {
            resultLabel.text = "It's \(doubleNumber)"
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        // 텍스트필드에 적었던 내용을 영구적으로 저장
        UserDefaults.standard.set(numberTextField.text, forKey: "number")
        print(#function)
    }
}
