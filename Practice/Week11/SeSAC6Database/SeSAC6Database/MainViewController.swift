//
//  MainViewController.swift
//  SeSAC6Database
//
//  Created by Jack on 3/4/25.
//

import UIKit
import RealmSwift
import SnapKit
/*
 데이터 수정
 뷰 갱신
 */
class MainViewController: UIViewController {

    let tableView = UITableView()
    
    var list: Results<JackTable>!
//    var list: [JackTable] = []
    
    let realm = try! Realm()    // Document/default.realm 을 가져오는 것과 동일
     
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        print(realm.configuration.fileURL)
        configureHierarchy()
        configureView()
        configureConstraints()
        
        dump(realm.objects(JackTable.self))
//        list = realm.objects(JackTable.self).sorted(byKeyPath: "category", ascending: false)
        list = realm.objects(JackTable.self)
//            .where { $0.title.contains("sesa", options: .caseInsensitive) }
            .sorted(byKeyPath: "money", ascending: false)
//        list = Array(data)
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
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        do {
            try realm.write {
//                realm.delete(data)
                // 수정
                realm.create(JackTable.self, value: [
                    "id": data.id,
                    "money": 1000000000
                ], update: .modified)

                tableView.reloadData()
            }
        } catch {
            print("렘 데이터 삭제")
        }
    }
      
    
}
