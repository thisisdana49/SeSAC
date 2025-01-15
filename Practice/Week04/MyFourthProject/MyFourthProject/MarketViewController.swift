//
//  MarketViewController.swift
//  SeSACFourthWeek
//
//  Created by Jack on 1/14/25.
//

import UIKit
import Alamofire
import SnapKit

/*
 서버에서 키를 바꾸면 앱이 터진다... 
 */

class MarketViewController: UIViewController {
 
    let tableView = UITableView()
    
    var markets: [Market] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureTableView()

        callRequest()
    }
    
    func callRequest() {
        let url = "https://api.upbit.com/v1/market/all"
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [Market].self) { response in
            switch response.result {
            case .success(let markets):
                dump(markets)
                self.markets = markets
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.backgroundColor = .white
        tableView.rowHeight = 50
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MarketTableViewCell.self, forCellReuseIdentifier: MarketTableViewCell.id)
    }
    
    func configureView() {
        view.backgroundColor = .white
    }

}

extension MarketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return markets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MarketTableViewCell.id, for: indexPath) as? MarketTableViewCell else { return UITableViewCell() }
        
        let market = markets[indexPath.row]
        
        cell.nameLabel.text = "\(market.koreanName)"
        
        return cell
    }
    
}
