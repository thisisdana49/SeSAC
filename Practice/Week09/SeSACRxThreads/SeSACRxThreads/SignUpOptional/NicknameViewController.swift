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
    let nickname = PublishSubject<String>()
//    let nickname = BehaviorSubject(value: "다우니맛도리탕")
//    let nickname = Observable.just("다우니맛도리탕")
    // 랜덤 배열
    let recommandList = ["우우", "니니", "빔빔", "푸푸"]
    let disposeBag = DisposeBag()
    
    func testPublishSubject() {
        let subject = PublishSubject<Int>()
        
        subject.onNext(1)
        subject.onNext(2)
        
        subject
            .subscribe(with: self) { owner, value in
                print(#function, value)
            } onError: { owner, error in
                print(#function, error)
            } onCompleted: { owner in
                print(#function, "onCompleted")
            } onDisposed: { owner in
                print(#function, "onDisposed")
            }
            .disposed(by: disposeBag)
        
        subject.onNext(16)
        subject.onNext(114)
        subject.onCompleted()
        subject.onNext(1444)
    }
    
    func testBehaviorSubject() {
        let subject = BehaviorSubject(value: 1)
        
        subject.onNext(1)
        subject.onNext(2)
        
        subject
            .subscribe(with: self) { owner, value in
                print(#function, value)
            } onError: { owner, error in
                print(#function, error)
            } onCompleted: { owner in
                print(#function, "onCompleted")
            } onDisposed: { owner in
                print(#function, "onDisposed")
            }
            .disposed(by: disposeBag)
        
        subject.onNext(16)
        subject.onNext(114)
        subject.onCompleted()
        subject.onNext(1444)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        testPublishSubject()
        
        view.backgroundColor = Color.white
        
        configureLayout()
       
//        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        bind()
    }
    
    func bind() {
        // .just -> Finite Sequence, 한 번 전달하고 끝이 나게 됨!!
        // 1) complete X 2) event 받음
        // Observable 체인 구독 과정: 다운스트림 -> 업스트림
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
        
        nickname.onNext("테스트1")
        nickname.onNext("테스트2")
        nickname.onNext("테스트3")
        
        nextButton.rx
            .tap
            .debug("===Debug1===")
            .withUnretained(self)
            .debug("===Debug2===")
            // 함수 매개변수 안에 매개변수가 있는 상태
            // map({}) == map { } => @autoclosure
//            .map({ _ in
//            })
            .map { owner, _ in
                let random = owner.recommandList.randomElement()!
                return random
            }
            .debug("===Debug3===")
            .debug()
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
        
        // map을 써도 되지만 Observable 2개를 결합해볼 수도 있음
//        nextButton.rx.tap
//            .withLatestFrom(Observable.just(recommandList.randomElement()!))
//            .flatMapLatest(Observable.just(recommandList.randomElement()!))
//            .bind(to: nickname)
//            .disposed(by: disposeBag)
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
