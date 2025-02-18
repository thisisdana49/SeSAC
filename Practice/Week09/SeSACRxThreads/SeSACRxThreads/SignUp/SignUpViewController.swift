//
//  SignUpViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SignUpViewController: UIViewController {

    let emailTextField = SignTextField(placeholderText: "이메일을 입력해주세요")
    let validationButton = UIButton()
    let nextButton = PointButton(title: "다음")
    
    let emailPlaceHolder = Observable.just("이메일을 입력해주세요")
    
    var disposeBag = DisposeBag()
    
    func bind() {
        // 4자리 이상이 되면 중복 확인은 enabled, 다음 버튼은 hidden false
        let validation = emailTextField
            .rx
            .text
            .orEmpty    // String Type
            .map { $0.count >= 4 }
        
//        validation
//            .bind(to: nextButton.rx.isHidden)
//            .disposed(by: disposeBag)
        
//        validation
//            .bind(to: validationButton.rx.isEnabled)
//            .disposed(by: disposeBag)
        
        validation
            .subscribe(with: self) { owner, value in
                owner.validationButton.isEnabled = value
                print("Validation Next")
            } onDisposed: { owner in
                print("Validation Disposed")
            }
//            .dispose()
            .disposed(by: disposeBag)
        
        validationButton.rx.tap
            .bind(with: self) { owner, _ in
                print("validation button tapped")
                owner.disposeBag = DisposeBag()
            }
            .disposed(by: disposeBag)
        
        emailPlaceHolder
            .bind(to: emailTextField.rx.placeholder)
            .disposed(by: disposeBag)
    }
    
    private func operatorExample() {
        let itemA = [3, 5, 23, 28, 4, 5]
        
        Observable.from(itemA)
            .subscribe(with: self) { owner, value in
                print("JUST", value)
            } onError: { owner, error in
                print("JUST", error)
            } onCompleted: { owner in
                print("JUST onCompleted")
            } onDisposed: { owner in
                print("JUST onDisposed")
            }
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        configure()
        bind()
        operatorExample()
        
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)

    }
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(PasswordViewController(), animated: true)
    }

    func configure() {
        validationButton.setTitle("중복확인", for: .normal)
        validationButton.setTitleColor(Color.black, for: .normal)
        validationButton.layer.borderWidth = 1
        validationButton.layer.borderColor = Color.black.cgColor
        validationButton.layer.cornerRadius = 10
    }
    
    func configureLayout() {
        view.addSubview(emailTextField)
        view.addSubview(validationButton)
        view.addSubview(nextButton)
        
        validationButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(100)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.leading.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.trailing.equalTo(validationButton.snp.leading).offset(-8)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    

}
