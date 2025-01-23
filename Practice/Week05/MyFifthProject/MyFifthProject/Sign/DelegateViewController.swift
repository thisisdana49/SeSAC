//
//  DelegateViewController.swift
//  MyFifthProject
//
//  Created by 조다은 on 1/23/25.
//

import UIKit

class DelegateViewController: UIViewController {

    // 화면 전환 시 값 전달
    
    var contents: PassDataDelegate?
    
    let valueTextField = SignTextField(placeholderText: "Delegate를 통한 앖 전달")
    let saveButton = PointButton(title: "저장하기")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureLayout()
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)

//        valueTextField.text = contents
    }
    
    @objc
    func saveButtonClicked() {
//        동일한 인스턴스의 메인 뷰 컨트롤러를 어떻게 가지고 올 수 있을까?
//        -> 타입으로써의 프로토콜을 이용해보자!
//        MainViewController().nicknameReceived()
        contents?.nicknameReceived(value: valueTextField.text!)
        navigationController?.popViewController(animated: true)
    }

    func configureLayout() {
        view.backgroundColor = .white
        view.addSubview(valueTextField)
        view.addSubview(saveButton)
         
        valueTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        saveButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(valueTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
