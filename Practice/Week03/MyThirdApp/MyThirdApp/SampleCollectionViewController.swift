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
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
//        layout.itemSize = CGSize(width: 100, height: 50)
//        layout.itemSize = CGSize(width: view.window?.windowScene?.screen.bounds.width, height: 50)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 120)
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        
        bannerCollectionView.isPagingEnabled = true
        bannerCollectionView.collectionViewLayout = layout
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
        
        return cell
    }
}
