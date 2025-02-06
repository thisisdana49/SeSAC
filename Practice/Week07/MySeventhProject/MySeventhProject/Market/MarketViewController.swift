//
//  MarketViewController.swift
//  SeSACSevenWeek_2
//
//  Created by Jack on 2/6/25.
//

import UIKit
import SnapKit

final class MarketViewController: UIViewController {
  
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "MarketCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
      
    private let viewModel = MarketViewModel()

    deinit {
        print("MarketViewController Deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureConstraints()
        bindData()
    }
    
    // VM에서 VC로 바인딩해줄 데이터, 뷰모델에서 받아와서 뷰에 실시간 업데이트
    private func bindData() {
        // VC viewDidLoad -> VM
        viewModel.inputViewDidLoadTrigger.value = ()
        viewModel.outputMarket.lazyBind { value in
            print(#function, "Output Market bind")
            self.tableView.reloadData()
        }
        viewModel.outputTitle.lazyBind { value in
            self.navigationItem.title = value
        }
        viewModel.outputCellSelected.bind { market in
            print("OutputCell selected")
            guard let market = market else {
                print("nil이라 화면전환 된면 안 됨")
                return
            }
            
            let vc = MarketDetailViewController()
//            vc.viewModel = self.viewModel
            vc.viewModel.outputMarket.value = market
            self.navigationController?.pushViewController(vc, animated: true)
        }
//        viewModel.outputCellSelected.lazyBind { _ in
//            let vc = MarketDetailViewController()
////            vc.viewModel = self.viewModel
//            vc.viewModel.outputMarket.value = Market(market: "market", korean_name: "kor", english_name: "eng")
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
    }
}

extension MarketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputMarket.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarketCell", for: indexPath)
        let data = viewModel.outputMarket.value[indexPath.row]
        cell.textLabel?.text = "\(data.korean_name) | \(data.english_name)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.inputCellSelected.value = viewModel.outputMarket.value[indexPath.row]
    }
    
}

extension MarketViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
    }
}

extension MarketViewController {
    
    private func configureView() {
        navigationItem.title = "마켓 목록"
        view.backgroundColor = .white
        view.addSubview(tableView)
    }

    private func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
