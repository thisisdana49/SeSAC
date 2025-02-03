//
//  AnimationViewController.swift
//  MyFifthProject
//
//  Created by 조다은 on 1/31/25.
//

import UIKit
import Lottie

final class AnimationViewController: UIViewController {
    
    private let animationImageView = LottieAnimationView(name: "AnimationDuck")
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.circle.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemYellow
        return imageView
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이메일"
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let loginButton = UIButton()
//    : UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("로그인", for: .normal)
//        button.backgroundColor = .systemPurple
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 5
//        return button
//    }()
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "계정이 없으신가요? 회원가입"
        label.textColor = .systemBlue
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "MoneygraphyTTF-Pixel", size: 15)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoginButton()
        setupViews()
        setupAnimations()
        
        for family in UIFont.familyNames {
            print(family)
            
            for name in UIFont.fontNames(forFamilyName: family) {
                print(">>> \(name)")
            }
        }
    }
    
    func setupLoginButton() {
        loginButton.configuration = UIButton.Configuration.customStyle()
    }
    
    func setupAnimations() {
        // start isHidden true => false
        logoImageView.alpha = 0
        emailTextField.alpha = 0
        passwordTextField.alpha = 0
        loginButton.alpha = 0
        logoImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
//        UIView.animate(withDuration: 3) {
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5) {
            self.logoImageView.alpha = 1
//            self.logoImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.logoImageView.transform = CGAffineTransform(rotationAngle: 1080)
        } completion: { _ in
            self.animationEmailTextField()
        }
    }
    
    private func animationEmailTextField() {
        UIView.animate(withDuration: 3) {
            self.emailTextField.alpha = 1
        } completion: { _ in
            self.animationPasswordTextField()
        }
    }
    
    private func animationPasswordTextField() {
        UIView.animate(withDuration: 3, delay: 0, options: []) {
            self.passwordTextField.alpha = 1
        } completion: { _ in
            self.animationButton()
        }
    }
    
    private func animationButton() {
        UIView.animate(withDuration: 3) {
            self.loginButton.alpha = 1
        } completion: { _ in
            self.animationLabel()
        }
    }
    
    private func animationLabel() {
        UIView.animate(withDuration: 3) {
            self.signUpLabel.alpha = 1
        } completion: { _ in
            self.animationImageView.play()
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        [animationImageView, logoImageView, emailTextField, passwordTextField, loginButton, signUpLabel]
            .forEach { view.addSubview($0) }
        
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.width.height.equalTo(100)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(50)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.left.right.height.equalTo(emailTextField)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.left.right.equalTo(emailTextField)
            make.height.equalTo(44)
        }
        
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(loginButton.snp.bottom).offset(30)
            make.left.right.equalTo(emailTextField)
            make.height.equalTo(44)
        }
        
        
        animationImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(20)
            make.width.height.equalTo(100)
        }
    }
    
}
