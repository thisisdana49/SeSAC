//
//  SearchResultViewController.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/15/25.
//

import UIKit
import SnapKit

class SearchResultViewController: UIViewController {
    
    let viewModel = SearchResultViewModel()
    var mainView = SearchResultView()
    
//    let sortStandards = ["sim", "date", "dsc", "asc"]
    var searchWord: String = ""
    let display: Int = 30
//    var start: Int = 1
    var isEnd: Bool = false
    var sortStandard: String = "sim"
//    var item: Item?
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()

        bindData()
    }
    
    private func bindData() {
        viewModel.inputFetchData.value = ()
        
        viewModel.outputItem.lazyBind { [weak self] item in
            self?.mainView.totalLabel.text = self?.viewModel.totalText
            self?.mainView.collectionView.reloadData()
        }
        
        viewModel.outputScrollToTop.lazyBind { [weak self] _ in
            self?.mainView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
    }
    
    @objc
    func sortButtonTapped(_ button: UIButton) {
        viewModel.inputSortButtonTapped.value = button.tag
        button.isSelected = true
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
    }
    
}

// MARK: UICollectionView Delegate, DataSource
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputItem.value?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.id, for: indexPath) as? ItemCollectionViewCell,
              let item = viewModel.outputItem.value?.items[indexPath.item] else { return UICollectionViewCell() }
        
        cell.configureData(item: item)
        
        return cell
    }
    
}

extension SearchResultViewController {
    
    func configureViewController() {
        self.navigationItem.title = viewModel.keyword
        self.navigationController?.navigationBar.topItem?.title = ""
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
//        mainView.collectionView.prefetchDataSource = self
        mainView.collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.id)
        mainView.collectionView.backgroundColor = .black
        
        for (_, view) in mainView.stackView.subviews.enumerated() {
            guard let button = view as? UIButton else { return }
            button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        }
        
    }
}

// MARK:
//extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
//    
//    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        guard let itemsCount = item?.items.count else { return }
//        for indexPath in indexPaths {
//            if (itemsCount - 2) == indexPath.item {
//                if start < item!.total {
//                    print(#function, start)
//                    start += display
//                    callRequest()
//                } else {
//                    print("it's end", start)
//                    isEnd = true
//                }
//            }
//        }
//    }
//    
//}
