//
//  MainViewController.swift
//  SeSACFiveWeek
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
   
    let statusLabel = UILabel()
    let nextButton = PointButton(title: "처음으로")
    let profileButton = PointButton(title: "프로필")
     
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        configureLayout()
         
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(profileButtonClicked), for: .touchUpInside)
        
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
        NotificationCenter.default.post(
            name: NSNotification.Name("sesac"),
            object: nil, // 거의 사용하지 않음
            userInfo: ["myData": statusLabel.text!]
        )
        
        if let name = notification.userInfo!["value"] as? String {
            statusLabel.text = name
        } else {
            statusLabel.text = "데이터가 안 왔어열"
        }
    }
    
//    @objc
//    func profileButtonClicked(a: Int) {
//        print(#function)
//    }
                                
    @objc
    func profileButtonClicked() {
        let vc = NotificationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func nextButtonClicked() {
        navigationController?.pushViewController(EmailViewController(), animated: true)
    }
    
    func configureLayout() {
        view.addSubview(statusLabel)
        view.addSubview(nextButton)
        view.addSubview(profileButton)
         
        statusLabel.text = "메인 화면"
        
        profileButton.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(statusLabel.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}

