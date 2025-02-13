//
//  NotificationViewController.swift
//  MySeventhProject
//
//  Created by 조다은 on 2/13/25.
//

import UIKit
/*
Notification 관련 정책
 - Foreground에서는 알림이 뜨지 않는 것이 default
 - Foreground에서 알림을 받고 싶은 경우, 별도 설정(delegate 필요)
 - TimeInterval 기반 반복은 60초 이상부터 가능
 - 알림 센터에 알림 스택 기준은 Identifier, 각 알림의 고유값을 의미
 - 뱃지 갯수는 알림 갯수와 무관. 일일이 관리 해주어야 함.
 - 알림센터에 보이고 있는지, 사용자에게 전달되었는지 알 수 없음.
 - 단, 사용자가 알림을 '클릭'했을 때만 확인 가능(delegate)
 - identifier: 고유값 / 64개 제한
 */
class NotificationViewController: UIViewController {

    let requestButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .brown
        configureButton()
    }
    
    func configureButton() {
        view.addSubview(requestButton)
        requestButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        requestButton.backgroundColor = .blue
        requestButton.addTarget(self, action: #selector(requestButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func requestButtonTapped() {
        print(#function)
        
        let content = UNMutableNotificationContent()
        content.title = "테스트 userinfo 활용"
        content.subtitle = "\(Int.random(in: 1...1000))"
        content.badge = 3
        content.userInfo = ["type": 2, "id": content.subtitle]
//        content.badge = 0 없애려고 할 때 0으로 설정
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
//        var components = DateComponents()
//        components.minute = 18
//        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        for item in 1...70 {
            let request = UNNotificationRequest(identifier: "noti \(item)", content: content, trigger: trigger)
            
            // Return Notification Center
            UNUserNotificationCenter.current().add(request) { error in
                print(error)
            }
        }
        
    }

}
