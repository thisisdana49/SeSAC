//
//  SearchResultViewController.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/15/25.
//

import UIKit
import RealmSwift
import RxCocoa
import RxDataSources
import RxSwift

struct ItemModel {
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
    
    let realm = try! Realm()
    
    private let viewModel: SearchResultViewModel
    private var mainView = SearchResultView()
    private var productList: [Product] = []
    
    init(keyword: String) {
        self.viewModel = SearchResultViewModel(keyword: keyword)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(realm.configuration.fileURL)
        configureUI()
        bindViewModel()
    }
    
    override func bindViewModel() {
        let sortButtons = Observable.merge(
            mainView.sortButtons[0].rx.tap.map { 0 },
            mainView.sortButtons[1].rx.tap.map { 1 },
            mainView.sortButtons[2].rx.tap.map { 2 },
            mainView.sortButtons[3].rx.tap.map { 3 }
        )
        let input = SearchResultViewModel.Input(fetchData: Observable.just(()),
                                                sortButtonTapped: sortButtons)
        let output = viewModel.transform(input: input)
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<ItemModel> { dataSource, collectionView, indexPath, item in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.id, for: indexPath) as! ItemCollectionViewCell
            cell.configureData(item: item)
            return cell
        }
        
        output.productList
            .bind(with: self) { owner, products in
                owner.productList = products
//                dump(owner.productList)
            }
            .disposed(by: disposeBag)
        
        output.resultProduct
            .drive(mainView.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        output.totalProduct
            .drive { [weak self] value in
                self?.mainView.totalLabel.text = value
            }
            .disposed(by: disposeBag)
        
        output.error
            .drive(onNext: { [weak self] errorMessage in
                print("오류", errorMessage)
                if !errorMessage.isEmpty {
                    AlertManager.shared.showAlert(
                        on: self!,
                        title: "검색 요청 오류",
                        message: errorMessage,
                        actions: [UIAlertAction(title: "확인", style: .cancel)]
                    )
                }
            })
            .disposed(by: disposeBag)
        
        output.scrollToTop
            .drive(with: self) { owner, _ in
                owner.mainView.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension SearchResultViewController: UICollectionViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let selectedItem = productList[indexPath.row]
//        let data = LikeListTable(productId: selectedItem.productId,
//                                 title: selectedItem.title,
//                                 mallName: selectedItem.mallName,
//                                 image: selectedItem.image,
//                                 lprice: selectedItem.lprice,
//                                 like: true)
//        realm.add(data)
    }
}

extension SearchResultViewController {
    
    func configureUI() {
        self.navigationItem.title = viewModel.keyword.value
        self.navigationController?.navigationBar.topItem?.title = ""
        
//        mainView.collectionView.prefetchDataSource = self
        mainView.collectionView.delegate = self
        mainView.collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.id)
        
        for (index, button) in mainView.sortButtons.enumerated() {
                    button.rx.tap
                        .bind { [weak self] in
                            self?.handleSortButtonTap(button, at: index)
                        }
                        .disposed(by: disposeBag)
                }
        
        for (_, view) in mainView.stackView.subviews.enumerated() {
            guard let button = view as? UIButton else { return }
//            button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
            
            if button.tag == 0 {
                button.isSelected = true
            }
        }
        
    }
    
    private func handleSortButtonTap(_ button: UIButton, at index: Int) {
            for (buttonIndex, view) in mainView.stackView.subviews.enumerated() {
                guard let button = view as? UIButton else { return }
                button.isSelected = buttonIndex == index
            }
        }
}
