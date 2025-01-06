//
//  FourTableViewController.swift
//  TourGuideApp
//
//  Created by 조다은 on 1/6/25.
//

import UIKit

class FourTableViewController: UITableViewController, UITextFieldDelegate {
    let cityInfo = CityInfo()  // CityInfo의 인스턴스 생성

    let allCities = CityInfo().city
    let domesticCities = CityInfo().city.filter { $0.domestic_travel }
    let foreignCities = CityInfo().city.filter { !$0.domestic_travel }

    var isSearching: Bool = false
    var filteredCities: [City] = []

    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var segmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()

        searchTextField.delegate = self
    }

    // MARK: - Table view data source

    override func tableView(
        _ tableView: UITableView, numberOfRowsInSection section: Int
    ) -> Int {
        if isSearching {
            return filteredCities.count
        } else {
            switch segmentedControl.selectedSegmentIndex {
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
    }

    override func tableView(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: FourTableViewCell.identifier, for: indexPath)
            as! FourTableViewCell
        let city: City
        let searchText = searchTextField.text ?? ""

        if isSearching {
            city = filteredCities[indexPath.row]
        } else {
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                city = allCities[indexPath.row]
            case 1:
                city = domesticCities[indexPath.row]
            case 2:
                city = foreignCities[indexPath.row]
            default:
                city = allCities[indexPath.row]
            }
        }

        cell.configureData(row: city, searchText: searchText)

        return cell
    }

    override func tableView(
        _ tableView: UITableView, heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 130
    }

    @IBAction func segmentedControlSelected(_ sender: UISegmentedControl) {
        isSearching = false
        searchTextField.text = ""
        tableView.reloadData()
    }

    // TextField Delegate
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let searchText = textField.text, !searchText.isEmpty else {
            isSearching = false
            filteredCities = []
            tableView.reloadData()
            return
        }

        isSearching = true
        let trimmedText = searchText.capitalized.trimmingCharacters(in: [" "])

        let currentCities: [City]
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            currentCities = allCities
        case 1:
            currentCities = domesticCities
        case 2:
            currentCities = foreignCities
        default:
            currentCities = allCities
        }

        filteredCities = currentCities.filter {
            $0.city_name.contains(trimmedText)
                || $0.city_english_name.contains(trimmedText)
                || $0.city_explain.contains(trimmedText)
        }

        tableView.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }

    private func setUI() {
        self.navigationItem.title = "인기 도시"

        // XIB cell
        let nib = UINib(nibName: FourTableViewCell.identifier, bundle: nil)
        tableView.register(
            nib, forCellReuseIdentifier: FourTableViewCell.identifier)
        tableView.separatorStyle = .none

        searchTextField.placeholder = "어디로 떠나볼까요? 😎"
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        searchButton.setImage(UIImage(systemName: "magnifyingglass")?.withTintColor(.systemGray3).withRenderingMode(.alwaysOriginal), for: .normal)
        segmentedControl.setTitle("모두", forSegmentAt: 0)
        segmentedControl.setTitle("국내", forSegmentAt: 1)
        segmentedControl.insertSegment(withTitle: "해외", at: 2, animated: false)
    }
}
