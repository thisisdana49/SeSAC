//
//  NormalViewController.swift
//  AutoLayoutProject
//
//  Created by 조다은 on 1/1/25.
//

import UIKit

class NormalViewController: UIViewController {

    @IBOutlet var topButtonArray: [UIButton]!
    @IBOutlet var onSpotPayView: UIView!
    @IBOutlet var payLogoImageView: UIImageView!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var lockImageView: UIImageView!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var checkBtnLabel: UILabel!
    @IBOutlet var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .naverBlack
        
        topButtonArray[0].setTitle("멤버쉽", for: .normal)
        topButtonArray[1].setTitle("현장결제", for: .normal)
        topButtonArray[2].setTitle("쿠폰", for: .normal)
        
        for button in topButtonArray {
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            button.setBackgroundColor(.naverBlack, for: .normal)
            button.setBackgroundColor(.darkGray, for: .selected)
            button.setBackgroundColor(.lightGray, for: .highlighted)
            button.layer.cornerRadius = 15
            button.layer.masksToBounds = true
        }
        
        onSpotPayView.layer.cornerRadius = 10
        
        payLogoImageView.image = .naverLogo
        
        let xMark = UIImage(systemName: "xmark")?.withTintColor(.naverBlack, renderingMode: .alwaysOriginal)
        closeButton.setImage(xMark, for: .normal)
        
        lockImageView.image = .naverLock
        
        contentLabel.textAlignment = .center
        contentLabel.numberOfLines = 0
        contentLabel.text = "한 번만 인증하고\n비밀번호 없이 결제하세요."
        contentLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        contentLabel.textColor = .naverBlack
        
        checkBtnLabel.textAlignment = .center
        checkBtnLabel.numberOfLines = 0
        checkBtnLabel.text = "바로 결제 사용하기"
        checkBtnLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        checkBtnLabel.textColor = .naverBlack
        
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.backgroundColor = .naverPrimary
        confirmButton.layer.cornerRadius = 30
        
    }
}
