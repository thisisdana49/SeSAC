//
//  SampleCollectionViewController.swift
//  MyThirdApp
//
//  Created by 조다은 on 1/9/25.
//

import UIKit

class SampleCollectionViewController: UIViewController {
    @IBOutlet var bannerCollectionView: UICollectionView!
    @IBOutlet var listCollectionView: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    var array = Array(1...1000)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        
        configureCollectionView()
        configureCollectionViewLayout()
        configureListCollectionViewLayout()
        
        DispatchQueue.main.async {
            print(1)
        }
        
        print(2)
        print(3)
        print(4)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
    }
    
    func configureCollectionView() {
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        let id = SampleCollectionViewCell.identifier
        let xib = UINib(nibName: id, bundle: nil)
        bannerCollectionView.register(xib, forCellWithReuseIdentifier: id)
        
        listCollectionView.delegate = self
        listCollectionView.dataSource = self
        listCollectionView.register(xib, forCellWithReuseIdentifier: id)
    }
    
    func configureListCollectionViewLayout() {
        let sectionInset: CGFloat = 16
        let cellSpacing: CGFloat = 16
        
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = (deviceWidth - (sectionInset * 2) - (cellSpacing * 3))
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSizeMake(cellWidth/4, (cellWidth/4) * 1.2)
        layout.sectionInset = UIEdgeInsets(top: sectionInset, left: sectionInset, bottom: sectionInset, right: sectionInset)
        listCollectionView.collectionViewLayout = layout
    }
    
    func configureCollectionViewLayout() {
        bannerCollectionView.isPagingEnabled = true
        bannerCollectionView.collectionViewLayout = collectionViewLayout()
    }
}

extension SampleCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SampleCollectionViewCell.identifier, for: indexPath) as! SampleCollectionViewCell
        
        cell.backgroundColor = .blue
        cell.descImageView.backgroundColor = .white
        cell.titleLabel.text = "\(indexPath.item)"
//        cell.descImageView.layer.cornerRadius = cell.descImageView.frame.width / 2

        DispatchQueue.main.async {
            cell.descImageView.layer.cornerRadius = cell.descImageView.frame.width / 2
        }
        
        return cell
    }
}

extension SampleCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        searchBar.showsCancelButton = false
        view.endEditing(true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        searchBar.showsCancelButton = false
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
        searchBar.showsCancelButton = true
    }
    // cancel button에도 애니메이션을 적용할 수 있다!
}
