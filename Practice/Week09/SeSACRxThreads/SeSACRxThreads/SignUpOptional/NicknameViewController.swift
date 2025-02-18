//
//  NicknameViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class NicknameViewController: UIViewController {
   
    let nicknameTextField = SignTextField(placeholderText: "닉네임을 입력해주세요")
    let nextButton = PointButton(title: "다음")
    let nickname = BehaviorSubject(value: "다우니맛도리탕")
//    let nickname = Observable.just("다우니맛도리탕")
    // 랜덤 배열
    let recommandList = ["우우", "니니", "빔빔", "푸푸"]
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
       
//        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        bind()
    }
    
    func bind() {
        // .just -> Finite Sequence, 한 번 전달하고 끝이 나게 됨!!
        // 1) complete X 2) event 받음
        nickname
            .subscribe(with: self) { owner, value in
                owner.nicknameTextField.text = value
            } onError: { owner, error in
                print("nickname", error)
            } onCompleted: { owner in
                print("nickname onCompleted")
            } onDisposed: { owner in
                print("nickname onDisposed")
            }
            .disposed(by: disposeBag)
        
        nextButton.rx
            .tap
            // 함수 매개변수 안에 매개변수가 있는 상태
            // map({}) == map { } => @autoclosure
//            .map({ _ in
//
//            })
            .map {
                let random = self.recommandList.randomElement()!
                return random
            }
//            .subscribe(with: self) { owner, value in
            .bind(to: nickname)
//            .bind(with: self) { owner, value in
//                print("nextButton tap")
//                owner.nickname.onNext(value)
                    
//                let random = owner.recommandList.randomElement()!
//                owner.nickname.onNext(random)
//                owner.nickname.on(.next(random))
//            }
            .disposed(by: disposeBag)
    }
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(BirthdayViewController(), animated: true)
    }

    
    func configureLayout() {
        view.addSubview(nicknameTextField)
        view.addSubview(nextButton)
         
        nicknameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
