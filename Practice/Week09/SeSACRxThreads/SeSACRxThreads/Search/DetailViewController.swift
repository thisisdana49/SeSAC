//
//  DetailViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 8/1/24.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class DetailViewController: UIViewController {

    let nextButton = PointButton(title: "다음")
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        navigationItem.title = "Detail"
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalToSuperview()
        }
        
        let tap =  nextButton.rx.tap
            .map { Int.random(in:1...100) }
            .share()
        tap
            .bind(with: self) { owner, value in
            print("1번", value)
            }
            .disposed(by: disposeBag)
        tap
            .bind(with: self) { owner, value in
            print("2번", value)
            }
            .disposed(by: disposeBag)
        tap
            .bind(with: self) { owner, value in
            print("3번", value)
            }
            .disposed(by: disposeBag)
    }
    
}
