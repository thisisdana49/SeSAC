//
//  ViewController.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/15/25.
//

import UIKit

class MainViewController: UIViewController {

    let viewModel = MainViewModel()
    let mainView = MainView()
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavController()
        bindData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.searchController?.searchBar.text = ""
    }
    
    private func bindData() {
        
        viewModel.outputSearchBarText.lazyBind { [weak self] value in
            self?.navigationItem.searchController?.searchBar.text = ""
        }
        
        viewModel.outputPushVC.lazyBind { [weak self] value in
            let vc = SearchResultViewController()
            // TODO: forced unwrapping
            vc.viewModel.keyword = value
            
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

// MARK: UISearchBar Delegate
extension MainViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print(#function)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputReturnKeyTapped.value = searchBar.text
    }
    
}

extension MainViewController {
    
    private func configureNavController() {
        let searchController = UISearchController()
        let searchBar = searchController.searchBar
        searchBar.delegate = self

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
