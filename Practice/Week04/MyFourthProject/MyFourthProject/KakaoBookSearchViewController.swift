//
//  KakaoBookSearchViewController.swift
//  SeSACFourthWeek
//
//  Created by Jack on 1/14/25.
//

import UIKit
import Alamofire
import SnapKit

class KakaoBookSearchViewController: UIViewController {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    var list: [BookDetail] = []
    var searchWord: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureSearchBar()
        configureTableView()
        
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func configureSearchBar() {
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        searchBar.delegate = self
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
        
        tableView.keyboardDismissMode = .onDrag
        tableView.rowHeight = 120
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(KakaoBookSearchTableViewCell.self, forCellReuseIdentifier: KakaoBookSearchTableViewCell.id)

    }

}

extension KakaoBookSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        guard let text = searchBar.text, searchWord != text else { print("it's same"); return }
        searchWord = text
        callRequest()
    }
    /*
     1. 검색어
     1.1. 지난 검색어와 같다면 요청 보내지 X
     2. 이미지
     */
    
    func callRequest() {
        print(#function)
        let url = "https://dapi.kakao.com/v3/search/book?query=\(searchWord)"
        let headers: HTTPHeaders = [ "Authorization": "KakaoAK \(apiKey)"]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: Book.self) { response in
            switch response.result {
            case .success(let book):
                print("Search Request Success")
                self.list = book.documents
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}


extension KakaoBookSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KakaoBookSearchTableViewCell.id, for: indexPath) as? KakaoBookSearchTableViewCell else { return UITableViewCell() }
        
        let book = list[indexPath.row]
        
        cell.titleLabel.text = book.title
        cell.subTitleLabel.text = book.price.formatted()
        cell.overviewLabel.text = book.contents
        cell.thumbnailImageView.backgroundColor = .brown
        
        return cell
    }
    
}

//#Preview {
//    KakaoBookSearchViewController()
//}
