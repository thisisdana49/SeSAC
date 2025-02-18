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

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

class SimpleValidationViewController: UIViewController {

    let usernameLabel = UILabel()
    let usernameValidLabel = UILabel()
    let passwordValidLabel = UILabel()
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
        let usernameValid = usernameTextField.rx.text.orEmpty
            .map { $0.count >= minimalUsernameLength }
            .share(replay: 1)
            
        let passwordValid = passwordTextField.rx.text.orEmpty
            .map { $0.count >= minimalPasswordLength }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        usernameValid
            .bind(to: passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
        
        usernameValid
            .bind(to: usernameValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordValid
            .bind(to: passwordValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid
            .bind(to: confirmButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        confirmButton.rx.tap
            .subscribe(with: self) { owner, _ in
                AlertManager.shared.showAlert(on: self, message: "This is wonderful!!")
            }
            .disposed(by: disposeBag)
    }
    
    private func configure() {
        view.addSubview(usernameLabel)
        view.addSubview(usernameTextField)
        view.addSubview(usernameValidLabel)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordValidLabel)
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
        usernameValidLabel.snp.makeConstraints {
            $0.top.equalTo(usernameTextField.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(usernameValidLabel.snp.bottom).offset(40)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(passwordLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(36)
        }
        passwordValidLabel.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(passwordValidLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
        
        view.backgroundColor = .white
        
        usernameTextField.borderStyle = .roundedRect
        passwordTextField.borderStyle = .roundedRect
        
        usernameLabel.text = "Username"
        passwordLabel.text = "Password"
        
        usernameValidLabel.text = "Username has to be at least \(minimalUsernameLength) characters"
        passwordValidLabel.text = "Password has to be at least \(minimalPasswordLength) characters"
        usernameValidLabel.textColor = .red
        passwordValidLabel.textColor = .red
        
        confirmButton.backgroundColor = .green
        confirmButton.setTitleColor(.black, for: .normal)
        confirmButton.setTitleColor(.white, for: .disabled)
        confirmButton.setTitle("Do Something", for: .normal)
        confirmButton.isEnabled = false
    }
    
}
