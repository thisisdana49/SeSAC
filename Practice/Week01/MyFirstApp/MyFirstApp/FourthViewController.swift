//
//  FourthViewController.swift
//  MyFirstApp
//
//  Created by 조다은 on 12/27/24.
//

import UIKit

// gesture
// number of lines
// same action in several buttons
class FourthViewController: UIViewController {

    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet var oneTextField: UITextField!
    @IBOutlet var twoTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    

    @IBAction func outsideOfKeyboardTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        view.endEditing(true)
    }
    
    fileprivate func setUI() {
        setResultLabelUI()
        setTextFieldUI("Write your Nickname", tfName: nicknameTextField, color: .point)
        setTextFieldUI("ID or Email", tfName: oneTextField, color: .brown)
        setTextFieldUI("PassWord", tfName: twoTextField)
        // 전달되는 실질적인 데이터 == 전달인자(Argument)
    }
    
    fileprivate func setResultLabelUI() {
        resultLabel.backgroundColor = .orange
        resultLabel.numberOfLines = 0
        resultLabel.text = "Claude empowers you to deploy AI to business critical use cases, with very low hallucination rates and very high accuracy over long documents. Claude empowers you to deploy AI to business critical use cases, with very low hallucination rates and very high accuracy over long documents."
    }
    
    // placeholderText & textFieldName == 매개변수(Parameter)
    // tfName == 외부 매개변수(Argument Label)
    // textFieldName == 내부 매개변수(Parameter Name)
    // _ 는 와일드카드 식별자, Argument Label을 식별하는 것
    fileprivate func setTextFieldUI(_ placeholderText: String, tfName textFieldName: UITextField, color textColor: UIColor = .red) {
        textFieldName.placeholder = placeholderText
        textFieldName.borderStyle = .roundedRect
        textFieldName.textAlignment = .center
        textFieldName.textColor = textColor
    }
}
