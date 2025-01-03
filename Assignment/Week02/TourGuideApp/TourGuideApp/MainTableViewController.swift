//
//  MainTableViewController.swift
//  TourGuideApp
//
//  Created by 조다은 on 1/3/25.
//

import UIKit
import Kingfisher

class MainTableViewController: UITableViewController {

    var magazines = MagazineInfo().magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.separatorStyle = .none
        navigationController?.navigationItem.title = "DANA TOUR"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazines.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else { return MainTableViewCell() }

        let magazine = magazines[indexPath.row]
        
        if let img = URL(string: magazine.photo_image) {
            cell.mainImageView.kf.setImage(with: img)
        } else {
            cell.mainImageView.image = .no
        }
        cell.mainImageView.contentMode = .scaleAspectFill
        cell.mainImageView.layer.cornerRadius = 20
        
        cell.titleLabel.numberOfLines = 0
        cell.titleLabel.lineBreakMode = .byWordWrapping
        cell.titleLabel.lineBreakStrategy = .hangulWordPriority
        cell.titleLabel.text = magazine.title
        cell.titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        cell.subTitleLabel.text = magazine.subtitle
        cell.subTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        cell.subTitleLabel.textColor = .systemGray2
        
        cell.dateLabel.textAlignment = .right
        cell.dateLabel.text = magazine.date
        cell.dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        cell.dateLabel.textColor = .systemGray3
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
