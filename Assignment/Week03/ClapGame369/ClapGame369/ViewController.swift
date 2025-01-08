//
//  ViewController.swift
//  ClapGame369
//
//  Created by 조다은 on 1/8/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var resultTextView: UITextView!
    @IBOutlet var totalNumLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        titleLabel.text = "369 게임"
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.textAlignment = .center
        
        numberTextField.placeholder = "최대 숫자를 입력해 주세요."
//        numberTextField.color
        
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

