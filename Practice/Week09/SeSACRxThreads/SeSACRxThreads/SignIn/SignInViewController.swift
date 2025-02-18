//
//  SignInViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class SignInViewController: UIViewController {

    let emailTextField = SignTextField(placeholderText: "이메일을 입력해주세요")
    let passwordTextField = SignTextField(placeholderText: "비밀번호를 입력해주세요")
    let signInButton = PointButton(title: "로그인")
    let signUpButton = UIButton()
    
    let emailText = Observable.just("a@a.com")
    let backgroundColor = Observable.just(UIColor.lightGray)
    let signUpTitle = Observable.just("회원이 아직 아니십니까?")
    let signUpTitleColor = Observable.just(UIColor.black)
    
    let disposeBag = DisposeBag()
    
    func bindBackgroundColor() {
//        backgroundColor
//            .subscribe { <#UIColor#> in
//                <#code#>
//            } onError: { <#any Error#> in
//                <#code#>
//            } onCompleted: {
//                <#code#>
//            } onDisposed: {
//                <#code#>
//            }
//            .disposed(by: disposeBag)
        
        // 순환 참조를 방지하기 위해 'with: self'를 주고 owner를 사용
//        backgroundColor
//            .subscribe(with: self) { owner, value in
//                owner.view.backgroundColor = value
//            } onError: { owner, error in
//                print(#function, error)
//            } onCompleted: { owner in
//                print(#function, "onComplete")
//            } onDisposed: { owner in
//                print(#function, "onDisposed")
//            }
//            .disposed(by: disposeBag)
//        
//        // 호출되지 않는 이벤트 의도적으로 호출하지 않기 위해
//        // bind 메서드로, next만 동작되도록 구현
//        backgroundColor
//            .bind(with: self) { owner, value in
//                owner.view.backgroundColor = value
//            }
//            .disposed(by: disposeBag)
        
        // 최종 코드로, 일대일 매칭이기 때문에 아래와 같이 표현도 가능
        backgroundColor.bind(to: view.rx.backgroundColor)
            .disposed(by: disposeBag)
        
        signUpTitle
            .bind(to: signUpButton.rx.title())
            .disposed(by: disposeBag)
        
        signUpTitleColor
            .bind(with: self) { owner, value in
                owner.signUpButton.setTitleColor(value, for: .normal)
            }
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        
        configureLayout()
        bindBackgroundColor()
//        configure()
        
//        signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
//        signUpButton.rx.tap.bind { _ in
//            self.navigationController?.pushViewController(SignUpViewController(), animated: true)
//        }.disposed(by: disposeBag)
        
        
        signUpButton
            .rx
            .tap
            .subscribe { _ in
                print("signup on next")
                self.navigationController?.pushViewController(SignUpViewController(), animated: true)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("signup complete")
            } onDisposed: {
                print("signup disposed")
            }
            .disposed(by: disposeBag)

        
        emailText
            .subscribe { value in
                self.emailTextField.text = value
                print("emailText on next")
            } onError: { error in
                print("emailText", error)
            } onCompleted: {
                print("emailText complete")
            } onDisposed: {
                print("emailText disposed")
            }
            .disposed(by: disposeBag)
    }
    
    @objc func signUpButtonClicked() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }
    
    
    func configure() {
        signUpButton.setTitle("회원이 아니십니까?", for: .normal)
        signUpButton.setTitleColor(Color.black, for: .normal)
    }
    
    func configureLayout() {
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(signInButton.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    

}
