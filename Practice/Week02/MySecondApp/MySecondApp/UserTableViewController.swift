//
//  UserTableViewController.swift
//  MySecondApp
//
//  Created by 조다은 on 1/3/25.
//

import UIKit
import Kingfisher

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
        
        let friend = friends[indexPath.row]
        
        let imageUrl = friend.profile_image
        if let imageUrl {
            let url = URL(string: imageUrl)
            cell.profileImageView.kf.setImage(with: url)
        } else {
            cell.profileImageView.image = UIImage(systemName: "person.fill")
        }
//        cell.profileImageView.layer.cornerRadius = cell.profileImageView.image?.size.height.
        
        cell.aliasLabel.text = friend.name
        cell.aliasLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        
        cell.statusLabel.text = friend.message
        cell.statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        cell.likeButton.setImage(UIImage(systemName: friend.like ? "heart.fill" : "heart"), for: .normal)
        cell.likeButton.tag = indexPath.row
        // IBAction 대신에 코드로 연결
        // Function Types
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        // self : 이 TableView에서 일어날 일이야
        // .touchUpInside : 눌렀을 때 일어날 일이야
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        print(#function, sender.tag)
        friends[sender.tag].like.toggle()
        tableView.reloadData()
    }
}
