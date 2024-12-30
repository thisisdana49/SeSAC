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
    @IBOutlet var nicknameTextField: UITextField!
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
        
        nextButton.setTitle("확인", for: .normal)
        nextButton.tintColor = .white
        nextButton.backgroundColor = .systemBlue
        nextButton.layer.cornerRadius = 10
        
        resultLabel.isHidden = true
    }
}
