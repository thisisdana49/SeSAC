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
        
        // xib cell
        // bundle에 관련해서는 언젠가 다음 시간에.
        let nib = UINib(nibName: "NoProfileTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "NoProfileTableViewCell")
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "NoProfileTableViewCell", for: indexPath) as! NoProfileTableViewCell
        
        // ⬇️ UserTableViewCell의 인스턴스를 만듦
        // 그래서 각각의 인스턴스(김민준, 이서연...)들이 생겨나고 접근할 수 있는 것
        // 그런데 profile, alias 이런 건 달라도 identifier는 다 같지 않나? 한 공간에 두고 시용할 수 있지 않나?
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
        
        // cell의 identifier 이름과 UITableViewCell을 클래스 이름을 같게 하는게 좋음.
        // 어떻게하면 cellForRowAt의 코드 분량을 줄일 수 있을까?🤫
        // -> cell 파일 내부에 configureData 추가
        let friend = friends[indexPath.row]
        cell.configureData(row: friend)

        // cell. 아래에 자동완성으로 나오는 메서드, 프로퍼티들은 tableView가 이미 알고 있다고 보면 됨
        // 이미 연결고리로 서로 연결되어 있기 때문에 파일을 구분하는 것 -> 우리(개발자)의 편의
        
        
        // IBAction 대신에 코드로 연결
        // Function Types
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        // self : 이 TableView에서 일어날 일이야
        // .touchUpInside : 눌렀을 때 일어날 일이야
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        friends[sender.tag].like.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
}
