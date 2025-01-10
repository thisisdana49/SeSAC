//
//  SettingViewController.swift
//  MyThirdApp
//
//  Created by 조다은 on 1/10/25.
//

import UIKit

// 1) 인스턴스 생성 여부: 클래스/구조체 - 인스턴스 O, 열거형 - 인스턴스 X
// 2) Setting 구조체 인스턴스 생성만 안된다면 쓰면 되는 거 아니야?
// -> 안 써도 되긴 함~ 가능한!
// 3) 그럼에도 불구하고 '열거형'을 써야할 때는 언제인가?
// -> 고유성 / 유일성 - '객관식'처럼 각각이 전부 고유하고 유일한 값이어야 할 때 사용.

struct Settings {
    static let total = "전체 설정"
    static let personal = "개인 설정"
    static let others = "기타"
    
    private init() {}
}

// ** 멤버와 값을 분리 => rawValue
// CaseIterable => case를 배열로 표현해줄 수 있음
enum SettingOptions: String, CaseIterable {
    static let hello = "다우니"
    func introduce() {
        print("안녕하세요")
    }
    
    case total = "전체 설정"
    case personal = "개인 설정"
    case others = "기타"
}

class SettingViewController: UIViewController {
//    let sectionList: [SettingOptions] = [.total, .personal, .others]
    let sectionList: [SettingOptions] = SettingOptions.allCases
    let rowList: [[String]] = [
        ["공지사항", "실험실", "버전 정보"],
        ["개인/보안", "알림", "채팅", "멀티프로필"],
        ["고객센터/도움말"]
    ]
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // 열거형의 멤버
        print(SettingOptions.total)
        //열거형의 rawValue
        print(SettingOptions.total.rawValue)
        print(Settings.personal)
        
        print(SettingOptions.allCases)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell")!
        cell.textLabel?.text = "테스트"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingOptions.allCases[section].rawValue
    }
}
