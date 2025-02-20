//
//  ViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    let nicknameTextField = SignTextField(placeholderText: "닉네임을 입력해주세요")
    let nextButton = PointButton(title: "다음")
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
//        bindButton()
    }
    
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

