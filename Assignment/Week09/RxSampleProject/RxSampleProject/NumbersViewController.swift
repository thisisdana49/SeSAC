//
//  NumbersViewController.swift
//  RxSampleProject
//
//  Created by 조다은 on 2/18/25.
//

import UIKit
import RxCocoa
import RxSwift

final class NumbersViewController: BaseViewController, ViewControllerProtocol {

    let number1 = UITextField()
    let number2 = UITextField()
    let number3 = UITextField()
    let separatorView = UIView()
    let resultLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        configure()
    }
    
    internal func bind() {
        Observable.combineLatest(
            number1.rx.text.orEmpty, number2.rx.text.orEmpty, number3.rx.text.orEmpty) { textValue1, textValue2, textValue3 -> Int in
                print(textValue1)
                print(textValue2)
                print(textValue3)
                return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0) + (Int(textValue3) ?? 0)
        }
            .map { $0.description }
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    internal func configure() {
        view.backgroundColor = .white
        view.addSubview(number1)
        view.addSubview(number2)
        view.addSubview(number3)
        view.addSubview(separatorView)
        view.addSubview(resultLabel)
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.centerY)
            $0.horizontalEdges.equalToSuperview().inset(100)
            $0.height.equalTo(1)
        }
        
        number3.snp.makeConstraints {
            $0.bottom.equalTo(separatorView.snp.top).offset(-12)
            $0.horizontalEdges.equalToSuperview().inset(100)
            $0.height.equalTo(40)
        }
        number2.snp.makeConstraints {
            $0.bottom.equalTo(number3.snp.top).offset(-12)
            $0.horizontalEdges.equalToSuperview().inset(100)
            $0.height.equalTo(40)
        }
        number1.snp.makeConstraints {
            $0.bottom.equalTo(number2.snp.top).offset(-12)
            $0.horizontalEdges.equalToSuperview().inset(100)
            $0.height.equalTo(40)
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(100)
            $0.height.equalTo(40)
        }
    
        number1.borderStyle = .roundedRect
        number2.borderStyle = .roundedRect
        number3.borderStyle = .roundedRect
        separatorView.backgroundColor = .black
        
        number1.textAlignment = .right
        number2.textAlignment = .right
        number3.textAlignment = .right
        resultLabel.textAlignment = .right
        
        number1.text = "1"
        number2.text = "2"
        number3.text = "3"
        resultLabel.text = "6"
    }
    
}
