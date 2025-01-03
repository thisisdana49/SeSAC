//
//  UserTableViewController.swift
//  MySecondApp
//
//  Created by 조다은 on 1/3/25.
//

import UIKit

class UserTableViewController: UITableViewController {

    let duckArray = ["집오리", "청둥오리", "흑오리"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return duckArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell
        
        cell.profileImageView.image = UIImage(systemName: "person.fill")
        cell.aliasLabel.text = "\(duckArray[indexPath.row])"
        cell.aliasLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        cell.statusLabel.text = "I'm \(duckArray[indexPath.row])에요"
        cell.statusLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
