//
//  SecondTableViewController.swift
//  TourGuideApp
//
//  Created by 조다은 on 1/3/25.
//

import UIKit
import Kingfisher

class SecondTableViewController: UITableViewController {
    var travels = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let travel = travels[indexPath.row]
        
        if !travel.ad {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondTableViewCell.identifier, for: indexPath) as? SecondTableViewCell else { return SecondTableViewCell() }
            tableView.rowHeight = 160

            cell.configureData(row: travel, index: indexPath.row)
            cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondAdTableViewCell.identifier, for: indexPath) as? SecondAdTableViewCell else { return SecondAdTableViewCell() }
            tableView.rowHeight = 90
            cell.configureData(row: travel)
            
            return cell
        }
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        travels[sender.tag].like?.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
}
