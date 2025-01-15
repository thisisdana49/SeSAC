//
//  ViewController.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/15/25.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

//    let searchBar = CustomSearchBar()
    let mainImageView = UIImageView()
    let mainLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
        configureNavController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.searchController?.searchBar.text = ""
    }
    
    func configureHierarchy() {
        view.addSubview(mainImageView)
        view.addSubview(mainLabel)
    }
    
    func configureLayout() {
        mainImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(40)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func configureView() {
//        searchBar.delegate = self

        view.backgroundColor = .black
        
        mainImageView.image = .main
        mainImageView.contentMode = .scaleAspectFit
        
        mainLabel.text = "정말로 쇼핑하고 시퍼요"
        mainLabel.textColor = .white
        mainLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
    }
    
    func configureNavController() {
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

// MARK: UISearchBar Delegate
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty, text.count > 1 else {
            return
        }
        print(#function)
        let vc = SearchResultViewController()
        vc.searchWord = text
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//#Preview {
//    MainViewController()
//}
