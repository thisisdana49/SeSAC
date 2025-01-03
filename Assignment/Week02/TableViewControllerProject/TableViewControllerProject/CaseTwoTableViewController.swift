//
//  CaseTwoTableViewController.swift
//  TableViewControllerProject
//
//  Created by 조다은 on 1/2/25.
//

import UIKit

class CaseTwoTableViewController: UITableViewController {

    let sectionList = ["전체 설정", "개인 설정", "기타"]
    let rowList: [[String]] = [
        ["공지사항", "실험실", "버전 정보"],
        ["개인/보안", "알림", "채팅", "멀티프로필"],
        ["고객센터/도움말"]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowList[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = rowList[indexPath.section][indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionList[section]
    }
}
