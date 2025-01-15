//
//  ViewController.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/15/25.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {

    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("main view did load")
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        view.addSubview(searchBar)
    }
    
    func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(40)
        }
    }

    func configureView() {
        navigationController?.title = "쇼핑쇼핑"
        view.backgroundColor = .black
        
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = .lightGray
    }
    
}


#Preview {
    MainViewController()
}
