//
//  LikeBoxViewController.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 2/26/25.
//

import UIKit
import RealmSwift

final class LikeBoxViewController: UIViewController {
    
    let realm = try! Realm()
    var products: Results<LikeListTable>!
    var filteredProducts: [LikeListTable] = []
    
    enum Section: CaseIterable {
        case main
    }
    
    let searchBar = UISearchBar()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    var dataSource: UICollectionViewDiffableDataSource<Section, Product>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        products = realm.objects(LikeListTable.self)
        filteredProducts = Array(products)

        configureUI()
    }
    
    deinit { print("Deinit LikeBox VC") }

    
}

extension LikeBoxViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function, searchText)
        if searchText.isEmpty {
            filteredProducts = Array(products)
        } else {
            filteredProducts = products.filter {
                $0.title.contains(searchText) ||
                $0.mallName.contains(searchText)
            }
        }
        collectionView.reloadData()
    }
    
}

extension LikeBoxViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.id, for: indexPath) as! ItemCollectionViewCell
        
        let data = filteredProducts[indexPath.item]
        let product = Product(productId: data.productId,
                              image: data.image,
                              mallName: data.mallName,
                              title: data.title,
                              lprice: data.lprice)
        cell.configureData(item: product)
        
        return cell
    }
    
}

extension LikeBoxViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        //        section.interGroupSpacing = 20
        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }
    
    private func configureUI() {
        navigationController?.navigationBar.backgroundColor = .black
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        searchBar.snp.makeConstraints { make
            in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make
            in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        searchBar.barTintColor = .black
        searchBar.placeholder = "위시리스트를 추가해 보세요"
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.id)
        collectionView.backgroundColor = .black
    }
    
}
