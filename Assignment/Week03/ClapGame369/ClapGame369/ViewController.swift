//
//  ViewController.swift
//  ClapGame369
//
//  Created by 조다은 on 1/8/25.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    var rangeNumbers: [Int] = []
    var clapCount: Int = 0
//    {
//        get { return clapCount }
//        set {
//            totalNumLabel.text = "숫자 \(numbers[0])까지 총 박수는 \(newValue)번 입니다.🫢"
//        }
//    }
    var resultText: [String] = []
    let pickerView = UIPickerView()
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var resultTextView: UITextView!
    @IBOutlet var totalNumLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        
        for i in 1...100 {
            rangeNumbers.append(i)
        }
        rangeNumbers.reverse()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        numberTextField.delegate = self
        
        numberTextField.inputView = pickerView
        resultTextView.isEditable = false
        resultTextView.isSelectable = false
    }
    
    // UIPickerView Delegate
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rangeNumbers.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(rangeNumbers[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        numberTextField.text = String(rangeNumbers[row])
    }
    
    // TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        computeClapNumber()
        return true
    }
    
    private func computeClapNumber() {
        resultText.removeAll()
        clapCount = 0
        let endNum = Int(numberTextField.text!) ?? 1
        for number in 1...endNum {
            if String(number).contains("3") || String(number).contains("6") || String(number).contains("9") {
                var array: [String] = []
                var currentNum: String = ""
                for i in String(number) {
                    if i == "3" || i == "6" || i == "9" {
                        array.append("👏")
                        clapCount += 1
                    } else {
                        array.append("\(i)")
                    }
                }
                currentNum = array.joined()
                resultText.append(currentNum)
            } else {
                resultText.append(String(number))
            }
        }
        resultTextView.text = resultText.joined(separator: ",")
        totalNumLabel.text = "숫자 \(numberTextField.text ?? "0")까지 총 박수는 \(clapCount)번 입니다.🫢"
    }
    
    private func setUI() {
        titleLabel.text = "369 게임"
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.textAlignment = .center
        
        numberTextField.placeholder = "최대 숫자를 입력해 주세요."
        numberTextField.borderStyle = .line
        
        resultTextView.text = "결과는 과연? 두구두구~🥁"
        resultTextView.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        resultTextView.textColor = .systemGray3
        resultTextView.textAlignment = .center
        
        totalNumLabel.text = "몇 번이나 박수를 쳐야할까요?"
        totalNumLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        totalNumLabel.textAlignment = .center
        totalNumLabel.numberOfLines = 0
    }
}

