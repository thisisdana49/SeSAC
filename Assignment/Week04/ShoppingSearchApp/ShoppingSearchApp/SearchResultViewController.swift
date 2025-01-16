//
//  SearchResultViewController.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/15/25.
//

import UIKit
import Alamofire
import SnapKit

class SearchResultViewController: UIViewController {
    
    var mainView = SearchResultView()
    
    let sortStandards = ["sim", "date", "dsc", "asc"]
    var searchWord: String = ""
    let display: Int = 30
    var start: Int = 1
    var isEnd: Bool = false
    var sortStandard: String = "sim"
    var item: Item?

    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        
        callRequest()
    }

    func callRequest() {
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(searchWord)&sort=\(sortStandard)&start=\(start)&display=\(display)"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": naverClientID,
            "X-Naver-Client-Secret": naverClientSecret
        ]
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Item.self) { response in
            switch response.result {
            case .success(let value):
                if self.start == 1 {
                    self.item = value
//                    dump(self.item)
                    if let total = self.item?.total {
                        self.mainView.totalLabel.text = "\(total.formatted(.number))개의 검색 결과"
                    }
                } else {
                    self.item?.items.append(contentsOf: value.items)
                }
                self.mainView.collectionView.reloadData()
                
                if self.start == 1 {
                    self.mainView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                }

//                dump(self.itemDetails.first!)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc
    func sortButtonTapped(_ button: UIButton) {
        button.isSelected = true
        start = 1
        sortStandard = sortStandards[button.tag]
        if button.isSelected {
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
            for (_, e) in mainView.stackView.subviews.enumerated() {
                let index = e as! UIButton
                if index != button {
                    index.isSelected = false
                    index.backgroundColor = .black
                    index.setTitleColor(.white, for: .normal)
                }
            }
        } else {
            button.backgroundColor = .black
            button.setTitleColor(.white, for: .normal)
        }

        callRequest()
    }
    
    func configureViewController() {
        self.navigationItem.title = searchWord
        self.navigationController?.navigationBar.topItem?.title = ""

        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.prefetchDataSource = self
        mainView.collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.id)
        mainView.collectionView.backgroundColor = .black
        
        for (index, view) in mainView.stackView.subviews.enumerated() {
            guard let button = view as? UIButton else { return }
            button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        }
    }

}

// MARK: UICollectionView Delegate, DataSource
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.id, for: indexPath) as? ItemCollectionViewCell, let item = item?.items[indexPath.item] else { return UICollectionViewCell() }
        
        cell.configureData(item: item)
        
        return cell
    }
    
}

// MARK:
extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let itemsCount = item?.items.count else { return }
        for indexPath in indexPaths {
            if (itemsCount - 2) == indexPath.item {
                if start < item!.total {
                    print(#function, start)
                    start += display
                    callRequest()
                } else {
                    print("it's end", start)
                    isEnd = true
                }
            }
        }
    }
    
}
