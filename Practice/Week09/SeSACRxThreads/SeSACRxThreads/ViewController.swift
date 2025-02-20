//
//  ViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import RxCocoa
import RxSwift

enum QuizError: Error {
    case incorrect
}

class ViewController: UIViewController {
    
    let nicknameTextField = SignTextField(placeholderText: "닉네임을 입력해주세요")
    let nextButton = PointButton(title: "다음")
    
    let disposeBag = DisposeBag()
    
    let textFieldValue = BehaviorRelay(value: "고래고래")
    let publishSubject = PublishSubject<Int>()
    let behaviorSubject = BehaviorSubject(value: 0)
    
    let quiz = Int.random(in: 1...10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        randomNumber()
            .subscribe(with: self) { owner, value in
                print(value)
            }
            .disposed(by: disposeBag)

        bindCustomObservable()
        print("quiz is ", quiz)
//        bindTextField()
        //        bindButton()
    }
    
    private func randomNumber() -> Observable<Int> {
        return Observable<Int>.create { value in
            value.onNext(Int.random(in: 1...10))
            print("random number is", value)
            return Disposables.create()
        }
    }
    
    private func randomQuiz(number: Int) -> Observable<Bool> {
        
        return Observable<Bool>.create { value in
            if number == self.quiz {
                value.onNext(true)
                value.onCompleted()
            } else {
                value.onNext(false)
                value.onCompleted()
//                value.onError(QuizError.incorrect)
            }
            return Disposables.create()
        }
    }
    
    private func bindCustomObservable() {
        nextButton.rx.tap
            .map { Int.random(in: 1...10) }
            .bind(with: self) { owner, value in
                print("value", value)
                
                owner.play(value: value)
            }
            .disposed(by: disposeBag)
    }
    
    private func play(value: Int) {
        randomQuiz(number: value)
            .subscribe(with: self) { owner, value in
                print("my result is", value)
            } onError: { owner, error in
                print("my result is", error)
            } onCompleted: { owner in
                print("my result is complete")
            } onDisposed: { owner in
                print("my result is disposed")
            }
            .disposed(by: disposeBag)
    }
    
    private func bindTextField() {
        textFieldValue
            .subscribe(with: self) { owner, value in
                owner.nicknameTextField.text = value
                print("textfield Text changed")
            }
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .bind(with: self) { owner, _ in
//                owner.textFieldValue.onNext("TestTestTest")
                print("텍스트 필드에 글자 가져오기")
                let result = owner.textFieldValue.value
                print("text field value", result)
            }
            .disposed(by: disposeBag)
    }
    
//    private func bindTextField() {
//        // UI 처리에 특화된 Observable이 Trait
//        // RxCocoa의 Trait은 ControlProperty, ControlEvent, Driver
//        nicknameTextField.rx.text.orEmpty
//            .subscribe(with: self) { owner, value in
//                print("subscribe", value)
//                print("실시간으로 텍스트필드 달라짐")
//            } onError: { owner, error in
//                print("error", error)
//            } onCompleted: { owner in
//                print("complete")
//            } onDisposed: { owner in
//                print("dispose")
//            }
//            .disposed(by: disposeBag)
//        
////        publishSubject
////            .subscribe(with: self) { owner, value in
////                print("publish subscribe", value)
////            } onError: { owner, error in
////                print("error", error)
////            } onCompleted: { owner in
////                print("complete")
////            } onDisposed: { owner in
////                print("dispose")
////            }
////            .disposed(by: disposeBag)
////        
////        behaviorSubject
////            .subscribe(with: self) { owner, value in
////                print("behavior subscribe", value)
////            } onError: { owner, error in
////                print("error", error)
////            } onCompleted: { owner in
////                print("complete")
////            } onDisposed: { owner in
////                print("dispose")
////            }
////            .disposed(by: disposeBag)
//        
//        nextButton.rx.tap
//            .bind(with: self) { owner, _ in
//                owner.nicknameTextField.text = "5"
//            }
//            .disposed(by: disposeBag)
//    }
    
    private func bindButton() {
        
        let button = nextButton.rx.tap
            .map { print("버튼 클릭") }
            .debug("1")
            .debug("2")
            .debug("3")
            .map { "안녕하세요 \(Int.random(in: 1...100))" }
//            .share() // 하나의 subscribe를 공유하도록 함
//            .asDriver(onErrorJustReturn: "")
        
        button
//            .drive(navigationItem.rx.title)
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        button
//            .drive(nextButton.rx.title())
            .bind(to: nextButton.rx.title())
            .disposed(by: disposeBag)
        
        button
//            .drive(nicknameTextField.rx.text)
            .bind(to: nicknameTextField.rx.text)
            .disposed(by: disposeBag)
    }
    
    // subscribe vs bind vs drive
//    private func bindButton() {
//        Step 1
//        nextButton.rx.tap
//            .subscribe(with: self) { owner, _ in
//                print(#function)
//            } onError: { owner, error in
//                print(#function, error)
//            } onCompleted: { owner in
//                print(#function, "completed")
//            } onDisposed: { owner in
//                print(#function, "disposed")
//            }
//            .disposed(by: disposeBag
//
//        // 버튼 > 서버통신(비동기) > UI업데이트(main)
//        nextButton.rx.tap
//            .map {
//                print("This Thread1 is Main? ", Thread.isMainThread)
//            }
//            .observe(on: ConcurrentDispatchQueueScheduler(qos: .default))
//            .map {
//                print("This Thread2 is Main? ", Thread.isMainThread)
//            }
//            .observe(on: MainScheduler.instance)
//            .bind(with: self) { owner, _ in
//                print("This Thread3 is Main? ", Thread.isMainThread)
//                print(#function, "bind click")
//            }
//            .disposed(by: disposeBag)
//                      
//        nextButton.rx.tap
//            .asDriver()
//            .drive(with: self) { owner, _ in
//                print("drive")
//            }
//    }

    func configureLayout() {
        view.backgroundColor = .white
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

