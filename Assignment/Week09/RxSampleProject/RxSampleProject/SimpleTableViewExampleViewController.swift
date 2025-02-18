//
//  SimpleTableViewExampleViewController.swift
//  RxSampleProject
//
//  Created by 조다은 on 2/18/25.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class SimpleTableViewExampleViewController: BaseViewController, ViewControllerProtocol {

    let tableView = UITableView()
    let tableViewCell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
    
    let items = Observable.just(
        (0..<20).map { "\($0)" }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        configure()
    }
    
    internal func bind() {
        items
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.accessoryType = .detailButton
                cell.textLabel?.text = "\(element) @ row \(row)"
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(String.self)
            .subscribe(with: self) { owner, value in
                AlertManager.shared.showAlert(on: self, message: "Tapped `\(value)`")
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .itemAccessoryButtonTapped
            .bind(with: self) { owner, indexPath in
                AlertManager.shared.showAlert(on: self, message: "Tapped Detail @ \(indexPath.section),\(indexPath.row)")
            }
            .disposed(by: disposeBag)
    }
    
    internal func configure() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}
