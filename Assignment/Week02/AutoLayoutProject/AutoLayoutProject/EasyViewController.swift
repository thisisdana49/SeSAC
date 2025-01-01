//
//  EasyViewController.swift
//  AutoLayoutProject
//
//  Created by 조다은 on 1/1/25.
//

import UIKit

class EasyViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwTextField: UITextField!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var codeTextField: UITextField!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var addInformLabel: UILabel!
    @IBOutlet var addInformSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .black
        
        titleLabel.text = "DANFLIX"
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        titleLabel.textColor = .red
        
        idTextField.placeholder = "이메일 주소 또는 전화번호"
        pwTextField.placeholder = "비밀번호"
        nicknameTextField.placeholder = "닉네임"
        locationTextField.placeholder = "위치"
        codeTextField.placeholder = "추천 코드 입력"
        
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.backgroundColor = .white
        signUpButton.setTitleColor(.black, for: .normal)
        
        addInformLabel.text = "추가 정보 입력"
        addInformLabel.textColor = .white
        addInformSwitch.isOn = true
        addInformSwitch.tintColor = .red
    }
}
