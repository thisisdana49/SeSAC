//
//  FourTableViewController.swift
//  TourGuideApp
//
//  Created by 조다은 on 1/6/25.
//

import UIKit

class FourTableViewController: UITableViewController {
    let cities = CityInfo().city
    
    @IBOutlet var travelFilterSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // XIB cell
        let nib = UINib(nibName: FourTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: FourTableViewCell.identifier)
        tableView.separatorStyle = .none
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FourTableViewCell.identifier, for: indexPath) as! FourTableViewCell
        let city = cities[indexPath.row]
        
        cell.configureData(row: city)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
