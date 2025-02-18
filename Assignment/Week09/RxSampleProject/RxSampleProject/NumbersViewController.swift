//
//  NumbersViewController.swift
//  RxSampleProject
//
//  Created by 조다은 on 2/18/25.
//

import UIKit

final class NumbersViewController: UIViewController {

    let number1TextField = UITextField()
    let number2TextField = UITextField()
    let number3TextField = UITextField()
    let separatorView = UIView()
    let resultLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        configure()
    }
    
    private func bind() {

    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(number1TextField)
        view.addSubview(number2TextField)
        view.addSubview(number3TextField)
        view.addSubview(separatorView)
        view.addSubview(resultLabel)
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.centerY)
            $0.horizontalEdges.equalToSuperview().inset(100)
            $0.height.equalTo(1)
        }
        
        number3TextField.snp.makeConstraints {
            $0.bottom.equalTo(separatorView.snp.top).offset(-12)
            $0.horizontalEdges.equalToSuperview().inset(100)
            $0.height.equalTo(40)
        }
        number2TextField.snp.makeConstraints {
            $0.bottom.equalTo(number3TextField.snp.top).offset(-12)
            $0.horizontalEdges.equalToSuperview().inset(100)
            $0.height.equalTo(40)
        }
        number1TextField.snp.makeConstraints {
            $0.bottom.equalTo(number2TextField.snp.top).offset(-12)
            $0.horizontalEdges.equalToSuperview().inset(100)
            $0.height.equalTo(40)
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom)
            $0.horizontalEdges.equalToSuperview().inset(100)
            $0.height.equalTo(40)
        }
    
        number1TextField.borderStyle = .roundedRect
        number2TextField.borderStyle = .roundedRect
        number3TextField.borderStyle = .roundedRect
        separatorView.backgroundColor = .black
        number1TextField.textAlignment = .right
        number2TextField.textAlignment = .right
        number3TextField.textAlignment = .right
        resultLabel.textAlignment = .right
        
        number1TextField.text = "1"
        number2TextField.text = "2"
        number3TextField.text = "3"
        resultLabel.text = "6"
    }
    
}
