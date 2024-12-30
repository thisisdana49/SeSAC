//
//  ViewController.swift
//  MyBMICalculator
//
//  Created by 조다은 on 12/30/24.
//

import UIKit

class NicknameViewController: UIViewController {

    @IBOutlet var guideTitleLabel: UILabel!
    @IBOutlet var guideContentLabel: UILabel!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }

    fileprivate func setUI() {
        guideTitleLabel.numberOfLines = 0
        guideTitleLabel.text = "체중 관리,\n함께 해볼까요?"
        guideTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        guideContentLabel.numberOfLines = 0
        guideContentLabel.text = "먼저 닉네임을\n입력해 주세요."
        guideContentLabel.font = UIFont.systemFont(ofSize: 16)
        guideContentLabel.textColor = .lightGray
        
        nextButton.setTitle("다음", for: .normal)
        nextButton.tintColor = .white
        nextButton.backgroundColor = .systemBlue
        nextButton.layer.cornerRadius = 10
    }
}

