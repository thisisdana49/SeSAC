//
//  NumberViewController.swift
//  MySecondApp
//
//  Created by 조다은 on 12/30/24.
//

import UIKit

class NumberViewController: UIViewController {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
        
//        print(NSHomeDirectory())
        
        guard let savedNumber = UserDefaults.standard.value(forKey: "number") else {
            resultLabel.text = "No Data"
            return
        }
        
        resultLabel.text = "It's \(savedNumber)"
        dateLabel.text = getToday()
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
        
        // 성공적으로 저장이 되었다는 알림을 주기
        // UIAlertController
        // 1. Title + Message
        // 2. Button
        // 3. Add Button in View
        // 4. Show in Screen
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        let test1 = UIAlertAction(title: "Test1", style: .default)
        let test2 = UIAlertAction(title: "Test2", style: .default)
        let test3 = UIAlertAction(title: "Test3", style: .default)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        alert.addAction(test1)
        alert.addAction(test2)
        alert.addAction(test3)
        present(alert, animated: true)
    }
    
    // 반환값을 무시할 수 있는 용도, warning을 뜨지 않게 해주는 용도
    // @는 Swift Attributes
    @discardableResult
    func getToday() -> String {
        let format = DateFormatter()
        format.dateFormat = "yy년 MM월 dd일"
        let today = format.string(from: Date())
        
        return today
    }
}
