//
//  BasicTableViewController.swift
//  MySecondApp
//
//  Created by 조다은 on 1/2/25.
//

import UIKit

class BasicTableViewController: UITableViewController {

    let list = ["Project", "Main Task", "SeSAC Assignment"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 모두 같은 높이를 주려고 할 때는 그냥 이렇게 주면 됨.
        tableView.rowHeight = 80
    }
    
    // 1. Number of Section
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Default value is 1
        return 1
    }
    
    // 2. Number of Rows in Section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 왜 두 번 호출이 되나?
        // Apple이 부르는 거라서 의문을 가지지 않아도 될 듯함
        print(#function)
        return list.count
    }
    
    // ⭐️ 3. Cell design and Data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell의 개수만큼 호출이 된다
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell")
        
        cell?.textLabel?.text = list[indexPath.row]
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        cell?.detailTextLabel?.text = "상세보기"
        
        print(#function, indexPath)
        
        return cell ?? UITableViewCell()
    }
    
    // 3. Height for Row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 200
        } else {
            return 80
        }
    }
}
