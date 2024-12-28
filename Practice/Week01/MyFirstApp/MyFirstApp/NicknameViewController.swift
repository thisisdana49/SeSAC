//
//  NicknameViewController.swift
//  MyFirstApp
//
//  Created by 조다은 on 12/26/24.
//

import UIKit

// Outlet
// Action: User's click

class NicknameViewController: UIViewController {

    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var sampleButton: UIButton!
    @IBOutlet var sampleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nicknameTextField.placeholder = "Please enter your nickname"
        nicknameTextField.borderStyle = .roundedRect
        nicknameTextField.text = "다우니맛"
    }
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        var text = sender.text ?? ""
        print(text.count)
    }
    
    @IBAction func textFieldReturnClicked(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func sampleButtonClicked(_ sender: UIButton) {
        if nicknameTextField.text?.isEmpty ?? true {
            sampleLabel.text = "You didn't enter anything..."
        } else {
            sampleLabel.text = "You entered \(nicknameTextField.text!)!"
        }
        view.endEditing(true)
    }
}
