//
//  SecondTableViewController.swift
//  TourGuideApp
//
//  Created by 조다은 on 1/3/25.
//

import UIKit
import Kingfisher

class SecondTableViewController: UITableViewController {

    let travels = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return travels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath) as? SecondTableViewCell else { return SecondTableViewCell() }

        let travel = travels[indexPath.row]
        
        cell.titleLabel.text = travel.title
        cell.titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        cell.titleLabel.textColor = .darkGray
        
        cell.descLabel.text = travel.description
        cell.descLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        cell.descLabel.textColor = .systemGray2
        
        if let grade = travel.grade, let save = travel.save, let img = travel.travel_image {
            cell.detailInfoLabel.text = "\(grade) · 저장 \(save)"
            cell.detailInfoLabel.font = UIFont.systemFont(ofSize: 13)
            cell.detailInfoLabel.textColor = .systemGray3
            if let imgURL = URL(string: img) {
                cell.travelImageView.kf.setImage(with: imgURL)
                cell.travelImageView.contentMode = .scaleAspectFill
                cell.travelImageView.layer.cornerRadius = 10
            } else {
                cell.travelImageView.image = .no
            }
        } else {
            cell.detailInfoLabel.text = "It's add"
        }
            
        return cell
    }

}
