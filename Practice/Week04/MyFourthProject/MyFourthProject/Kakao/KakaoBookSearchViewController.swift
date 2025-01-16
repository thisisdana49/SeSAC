//
//  KakaoBookSearchViewController.swift
//  SeSACFourthWeek
//
//  Created by Jack on 1/14/25.
//

import UIKit
import Alamofire
import Kingfisher
import SnapKit

/*
 Pagenation
 1. 스크롤이 끝날 쯤 다음 페이지를 요청
 2. 이전 내용도 확인해야 해서 list.append로 수정
 또 어떤 것을 고쳐야 할까?
 +) 다른 검색어를 입력한 경우, 배열 초기화
 +) 페이지가 1페이지로 돌아가도록 설정
 +) 스크롤이 내려간 상태에서 다른 키워드를 입력했을 때, 최상단으로 다시 올라가기
 +) 마지막 페이지인 경우 더이상 호출하지 않기
 */


class KakaoBookSearchViewController: UIViewController {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    var list: [BookDetail] = []
    var searchWord: String = "" {
        didSet {
            page = 1
        }
    }
    
    var page = 1
    var isEnd = false
    
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
        tableView.prefetchDataSource = self
        tableView.register(KakaoBookSearchTableViewCell.self, forCellReuseIdentifier: KakaoBookSearchTableViewCell.id)
        
    }
    
}

extension KakaoBookSearchViewController: UISearchBarDelegate {
    // 빈칸, 최소 1자 이상, 같은 단어에 대한 처리 로직 필요
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
        let url = "https://dapi.kakao.com/v3/search/book?query=\(searchWord)&size=20&page=\(page)"
        let headers: HTTPHeaders = [ "Authorization": "KakaoAK \(apiKey)"]
        
        AF.request(url, method: .get, headers: headers)
            .validate(statusCode: 200..<300)    // default로 숨어있음
        //            .validate(statusCode: 200..<500)    // success에서 다함께 처리하고 싶다? 넓~게 잡아서 처리함.
            .responseDecodable(of: Book.self) { response in
                dump(self.list)
                print(self.page)
                switch response.result {
                case .success(let book):
                    print("Search Request Success")
                    //                self.list = book.documents 갈아끼워주는 것이 아니라 기존 배열에 append 해야함
                    self.isEnd = book.meta.isEnd
                    if self.page == 1 {
                        self.list = book.documents
                    } else {
                        self.list.append(contentsOf: book.documents)
                    }
                    
                    self.tableView.reloadData()
                    
                    if self.page == 1 {
                        self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}

// MARK: UITableView DataSource Prefetching
extension KakaoBookSearchViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print(#function, indexPaths)
        
        // 20개 size => 0, 19
        //
        for item in indexPaths {
            // 사용자의 마지막 스크롤 시점
            if (list.count - 2) == item.row && !isEnd {
                page += 1
                callRequest()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print(#function, indexPaths)
    }
    
}

extension KakaoBookSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KakaoBookSearchTableViewCell.id, for: indexPath) as? KakaoBookSearchTableViewCell else { return UITableViewCell() }
        
        let book = list[indexPath.row]
        
        let image = URL(string: book.thumbnail)
        cell.thumbnailImageView.kf.setImage(with: image)
        
        cell.titleLabel.text = book.title
        cell.subTitleLabel.text = book.price.formatted()
        cell.overviewLabel.text = book.contents
        cell.thumbnailImageView.backgroundColor = .brown
        //        print(#function, indexPath)
        
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //        print(#function, indexPath)
    //    }
    
    // MARK: UIScrollView Delegate : UITableView Delegate가 UIScroll을 상속 받고 있음.
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        print(#function, scrollView.contentSize.height, scrollView.contentOffset.y)
    //    }
    
}

//#Preview {
//    KakaoBookSearchViewController()
//}
