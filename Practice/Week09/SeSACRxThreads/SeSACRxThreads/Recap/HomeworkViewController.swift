//
//  HomeworkViewController.swift
//  RxSwift
//
//  Created by Jack on 1/30/25.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let email: String
    let profileImage: String
}

final class HomeworkViewController: UIViewController {
    
    let viewModel = HomeworkViewModel()
    
    let tableView = UITableView()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    let searchBar = UISearchBar()
     
    let disposeBag = DisposeBag()
    
    let recents = BehaviorRelay(value: ["Jack"])
    let items = BehaviorSubject(value: ["Test"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }
     
    private func bind() {
        let recentText = PublishSubject<String>()
        let input = HomeworkViewModel.Input(searchText: searchBar.rx.text.orEmpty,
                                            searchButtonTap: searchBar.rx.searchButtonClicked, recentText: recentText)
        let output = viewModel.transform(input: input)
        
        
        Observable.zip(tableView.rx.modelSelected(String.self), tableView.rx.itemSelected)
            .map { $0.0 }
            .bind(with: self) { owner, value in
                recentText.onNext(value)
            }
            .disposed(by: disposeBag)
        
        
        output.items
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: PersonTableViewCell.identifier, cellType: PersonTableViewCell.self))
        {
            (row, element, cell) in
            cell.usernameLabel.text = element
        }
        .disposed(by: disposeBag)
        output.recent
            .asDriver()
            .drive(collectionView.rx.items(cellIdentifier: UserCollectionViewCell.identifier, cellType: UserCollectionViewCell.self)) {
                (row, element, cell) in
                cell.label.text = element
            }
            .disposed(by: disposeBag)
    }
    
//    private func bind() {
//        searchBar.rx.searchButtonClicked
//            .withLatestFrom(searchBar.rx.text.orEmpty)
//            .map { "\($0)님" }
//            .asDriver(onErrorJustReturn: "손님")      // Network Error 등 예외처리가 필요할 경우에 주로 사용
//            .drive(with: self) { owner, value in
//                var data = try! owner.items.value() // 별도의 프로퍼티, 별도의 배열 데이터 없이도 .value()를 활용해서 append 해줄 수 있다.
//                data.append(value)
//                owner.items.onNext(data)
//            }
//            .disposed(by: disposeBag)
//        
//        items
//            .asDriver(onErrorJustReturn: [])
//            .drive(tableView.rx.items(cellIdentifier: PersonTableViewCell.identifier, cellType: PersonTableViewCell.self))
//        {
//            (row, element, cell) in
//            cell.usernameLabel.text = element
//        }
//        .disposed(by: disposeBag)
//        
//        Observable.zip(tableView.rx.modelSelected(String.self), tableView.rx.itemSelected)
//            .map { $0.0 }
//            .bind(with: self) { owner, value in
//                var data = owner.recents.value
//                data.append(value)
//                owner.recents.accept(data)
//            }
//            .disposed(by: disposeBag)
//        
//        recents
//            .asDriver()
//            .drive(collectionView.rx.items(cellIdentifier: UserCollectionViewCell.identifier, cellType: UserCollectionViewCell.self)) {
//                (row, element, cell) in
//                cell.label.text = element
//            }
//            .disposed(by: disposeBag)
//    }
//    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        
        navigationItem.titleView = searchBar
         
        collectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: UserCollectionViewCell.identifier)
        collectionView.backgroundColor = .lightGray
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.identifier)
        tableView.backgroundColor = .systemGreen
        tableView.rowHeight = 100
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }

}
 
