//
//  FourTableViewController.swift
//  TourGuideApp
//
//  Created by 조다은 on 1/6/25.
//

import UIKit

class FourTableViewController: UITableViewController {
    let cityInfo = CityInfo() // CityInfo의 인스턴스 생성

    let allCities = CityInfo().city
    let domesticCities = CityInfo().city.filter { $0.domestic_travel }
    let foreignCities = CityInfo().city.filter { !$0.domestic_travel }
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(segmentedControl.selectedSegmentIndex) {
        case 0:
            return allCities.count
        case 1:
            return domesticCities.count
        case 2:
            return foreignCities.count
        default:
            return allCities.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FourTableViewCell.identifier, for: indexPath) as! FourTableViewCell
        let city: City
        
        switch(segmentedControl.selectedSegmentIndex) {
        case 0:
            city = allCities[indexPath.row]
        case 1:
            city = domesticCities[indexPath.row]
        case 2:
            city = foreignCities[indexPath.row]
        default:
            city = allCities[indexPath.row]
            break
        }
        
        cell.configureData(row: city)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    @IBAction func segmentedControlSelected(_ sender: UISegmentedControl) {
        switch(segmentedControl.selectedSegmentIndex) {
        case 0:
            tableView.reloadData()
        case 1:
            tableView.reloadData()
        case 2:
            tableView.reloadData()
        default:
            break
        }
    }
    
    private func setUI() {
        self.navigationItem.title = "인기 도시"
        
        // XIB cell
        let nib = UINib(nibName: FourTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: FourTableViewCell.identifier)
        tableView.separatorStyle = .none
        
        segmentedControl.setTitle("모두", forSegmentAt: 0)
        segmentedControl.setTitle("국내", forSegmentAt: 1)
        segmentedControl.insertSegment(withTitle: "해외", at: 2, animated: false)
    }
}
