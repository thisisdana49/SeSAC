//
//  NotificationViewController.swift
//  MyFifthProject
//
//  Created by 조다은 on 1/23/25.
//

import UIKit

extension NSNotification.Name {
    static let sesac = NSNotification.Name("sesac")
}


class NotificationViewController: UIViewController {

    let valueTextField = SignTextField(placeholderText: "Noti를 통한 앖 전달")
    let saveButton = PointButton(title: "저장하기")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureLayout()
        
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        
        // Post전에 Observer가 먼저 등록되어 있어야 한다!!
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(sesacReceivedNotification),
            name: NSNotification.Name.sesac,
            object: nil
        )
    }
    
    @objc func sesacReceivedNotification() {
        print(#function)
    }
    
    @objc
    func saveButtonClicked() {
        // Notification을 통해 값을 보내기
        NotificationCenter.default.post(
            name: NSNotification.Name("Dana"),
            object: nil, // 거의 사용하지 않음
            userInfo: ["nickname": "It's me!",
                       "value": valueTextField.text!]
        )
        
        navigationController?.popViewController(animated: true)
    }

    func configureLayout() {
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
