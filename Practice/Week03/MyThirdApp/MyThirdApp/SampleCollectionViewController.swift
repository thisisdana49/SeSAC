//
//  SampleCollectionViewController.swift
//  MyThirdApp
//
//  Created by 조다은 on 1/9/25.
//

import UIKit

class SampleCollectionViewController: UIViewController {
    @IBOutlet var bannerCollectionView: UICollectionView!
    
    var array = Array(1...1000)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureCollectionViewLayout()
    }
    
    func configureCollectionView() {
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        let id = SampleCollectionViewCell.identifier
        let xib = UINib(nibName: id, bundle: nil)
        bannerCollectionView.register(xib, forCellWithReuseIdentifier: id)
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
