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
        view.backgroundColor = .black
        
        topButtonArray[0].setTitle("멤버쉽", for: .normal)
        topButtonArray[1].setTitle("현장결제", for: .normal)
        topButtonArray[2].setTitle("쿠폰", for: .normal)
        
        for button in topButtonArray {
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .black
        }
        
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        
        contentLabel.textAlignment = .center
        contentLabel.numberOfLines = 0
        contentLabel.text = "한 번만 인증하고\n비밀번호 없이 결제하세요."
        
        checkBtnLabel.textAlignment = .center
        checkBtnLabel.numberOfLines = 0
        checkBtnLabel.text = "바로 결제 사용하기"
        
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.backgroundColor = .green
        confirmButton.layer.cornerRadius = 20
        
    }
}
