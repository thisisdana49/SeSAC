//
//  FolderListViewController.swift
//  WishStack
//
//  Created by 조다은 on 3/5/25.
//

import UIKit
import RealmSwift
import SnapKit

final class FolderListViewController: UIViewController {

    let searchBar = UISearchBar()
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var list: List<Wish>
    var id: ObjectId!

    let repository: WishRepository = WishTableRepository()
    let folderRepository: FolderRepository = FolderTableRepository()
     
    init(list: List<Wish>, id: ObjectId!) {
        self.list = list
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }
    
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
        tableView.reloadData()
    }
    
    private func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    private func configureView() {
        view.backgroundColor = .white
        navigationItem.title = folderRepository.getCurrentFolderName(id: id)
        
        searchBar.delegate = self
        
        tableView.rowHeight = 64
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ListCell")
    }
    
    private func configureConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(48)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension FolderListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let inputText = searchBar.text else { return }
        let folder = folderRepository.getCurrentFolder(id: id)
        let wish = Wish(title: inputText)
        
        repository.createItemInFolder(folder: folder, wish: wish)
        
        tableView.reloadData()
        searchBar.text = ""
    }
    
}

extension FolderListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell")!
        
        let data = list[indexPath.row]
        
        cell.textLabel?.text = data.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = list[indexPath.row]
        repository.deleteItem(data: data)
        tableView.reloadData()
    }
    
}
