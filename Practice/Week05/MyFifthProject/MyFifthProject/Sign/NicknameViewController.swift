//
//  NicknameViewController.swift
//  SeSACFiveWeek
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

class NicknameViewController: UIViewController {
   
    let nicknameTextField = SignTextField(placeholderText: "닉네임을 입력해주세요")
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
        // 뒤로 돌아가면 안 되니까
        navigationController?.pushViewController(MainViewController(), animated: true)
        
//        let vc = MainViewController()
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true)
        // 사용자 입장에서 느끼지는 못하지면 이전 화면들이 계속 남아있는 것
        
        // 그래서 window의 rootViewController를 교체해서 깨끗한 새 앱으로 시작하는 것처럼 구성 (extension으로 빼자!)
        // scene + window
//        UIApplication.shared.windows.first  // deprecated 됨
//        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = windowScene.windows.first else { return }
//        
//        window.rootViewController = UINavigationController(rootViewController: MainViewController())
//        window.makeKeyAndVisible()
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

