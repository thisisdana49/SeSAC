//
//  FourNewViewController.swift
//  TourGuideApp
//
//  Created by 조다은 on 1/7/25.
//

import UIKit

class FourNewViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let cityInfo = CityInfo()

    let allCities = CityInfo().city
    let domesticCities = CityInfo().city.filter { $0.domestic_travel }
    let foreignCities = CityInfo().city.filter { !$0.domestic_travel }

    var isSearching: Bool = false
    var filteredCities: [City] = []
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var segmentedControl: UISegmentedControl!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setCollectionViewLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FourNewCollectionViewCell.identifier, for: indexPath) as! FourNewCollectionViewCell
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
        
        cell.configureData(in: city)
        
        return cell
    }
    
    @IBAction func segmentedControlSelected(_ sender: UISegmentedControl) {
        isSearching = false
        searchTextField.text = ""
        collectionView.reloadData()
    }
    
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        guard let searchText = textField.text, !searchText.isEmpty else {
            isSearching = false
            filteredCities = []
            collectionView.reloadData()
            return
        }
        
        isSearching = true
        let trimmedText = searchText.capitalized.trimmingCharacters(in: .whitespaces)
        
        let currentCitis: [City]
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            currentCitis = allCities
        case 1:
            currentCitis = domesticCities
        case 2:
            currentCitis = foreignCities
        default:
            currentCitis = allCities
        }
        
        filteredCities = currentCitis.filter {
            $0.city_name.contains(trimmedText)
            || $0.city_english_name.contains(trimmedText)
            || $0.city_explain.contains(trimmedText)
        }
        
        collectionView.reloadData()
    }
    
    private func setUI() {
        navigationItem.title = "인기 도시"
        // XIB cell set up
        let nib = UINib(nibName: FourNewCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: FourNewCollectionViewCell.identifier)
        
        searchTextField.placeholder = "어디로 떠나볼까요? 😎"
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        searchButton.setImage(UIImage(systemName: "magnifyingglass")?.withTintColor(.systemGray3).withRenderingMode(.alwaysOriginal), for: .normal)
        segmentedControl.setTitle("모두", forSegmentAt: 0)
        segmentedControl.setTitle("국내", forSegmentAt: 1)
        segmentedControl.insertSegment(withTitle: "해외", at: 2, animated: false)
    }
    
    func setCollectionViewLayout() {
        collectionView.delegate = self
        collectionView.dataSource = self
        searchTextField.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 180, height: 220)
        layout.minimumLineSpacing = 25
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
        collectionView.collectionViewLayout = layout
    }
}

extension FourNewViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
