//
//  PhoneViewController.swift
//  SeSACFiveWeek
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

class PhoneViewController: UIViewController {
   
    let phoneTextField = SignTextField(placeholderText: "연락처를 입력해주세요")
    let nextButton = PointButton(title: "다음")
     
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        configureLayout()
         
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        
        // Notification Observer
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(danaReceivedNotification),
            name: NSNotification.Name("Dana"),
            object: nil
        )
    }
    
    deinit {
        print(self, #function)
    }
    
    @objc
    func danaReceivedNotification(notification: NSNotification) {
        if let name = notification.userInfo!["value"] as? String {
            print(self, name)
        } else {
            print(self, "no data from noti")
        }
    }
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(NicknameViewController(), animated: true)
    }
    
    func configureLayout() {
        view.addSubview(phoneTextField)
        view.addSubview(nextButton)
         
        phoneTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(phoneTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}

