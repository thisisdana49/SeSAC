//
//  MarketDetailViewController.swift
//  MySeventhProject
//
//  Created by 조다은 on 2/6/25.
//

import UIKit
import SnapKit

class MarketDetailViewController: UIViewController {

    let viewModel = MarketDetailViewModel()
    
//    var viewModel: MarketViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        
//        print(viewModel?.outputCellSelected.value)
//        title = viewModel?.outputMarket.value[(viewModel?.outputCellSelected.value)!].korean_name
        
        bindData()
    }
    
    private func bindData() {
        viewModel.outputMarket.bind { market in
            // 삼항연산자 사용 또한 데이터 가공이지 않은가? & Market 이름만 쓸 건데 다 받을 필요가 있을까?
            self.navigationItem.title = market?.korean_name ?? "마켓 없음"
        }
    }
    
}


extension MarketDetailViewController {
    
    private func configureView() {
        view.backgroundColor = .lightGray
    }
    
}
