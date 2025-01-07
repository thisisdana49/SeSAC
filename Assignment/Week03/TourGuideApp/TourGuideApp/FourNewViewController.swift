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
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
        collectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FourNewCollectionViewCell.identifier, for: indexPath) as! FourNewCollectionViewCell
        
        return cell
    }
    
    private func setUI() {
        // XIB cell set up
        let nib = UINib(nibName: FourNewCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: FourNewCollectionViewCell.identifier)
        
        searchTextField.placeholder = "어디로 떠나볼까요? 😎"
//        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        searchButton.setImage(UIImage(systemName: "magnifyingglass")?.withTintColor(.systemGray3).withRenderingMode(.alwaysOriginal), for: .normal)
        segmentedControl.setTitle("모두", forSegmentAt: 0)
        segmentedControl.setTitle("국내", forSegmentAt: 1)
        segmentedControl.insertSegment(withTitle: "해외", at: 2, animated: false)
    }
}
