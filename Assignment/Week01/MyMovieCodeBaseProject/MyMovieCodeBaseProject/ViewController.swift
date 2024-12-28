//
//  ViewController.swift
//  MyMovieCodeBaseProject
//
//  Created by 조다은 on 12/26/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var idTextfield: UITextField!
    @IBOutlet var pwTextfield: UITextField!
    @IBOutlet var nicknameTextfield: UITextField!
    @IBOutlet var locationTextfield: UITextField!
    @IBOutlet var codeTextfield: UITextField!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var addInfoLabel: UILabel!
    @IBOutlet var addInfoSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = .black
        
        // title label
        titleLabel.text = "DANFLIX"
        titleLabel.textColor = .primary
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        
        
        // ID textfield
        idTextfield.keyboardType = .emailAddress
        idTextfield.textAlignment = .center
        idTextfield.attributedPlaceholder = NSAttributedString(string: "이메일 또는 전화번호", attributes: [.foregroundColor: UIColor.white])
        idTextfield.textColor = .white
        idTextfield.tintColor = .red
        idTextfield.backgroundColor = .systemGray
        idTextfield.borderStyle = .roundedRect
        
        
        // PW textfield
        pwTextfield.isSecureTextEntry = true
        pwTextfield.textAlignment = .center
        pwTextfield.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [.foregroundColor: UIColor.white])
        pwTextfield.textColor = .white
        pwTextfield.tintColor = .primary
        pwTextfield.backgroundColor = .systemGray
        pwTextfield.borderStyle = .roundedRect
        
        
        // nickname textfield
        nicknameTextfield.textContentType = .nickname
        nicknameTextfield.textAlignment = .center
        nicknameTextfield.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [.foregroundColor: UIColor.white])
        nicknameTextfield.textColor = .white
        nicknameTextfield.tintColor = .primary
        nicknameTextfield.backgroundColor = .systemGray
        nicknameTextfield.borderStyle = .roundedRect
        
        
        // location textfield
        locationTextfield.textContentType = .location
        locationTextfield.textAlignment = .center
        locationTextfield.attributedPlaceholder = NSAttributedString(string: "위치", attributes: [.foregroundColor: UIColor.white])
        locationTextfield.textColor = .white
        locationTextfield.tintColor = .primary
        locationTextfield.backgroundColor = .systemGray
        locationTextfield.borderStyle = .roundedRect
        
        
        // code textfield
        codeTextfield.textContentType = .oneTimeCode
        codeTextfield.textAlignment = .center
        codeTextfield.attributedPlaceholder = NSAttributedString(string: "추천 코드 입력", attributes: [.foregroundColor: UIColor.white])
        codeTextfield.textColor = .white
        codeTextfield.tintColor = .primary
        codeTextfield.backgroundColor = .systemGray
        codeTextfield.borderStyle = .roundedRect
        
        
        // sign up button
        signUpButton.setTitle( "회원가입", for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.backgroundColor = .white
        signUpButton.layer.cornerRadius = 5
        
        
        // additional inform label
        addInfoLabel.text = "추가 정보 입력"
        addInfoLabel.textColor = .white
        addInfoSwitch.onTintColor = .primary
        addInfoSwitch.setOn(false, animated: false)
    }

    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
    }
}

