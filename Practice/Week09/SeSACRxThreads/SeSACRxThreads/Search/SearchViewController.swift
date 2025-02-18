//
//  SearchViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 8/1/24.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class SearchViewController: UIViewController {
   
    private let tableView: UITableView = {
       let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .lightGray
        view.rowHeight = 180
        view.separatorStyle = .none
       return view
     }()
    let searchBar = UISearchBar()
    
    let items = Observable.just([
        "First Item",
        "Second Item",
        "Third Item"
    ])
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configure()
        setSearchController()
        bind()
    }
    
    func bind() {
        items
        .bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as! SearchTableViewCell
            cell.textLabel?.text = "\(element) @ row \(row)"
            return cell
        }
        .disposed(by: disposeBag)
        
        // 2개 이상의 Observable을 하나로 합쳐줌!
        Observable.zip(tableView.rx.itemSelected, tableView.rx.modelSelected(String.self)
        )
        .map {
            return "\($0.0)는 \($0.1)"
            
        }
        .bind(with: self) { owner, value in
            print(value)
        }
        
//        tableView.rx.itemSelected
//            .bind { index in
//            print(index)
//        }
//        .disposed(by: disposeBag)
//        
//        tableView.rx.modelSelected(String.self)
//            .bind(with: self) { owner, value in
//                print(value)
//            }
    }
     
    private func setSearchController() {
        view.addSubview(searchBar)
        navigationItem.titleView = searchBar
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(plusButtonClicked))
    }
    
    @objc func plusButtonClicked() {
        print("추가 버튼 클릭")
    }

    
    private func configure() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }

    }
}
