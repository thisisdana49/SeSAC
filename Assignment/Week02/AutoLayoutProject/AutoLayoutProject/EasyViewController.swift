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
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        titleLabel.textColor = .red
        
        idTextField.attributedPlaceholder = NSAttributedString(string: "이메일 주소 또는 전화번호", attributes: [.foregroundColor: UIColor.white])
        idTextField.textAlignment = .center
        idTextField.backgroundColor = .darkGray
        
        pwTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [.foregroundColor: UIColor.white])
        pwTextField.textAlignment = .center
        pwTextField.backgroundColor = .darkGray
        
        nicknameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [.foregroundColor: UIColor.white])
        nicknameTextField.textAlignment = .center
        nicknameTextField.backgroundColor = .darkGray
        
        locationTextField.attributedPlaceholder = NSAttributedString(string: "위치", attributes: [.foregroundColor: UIColor.white])
        locationTextField.textAlignment = .center
        locationTextField.backgroundColor = .darkGray
        
        codeTextField.attributedPlaceholder = NSAttributedString(string: "추천코드 입력", attributes: [.foregroundColor: UIColor.white])
        codeTextField.textAlignment = .center
        codeTextField.backgroundColor = .darkGray
        
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        signUpButton.backgroundColor = .white
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.layer.cornerRadius = 5
        
        addInformLabel.text = "추가 정보 입력"
        addInformLabel.textColor = .white
        addInformSwitch.isOn = true
        addInformSwitch.onTintColor = .red
        addInformSwitch.subviews.first?.subviews.first?.backgroundColor = .systemGray2
    }
}
