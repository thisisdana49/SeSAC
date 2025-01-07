//
//  TenViewController.swift
//  MySecondApp
//
//  Created by 조다은 on 1/7/25.
//

import UIKit


// 왜 여기서는 cellForRowAt이 없을까?
// TableView Outlet
// Table View를 만들 때 필요한 것들을 수동으로 직접 쥐어줘야함
// => Protocol(Delegate / DataSource)

/*
 1. 테이블 뷰 이름!
 2. 테이블뷰 부하직원! == 프로토콜
 3. 필수 메서드
 4. 테이블뷰와 부하직원이 서로 연결 (= 타입으로서의 프로토콜, Protocol as Type!)
 */

class TenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  4. 테이블뷰와 부하직원이 서로 연결
        self.tableView.delegate = self
        self.tableView.dataSource = self

        let xib = UINib(nibName: "NoProfileTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "NoProfileTableViewCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoProfileTableViewCell", for: indexPath) as! NoProfileTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
}
