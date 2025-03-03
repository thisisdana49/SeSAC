//
//  FolderViewController.swift
//  SeSAC6Database
//
//  Created by 조다은 on 3/5/25.
//

import UIKit
import RealmSwift

class FolderViewController: UIViewController{

    let tableView = UITableView()
    var list: Results<Folder>!
    let repository: FolderRepository = FolderTableRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let title = NSLocalizedString("navigation_title_nickname", comment: "")
//        let titleFormat = String(format: title, "고래밥")
//        navigationItem.title = titleFormat
        navigationItem.title = "navigation_title_nickname".localized(with: "고래밥")

//        repository.createItem(name: "개인")
//        repository.createItem(name: "계모임")
//        repository.createItem(name: "회사")
//        repository.createItem(name: "멘토")
        
        configureHierarchy()
        configureView()
        configureConstraints()
        
        list = repository.fetchAll()
        dump(list)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    private func configureView() {
        view.backgroundColor = .white
        tableView.rowHeight = 130
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.id)
        
        let image = UIImage(systemName: "star")
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        navigationItem.rightBarButtonItem = item
        
        let image2 = UIImage(systemName: "pencil")
        let item2 = UIBarButtonItem(image: image2, style: .plain, target: self, action: #selector(leftBarButtonItemClicked))
        navigationItem.leftBarButtonItem = item2
    }
    
    private func configureConstraints() {
         
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    @objc func rightBarButtonItemClicked() {
        let vc = MainViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @objc func leftBarButtonItemClicked() {
        let vc = BackupViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension FolderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id, for: indexPath) as! ListTableViewCell
        
        let data = list[indexPath.row]
        cell.titleLabel.text = data.name
        cell.subTitleLabel.text = "\(data.detail.count)개"
//        cell.overviewLabel.text = "test_text".localized
        cell.overviewLabel.text = "cell_age".localized(number: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        let vc = FolderDetailViewController()
        vc.list = data.detail
        vc.id = data.id
        navigationController?.pushViewController(vc, animated: true)
        
        // 폴더 삭제
        // 폴더 지울 때 세부 항목도 지울 것인지?
        // 폴더 지울 때 세부 항목을 다른 폴더로 이동해줄 것인지?
//        let data = list[indexPath.row]
//        repository.deleteItem(data: data)
//        tableView.reloadData()
        
        // Embedded Object
//        let data = list[indexPath.row]
//        repository.createMemo(data: data)
    }
    
}
