//
//  DetailViewController.swift
//  UserSearchProject
//
//  Created by 조다은 on 2/19/25.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class DetailViewController: UIViewController {

    let nextButton = UIButton()
    var titleText = BehaviorSubject<String>(value: "")
//    var titleText = PublishSubject<String>()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
  
        titleText
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalToSuperview()
        }
        
    }


}

