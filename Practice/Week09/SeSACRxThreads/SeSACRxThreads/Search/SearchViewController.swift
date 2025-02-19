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
    
    lazy var items = BehaviorSubject(value: data)
    
    var data = [
        "First Item",
        "Second Item",
        "Third Item",
        "AAA",
        "C", "B", "AB", "ABC",
        "D", "DD", "E", "F", "G"
    ]
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configure()
        setSearchController()
        bind()
    }
    func test() {
//        let mentor = Observable.of("Hue", "Jack", "Den", "Bran")
        let mentor = Observable.of("Hue", "Jack")
        let age = Observable.of(10, 11, 12, 13)
        
        Observable.combineLatest(mentor, age)
            .bind(with: self) { owner, value in
                print(value.0, value.1)
            }
            .disposed(by: disposeBag)
    }
    
    func bind() {
        items.bind(to: tableView.rx.items(cellIdentifier: SearchTableViewCell.identifier, cellType: SearchTableViewCell.self)) { (row, element, cell) in
            cell.appNameLabel.text = element
            cell.appIconImageView.backgroundColor = .lightGray
            cell.downloadButton.rx.tap
                .bind(with: self) { owner, value in
                    print("cell tapped", value)
                    owner.navigationController?.pushViewController(DetailViewController(), animated: true)
                }
                .disposed(by: cell.disposeBag)
        }
        .disposed(by: disposeBag)
        
        // SearchBar Enter + Table View Append
        searchBar.rx.searchButtonClicked
            .withLatestFrom(searchBar.rx.text.orEmpty)
//            .withLatestFrom(searchBar.rx.text.orEmpty,
//                            resultSelector: { _, text in
//                return "\(text)가 입력되었습니다."
//            })
            .bind(with: self) { owner, value in
                owner.data.insert(value, at: 0)
                owner.items.onNext(owner.data)
            }
            .disposed(by: disposeBag)
        
        // 실시간
        searchBar.rx.text.orEmpty
//            .filter { value -> [Int] in
//                self.data.contains(value) }
        // throttle vs debounce
            .debounce(.seconds(1), scheduler: MainScheduler.asyncInstance)
            .distinctUntilChanged()
            .bind(with: self) { owner, value in
                print(value)
                // 빈 문자열인 경우에는 전체 데이터, 그외에는 value를 포함하는 데이터를 TableView에 출력
                // 데이터가 100만개, 혹은 실시간 서버통신
                let result =  value == "" ? owner.data : owner.data.filter { $0.contains(value) }
                owner.items.onNext(result)
            }
            .disposed(by: disposeBag)
        
        
    }
    
//    func bind() {
//        searchBar.rx.searchButtonClicked
//            .withLatestFrom(searchBar.rx.text.orEmpty)
//            .distinctUntilChanged()
//            .bind(with: self) { owner, value in
//                print("Return key pressed", value)
//            }
//            .disposed(by: disposeBag)
//        
//        searchBar.rx.text.orEmpty
//            .throttle(.seconds(1), scheduler: MainScheduler.instance)
//            .distinctUntilChanged()
//            .bind(with: self) { owner, value in
//                print("실시간 글자", value)
//            }
//            .disposed(by: disposeBag)
//        
//        items
//        .bind(to: tableView.rx.items) { (tableView, row, element) in
//            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as! SearchTableViewCell
//            cell.textLabel?.text = "\(element) @ row \(row)"
//            return cell
//        }
//        .disposed(by: disposeBag)
//        
//        // 2개 이상의 Observable을 하나로 합쳐줌!
//        Observable.combineLatest(
//            tableView.rx.itemSelected,
//            tableView.rx.modelSelected(String.self)
//        )
//        .map {
//            return "\($0.0)는 \($0.1)"
//            
//        }
//        .bind(with: self) { owner, value in
//            print(value)
//        }
//        .disposed(by: disposeBag)
////        tableView.rx.itemSelected
////            .bind { index in
////            print(index)
////        }
////        .disposed(by: disposeBag)
////        
////        tableView.rx.modelSelected(String.self)
////            .bind(with: self) { owner, value in
////                print(value)
////            }
     
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
