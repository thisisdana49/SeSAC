//
//  MainViewController.swift
//  SeSACFiveWeek
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit


protocol PassDataDelegate {
    func nicknameReceived(value: String)
}

class MainViewController: UIViewController {
   
    let statusLabel = UILabel()
    let nextButton = PointButton(title: "처음으로")
    let profileButton = PointButton(title: "프로필")
     
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        configureLayout()
         
        nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(delegateButtonClicked), for: .touchUpInside)
        
        // Notification Obser
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
    
    func sample() {
        print("테스트 해보기")
        statusLabel.textColor = .blue
    }

    @objc
    func delegateButtonClicked() {
        let vc = DelegateViewController()
        vc.contents = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func closureButtonClicked() {
        let vc = ClosureViewController()
        //        vc.contents = { // 매개변수와 구분자 in이 완전히 생략 될 수 있는 것
        vc.contents = { (text: String) in
            print("테스트 해보기")
            self.statusLabel.text = text
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
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

extension MainViewController: PassDataDelegate {
    
    func nicknameReceived(value: String) {
        print(#function)
        statusLabel.textColor = .red
        statusLabel.text = value
    }

}
