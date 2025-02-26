//
//  SimpleTableViewController.swift
//  SeSACRxThreads
//
//  Created by 조다은 on 2/26/25.
//

import UIKit
import SnapKit

final class SimpleTableViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.register(UITableViewCell.self, forCellReuseIdentifier: "simpleCell")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make
            in
            make.edges.equalToSuperview()
        }
    }

}


extension SimpleTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "simpleCell")!
        var content = cell.defaultContentConfiguration()
        content.text = "그냥 텍스트"
        content.secondaryText = "두번째 텍스트"
        content.image = UIImage(systemName: "star")
        content.textProperties.color = .systemBlue
        content.textProperties.font = .systemFont(ofSize: 24, weight: .bold)
        content.imageProperties.tintColor = .systemPink
        content.imageToTextPadding = 100
        
        cell.contentConfiguration = content
        return cell
    }
    
    
}
