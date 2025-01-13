//
//  FirstViewController.swift
//  CodeBaseUIKit
//
//  Created by 조다은 on 1/13/25.
//

import UIKit
import SnapKit

class FirstViewController: UIViewController {

    let titleLabel = {
        let label = UILabel()
        label.text = "DANFLIX"
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 28, weight: .heavy)
        label.textAlignment = .center
        
        return label
    }()
    
    let idTextField = {
        let textField = UITextField()
        textField.placeholder = "이메일 주소 또는 전화번호"
        textField.textAlignment = .center
        textField.textColor = .white
        textField.backgroundColor = .darkGray
        textField.tintColor = .white
        textField.layer.cornerRadius = 5
        
        return textField
    }()
    
    let pwTextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.textAlignment = .center
        textField.textColor = .white
        textField.backgroundColor = .darkGray
        textField.tintColor = .white
        textField.layer.cornerRadius = 5
        
        return textField
    }()

    let nickNameTextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임"
        textField.textAlignment = .center
        textField.textColor = .white
        textField.backgroundColor = .darkGray
        textField.tintColor = .white
        textField.layer.cornerRadius = 5
        
        return textField
    }()

    let locationTextField = {
        let textField = UITextField()
        textField.placeholder = "위치"
        textField.textAlignment = .center
        textField.textColor = .white
        textField.backgroundColor = .darkGray
        textField.tintColor = .white
        textField.layer.cornerRadius = 5
        
        return textField
    }()
    
    let codeTextField = {
        let textField = UITextField()
        textField.placeholder = "추천 코드 입력"
        textField.textAlignment = .center
        textField.textColor = .white
        textField.backgroundColor = .darkGray
        textField.tintColor = .white
        textField.layer.cornerRadius = 5
        
        return textField
    }()
    
    let confirmButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    let addInformLabel = {
        let label = UILabel()
        label.text = "추가 정보 입력"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    let addInformSwitch = {
        let informSwitch = UISwitch()
        
        informSwitch.isOn = true
        informSwitch.thumbTintColor = .white
        informSwitch.onTintColor = .red
        
        return informSwitch
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureLayout()
    }
    
    func configureLayout() {
        view.backgroundColor = .black
        
        configureTitle()
        configureTextField()
        configureButtons()
        configureAddInforms()
    }
    
    func configureTitle() {
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(100)
        }
    }
    
    func configureTextField() {
        let textFields = [idTextField, pwTextField, nickNameTextField, locationTextField, codeTextField]
        
        for (index, textField) in textFields.enumerated() {
            view.addSubview(textField)
            
            textField.snp.makeConstraints { make in
                make.centerX.equalTo(view.safeAreaLayoutGuide)
                make.top.equalTo(titleLabel).offset(200 + (52 * index))
                make.width.equalToSuperview().inset(32)
                make.height.equalTo(40)
            }
        }
    }
    
    func configureButtons() {
        view.addSubview(confirmButton)
        
        confirmButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(codeTextField).offset(52)
            make.width.equalToSuperview().inset(32)
            make.height.equalTo(44)
        }
    }
    
    func configureAddInforms() {
        view.addSubview(addInformLabel)
        view.addSubview(addInformSwitch)
        
        addInformLabel.snp.makeConstraints { make in
            make.top.equalTo(confirmButton).offset(64)
            make.leading.equalTo(confirmButton)
        }
        addInformSwitch.snp.makeConstraints { make in
            make.top.equalTo(confirmButton).offset(64)
            make.trailing.equalTo(confirmButton)
        }
    }
}

#Preview {
    FirstViewController()
}
