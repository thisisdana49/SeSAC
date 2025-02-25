//
//  ViewController.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/15/25.
//

import UIKit
import RxCocoa
import RxSwift

final class MainViewController: BaseViewController {

    let viewModel = MainViewModel()
    let mainView = MainView()
    var searchBar = UISearchBar()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavController()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.searchController?.searchBar.text = ""
    }
    
    override func bindViewModel() {
        let input = MainViewModel.Input(searchBarText: searchBar.rx.text.orEmpty,
                                        returnKeyTap: searchBar.rx.searchButtonClicked)
        let output = viewModel.transform(input: input)
        
        output.searchResult
            .debug("searchResult")
            .drive(with: self) { owner, value in
                let vc = SearchResultViewController(keyword: value)
                owner.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
        
//        viewModel.outputSearchBarText.lazyBind { [weak self] value in
//            self?.navigationItem.searchController?.searchBar.text = ""
//        }
//        
//        viewModel.outputPushVC.lazyBind { [weak self] value in
//            let vc = SearchResultViewController()
//            // TODO: forced unwrapping
//            vc.viewModel.keyword = value
//            
//            self?.navigationController?.pushViewController(vc, animated: true)
//        }
    }
    
}

extension MainViewController {
    
    private func configureNavController() {
        let searchController = UISearchController()
        self.searchBar = searchController.searchBar

        searchController.searchBar.tintColor = .lightGray
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField, let leftView = textField.leftView as? UIImageView {
            textField.backgroundColor = .darkGray
            textField.textColor = .blue
            textField.attributedPlaceholder = NSAttributedString(
                string: "브랜드, 상품, 프로필, 태그 등",
                attributes: [.foregroundColor: UIColor.lightGray]
            )
            
            leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
            leftView.tintColor = .lightGray
        }
        self.navigationItem.searchController = searchController
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationItem.title = "쇼핑쇼핑"
        
        self.navigationController?.navigationBar.tintColor = .white
    }
    
}
