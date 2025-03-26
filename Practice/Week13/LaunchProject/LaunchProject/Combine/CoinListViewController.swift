//
//  CoinListViewController.swift
//  LaunchProject
//
//  Created by 조다은 on 3/26/25.
//

import UIKit
import Combine
import SnapKit

class CoinListViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MarketTableViewCell.self, forCellReuseIdentifier: "MarketCell")
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    var markets: Markets = [Market(market: "DANA", koreanName: "다니", englishName: "danibani")] {
        didSet { tableView.reloadData() }
    }
    
    let viewModel: CoinListViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: CoinListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindViewModel()
    }
    
    private func bindViewModel() {
        let input = CoinListViewModel.Input(viewOnTask: Just(()).eraseToAnyPublisher())
        let output = viewModel.transform(input: input)
        
        output.markets
            .sink { [weak self] markets in
                self?.markets = markets
            }
            .store(in: &cancellables)
        
        output.isLoading
        //            .sink { <#Subscribers.Completion<Never>#> in
        //                <#code#>
        //            } receiveValue: { <#Bool#> in
        //                <#code#>
        //            }
            .sink { [weak self] isLoading in
                isLoading ? self?.loadingIndicator.startAnimating() : self?.loadingIndicator.stopAnimating()
            }
            .store(in: &cancellables)
        
        output.error
            .compactMap { $0 }
            .sink { [weak self] errorMessage in
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
            }
            .store(in: &cancellables)
        
    }
    
    private func setupUI() {
        title = "My Money"
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        tableView.dataSource = self
    }
    
}

extension CoinListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return markets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarketCell", for: indexPath) as! MarketTableViewCell
        let market = markets[indexPath.row]
        cell.configure(with: market)
        return cell
    }
}
