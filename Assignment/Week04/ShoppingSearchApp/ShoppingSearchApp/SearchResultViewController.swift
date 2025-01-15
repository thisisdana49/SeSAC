//
//  SearchResultViewController.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/15/25.
//

import UIKit
import Alamofire
import SnapKit

class SearchResultViewController: UIViewController, ViewConfiguration {

    var searchWord: String = ""
    var itemDetails: [ItemDetail] = []
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest()

        configureCollectionView()
        configureHierarchy()
        configureLayout()
        configureView()
        self.collectionView.reloadData()
    }

    func callRequest() {
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(searchWord)"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "7eZfrnA2JVpvhdjYn2_c",
            "X-Naver-Client-Secret": "Z36ZX63j8a"
        ]
        AF.request(url, method: .get, headers: header).responseDecodable(of: Item.self) { response in
            switch response.result {
            case .success(let value):
                self.itemDetails = value.items
                self.collectionView.reloadData()
//                dump(self.itemDetails.first!)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.id)
        collectionView.backgroundColor = .black
    }
    
    func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
    }
    
    func createCollectionViewLayout() -> UICollectionViewFlowLayout {
        let sectionInset: CGFloat = 16
        let cellSpacing: CGFloat = 16
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = (deviceWidth - (sectionInset * 2) - cellSpacing)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSizeMake(cellWidth / 2, cellWidth / 2 * 1.5)
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionInset, bottom: 0, right: sectionInset)
        
        return layout
    }
    
}

// MARK: UICollectionView Delegate, DataSource
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.id, for: indexPath) as? ItemCollectionViewCell else { return UICollectionViewCell() }
        let item = itemDetails[indexPath.item]
        
        cell.configureData(item: item)
        
        return cell
    }
    
}
