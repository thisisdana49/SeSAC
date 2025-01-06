//
//  UserTableViewController.swift
//  MySecondApp
//
//  Created by 조다은 on 1/3/25.
//

import UIKit

struct Duck {
    let name: String
    let message: String
    let profileImage: String
}

class UserTableViewController: UITableViewController {
    
    var friends = FriendsInfo().list
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        // cell의 identifier 이름과 UITableViewCell을 클래스 이름을 같게 하는게 좋음.
        // 어떻게하면 cellForRowAt의 코드 분량을 줄일 수 있을까?🤫
        // -> cell 파일 내부에 configureData 추가
        let friend = friends[indexPath.row]
        cell.configureData(row: friend)
        
        // IBAction 대신에 코드로 연결
        // Function Types
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        // self : 이 TableView에서 일어날 일이야
        // .touchUpInside : 눌렀을 때 일어날 일이야
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        friends[sender.tag].like.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
}
