//
//  NewSearchViewController.swift
//  SeSACRxThreads
//
//  Created by 조다은 on 2/24/25.
//

import UIKit
import RxCocoa
import RxSwift

final class NewSearchViewController: UIViewController {

    private let viewModel = NewSearchBarModel()
    
    private let tableView: UITableView = {
       let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .lightGray
        view.rowHeight = 180
        view.separatorStyle = .none
       return view
     }()
    let searchBar = UISearchBar()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setSearchController()
        bind()
    }
    
    private func bind() {
        // input - searchBar.rx.searchButtonClicked, searchBar.rx.text.orEmpty
        let input = NewSearchBarModel.Input(searchTap: searchBar.rx.searchButtonClicked,
                                searchText: searchBar.rx.text.orEmpty)
        // output - list
        let output = viewModel.transform2(input: input)
        
        output.list
            .bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
                cell.appNameLabel.text = element.movieNm
            }
            .disposed(by: disposeBag)
        
        // flatMap
        tableView.rx.itemSelected
            .flatMapLatest { _ in
                Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).debug("timer")
            }.debug("cell")
            .subscribe(with: self) { owner, value in
                print(value)
            }
            .disposed(by: disposeBag)
        
        // withLatestFrom
//        tableView.rx.itemSelected
//            .withLatestFrom(Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance))
//            .subscribe(with: self) { owner, value in
//                print(value)
//            }
//            .disposed(by: disposeBag)
        
        // Map
//        tableView.rx.itemSelected
//            .map { _ in
//                Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
//            }
//            .subscribe(with: self) { owner, value in
//                value.subscribe { value in
//                    print(value)
//                }
//                .disposed(by: owner.disposeBag)
//            }
//            .disposed(by: disposeBag)
    }
    
    private func setSearchController() {
        view.addSubview(searchBar)
        navigationItem.titleView = searchBar
    }
    
    @objc func plusButtonClicked() {
        print("추가 버튼 클릭")
    }

    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}
