//
//  PasswordViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class PasswordViewController: UIViewController {
   
    let passwordTextField = SignTextField(placeholderText: "비밀번호를 입력해주세요")
    let nextButton = PointButton(title: "다음")
    let password = BehaviorSubject(value: "1234")
    var disposeBag = DisposeBag()
    // Scheduler == Main, Global처럼 GCD와 같은 개념으로 연결
    let timer = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.asyncInstance)
    
    deinit {
        // self Ωㅐㅂ쳐로 인해서 deinit 되지 않고 인스턴스가 계속 남아있음. Rx의 모든 코드가 살아있는 상태
        // Deinit이 될 때 구독이 정상적으로 해제 된다.
        // -> 왜, VC가 Deinit 되면 dispose 되는 걸까요??
        print("Password VC Deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        
        bind()
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            self.disposeBag = DisposeBag()
//        }
//        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
    }
    
    func bind() {
        // 구독을 해제하는 시점을 수동으로 조절
//        let incrementValue =
        timer
            .subscribe(with: self) { owner, value in
                print("Timer", value)
            } onError: { owner, error in
                print("Timer", error)
            } onCompleted: { owner in
                print("Timer owner")
            } onDisposed: { owner in
                print("Timer Disposed")
            }
            .disposed(by: disposeBag)

        
        password.bind(to: passwordTextField.rx.text)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap  // 이벤트 전달, Observable, Next
            .bind(with: self) { owner, _ in
                print("next Button")
                
//                incrementValue.dispose()
                
                let random = ["우우", "니니", "빔빔"]
//                owner.passwordTextField.text = random.randomElement()
                
                // 1. 왜 등호가 안 될까?
                // 2. 왜 값을 바꿀 수 없을까?
                // => Observable 객체, 이벤트를 받는 역할이니까.
//                owner.password = random.randomElement()
                owner.password.onNext(random.randomElement()!)
                owner.navigationController?.pushViewController(PhoneViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(PhoneViewController(), animated: true)
    }
    
    func configureLayout() {
        view.addSubview(passwordTextField)
        view.addSubview(nextButton)
         
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
