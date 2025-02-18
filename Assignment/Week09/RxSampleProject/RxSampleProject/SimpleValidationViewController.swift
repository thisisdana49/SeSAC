//
//  SimpleValidationViewController.swift
//  RxSampleProject
//
//  Created by 조다은 on 2/18/25.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class SimpleValidationViewController: UIViewController {

    let usernameLabel = UILabel()
    let passwordLabel = UILabel()
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let confirmButton = UIButton()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        configure()
    }
    
    private func bind() {
    }
    
    private func configure() {
        view.addSubview(usernameLabel)
        view.addSubview(usernameTextField)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(confirmButton)
        
        usernameLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        usernameTextField.snp.makeConstraints {
            $0.top.equalTo(usernameLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(36)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(36)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
        
        view.backgroundColor = .white
        
        usernameTextField.borderStyle = .roundedRect
        passwordTextField.borderStyle = .roundedRect
        
        usernameLabel.text = "Username"
        passwordLabel.text = "Password"
        
        confirmButton.backgroundColor = .green
        confirmButton.setTitleColor(.black, for: .normal)
        confirmButton.setTitle("Do Something", for: .normal)
    }
    
}
