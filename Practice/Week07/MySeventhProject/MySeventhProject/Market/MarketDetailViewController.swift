//
//  MarketDetailViewController.swift
//  MySeventhProject
//
//  Created by 조다은 on 2/6/25.
//

import UIKit
import SnapKit

final class MarketDetailViewController: UIViewController {

    let viewModel = MarketDetailViewModel()
    
//    var viewModel: MarketViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        
//        print(viewModel?.outputCellSelected.value)
//        title = viewModel?.outputMarket.value[(viewModel?.outputCellSelected.value)!].korean_name
        
        bindData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("Market Detail View Controlelr", #function)
    }
    
    deinit {
        print(#function)
    }
    
    private func bindData() {
        viewModel.outputMarket.bind { [weak self] data in
            // 삼항연산자 사용 또한 데이터 가공이지 않은가? & Market 이름만 쓸 건데 다 받을 필요가 있을까?
            self?.navigationItem.title = data
        }
    }
    
}


extension MarketDetailViewController {
    
    private func configureView() {
        view.backgroundColor = .lightGray
    }
    
}
