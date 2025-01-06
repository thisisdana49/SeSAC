//
//  MainTableViewController.swift
//  TourGuideApp
//
//  Created by 조다은 on 1/3/25.
//

import UIKit
import Kingfisher

class FirstTableViewController: UITableViewController {
    var magazines = MagazineInfo().magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazines.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FirstTableViewCell.identifier, for: indexPath) as? FirstTableViewCell else { return FirstTableViewCell() }

        let magazine = magazines[indexPath.row]
        cell.configureData(row: magazine)
        
        return cell
    }
    
    fileprivate func setUI() {
        tableView.separatorStyle = .none
        navigationItem.title = "DANA TOUR"
    }
}
