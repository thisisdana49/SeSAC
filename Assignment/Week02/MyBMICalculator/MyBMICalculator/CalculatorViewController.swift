//
//  CalculatorViewController.swift
//  MyBMICalculator
//
//  Created by 조다은 on 12/30/24.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet var guideTitleLabel: UILabel!
    @IBOutlet var guideContentLabel: UILabel!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }

    fileprivate func setUI() {
        guideTitleLabel.numberOfLines = 0
        guideTitleLabel.text = "체중과 키가\n어떻게 되시나요?"
        guideTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        guideContentLabel.numberOfLines = 0
        guideContentLabel.text = "다은님의 BMI 지수를\n알려드릴게요."
        guideContentLabel.font = UIFont.systemFont(ofSize: 16)
        guideContentLabel.textColor = .lightGray
        
        heightTextField.keyboardType = .numberPad
        heightTextField.textAlignment = .right
        heightTextField.placeholder = "168"
        heightTextField.font = UIFont.systemFont(ofSize: 16)
        heightTextField.frame.size.height = 50
        heightTextField.layer.borderWidth = 1
        heightTextField.layer.borderColor = UIColor.systemGray6.cgColor
        heightTextField.layer.cornerRadius = 10
        
        heightLabel.text = "cm"
        heightLabel.font = UIFont.systemFont(ofSize: 16)

        weightTextField.keyboardType = .numberPad
        weightTextField.textAlignment = .right
        weightTextField.placeholder = "42"
        weightTextField.font = UIFont.systemFont(ofSize: 16)
        weightTextField.frame.size.height = 50
        weightTextField.layer.borderWidth = 1
        weightTextField.layer.borderColor = UIColor.systemGray6.cgColor
        weightTextField.layer.cornerRadius = 10
        
        weightLabel.text = "kg"
        weightLabel.font = UIFont.systemFont(ofSize: 16)
        
        nextButton.setTitle("확인", for: .normal)
        nextButton.tintColor = .white
        nextButton.backgroundColor = .systemBlue
        nextButton.layer.cornerRadius = 10
        
        resultLabel.isHidden = true
    }
}
