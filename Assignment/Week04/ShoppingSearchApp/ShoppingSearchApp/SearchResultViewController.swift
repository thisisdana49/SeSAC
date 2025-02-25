//
//  SearchResultViewController.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/15/25.
//

import UIKit
import RxCocoa
import RxDataSources
import RxSwift

struct ItemModel {
    var name: String   // 섹션 타이틀
    var items: [Item] // 섹션 내 셀에 들어갈 정보
}

extension ItemModel: SectionModelType {
    typealias Item = Product
    init(original: ItemModel, items: [Item]) {
        self = original
        self.items = items
    }
}

final class SearchResultViewController: BaseViewController {
    
    private let viewModel: SearchResultViewModel
    private var mainView = SearchResultView()
    
    init(keyword: String) {
        self.viewModel = SearchResultViewModel(keyword: keyword)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func bindViewModel() {
        let input = SearchResultViewModel.Input(fetchData: Observable.just(()))
        let output = viewModel.transform(input: input)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<ItemModel> { dataSource, collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.id, for: indexPath) as! ItemCollectionViewCell
            cell.configureData(item: item)
            
            return cell
        }
        
        output.resultProduct
            .drive(mainView.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        
//        let testModel = [ItemModel(name: "title", items: [])]
//        Observable.just(testModel)
//            .bind(to: mainView.collectionView.rx.items(dataSource: dataSource))
//            .disposed(by: disposeBag)
//        
//        output.resultProduct
//            .drive(with: self) { owner, value in
//                owner.mainView.collectionView.rx.items(dataSource: dataSource)
//            }
//            .disposed(by: disposeBag)
//        viewModel.outputItem.lazyBind { [weak self] item in
//            print("view controller", self?.viewModel.outputTotalText.value)
//            self?.mainView.collectionView.reloadData()
//        }
//        
//        viewModel.outputScrollToTop.lazyBind { [weak self] _ in
//            self?.mainView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
//        }
//        
//        viewModel.outputTotalText.bind { [weak self] text in
//            self?.mainView.totalLabel.text = text
//        }
    }
    
    @objc
//    func sortButtonTapped(_ selectedButton: UIButton) {
//        viewModel.inputSortButtonTapped.value = selectedButton.tag
//        selectedButton.isSelected = true
//        selectedButton.setNeedsUpdateConfiguration()
//        if selectedButton.isSelected {
//            for (_, e) in mainView.stackView.subviews.enumerated() {
//                let button = e as! CustomButton
//                print(#function, button.isSelected)
//                if button.tag != selectedButton.tag {
//                    button.isSelected = false
//                    button.setNeedsUpdateConfiguration()
//                }
//            }
//        }
//    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: UICollectionView Delegate, DataSource
//extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return viewModel.outputItem.value?.items.count ?? 0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.id, for: indexPath) as? ItemCollectionViewCell,
//              let item = viewModel.outputItem.value?.items[indexPath.item] else { return UICollectionViewCell() }
//        
//        cell.configureData(item: item)
//        
//        return cell
//    }
//    
//}

extension SearchResultViewController {
    
    func configureUI() {
        self.navigationItem.title = viewModel.keyword.value
        self.navigationController?.navigationBar.topItem?.title = ""
        
//        mainView.collectionView.delegate = self
//        mainView.collectionView.dataSource = self
//        mainView.collectionView.prefetchDataSource = self
        mainView.collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.id)
        mainView.collectionView.backgroundColor = .black
        
        for (_, view) in mainView.stackView.subviews.enumerated() {
            guard let button = view as? UIButton else { return }
//            button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
            
            if button.tag == 0 {
                button.isSelected = true
            }
        }
        
    }
}
