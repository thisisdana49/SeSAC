//
//  FourTableViewController.swift
//  TourGuideApp
//
//  Created by 조다은 on 1/6/25.
//

import UIKit

class FourTableViewController: UITableViewController {
    let cities = CityInfo().city
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // XIB cell
        let nib = UINib(nibName: FourTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: FourTableViewCell.identifier)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FourTableViewCell.identifier, for: indexPath)

        return cell
    }
}
