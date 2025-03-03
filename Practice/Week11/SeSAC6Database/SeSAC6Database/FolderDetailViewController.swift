//
//  FolderDetailViewController.swift
//  SeSAC6Database
//
//  Created by 조다은 on 3/5/25.
//

import UIKit
import RealmSwift
import SnapKit

class FolderDetailViewController: UIViewController {

    let tableView = UITableView()
    
    var list: List<JackTable>!
    var id: ObjectId!

    let repository: JackRepository = JackTableRepository()
    let folderRepository: FolderRepository = FolderTableRepository()
     
    override func viewDidLoad() {
        super.viewDidLoad()

        print(#function)
        print(repository.getFileURL())
        configureHierarchy()
        configureView()
        configureConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
//        let data = realm.objects(JackTable.self)
//            .sorted(byKeyPath: "money", ascending: false)
//        list = Array(data)
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
          
        let image = UIImage(systemName: "plus")
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(rightBarButtonItemClicked))
        navigationItem.rightBarButtonItem = item
    }
    
    private func configureConstraints() {
         
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
     
    @objc func rightBarButtonItemClicked() {
        let vc = AddViewController()
        vc.id = id
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension FolderDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.id) as! ListTableViewCell
        
        let data = list[indexPath.row]
        
//        cell.testUI()
        cell.titleLabel.text = data.title
        cell.subTitleLabel.text = data.category
        cell.overviewLabel.text = "\(data.money.formatted())"
        cell.thumbnailImageView.image = loadImageFromDocument(filename: "\(data.id)")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        removeImageFromDocument(filename: data.id.stringValue)
        repository.deleteItem(data: data)
        tableView.reloadData()
    }
}
