//
//  MultiSectionViewController.swift
//  SeSACRxThreads
//
//  Created by 조다은 on 2/25/25.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import SnapKit

struct Mentor {
    // Section
    var name: String   // 섹션 타이틀
    var items: [Item] // 섹션 내 셀에 들어갈 정보
}

struct Ment {
    let word: String
    let count = Int.random(in: 1...1000)
}

extension Mentor: SectionModelType {
    typealias Item = Ment
    init(original: Mentor, items: [Item]) {
        self = original
        self.items = items
    }
}

final class MultiSectionViewController: UIViewController {

    private let tableView = UITableView()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        let mentor = [
            Mentor(name: "Jack", items: [
                Ment(word: "맛점하셨나요"),
                Ment(word: "별거없는데"),
                Ment(word: "돌아오세요"),
            ])
//            Mentor(name: "Jack", items: [
//                "맛점하셨나요?", "별거없는데", "돌아오세요", "가보겠습니다"
//            ]),
//            Mentor(name: "Den", items: [
//                "정답은 없죠", "스스로 해보시고", "파이팅"
//            ]),
//            Mentor(name: "Bran", items: [
//                "잘 되시나요"
//            ])
        ]
        
        // 1 - TableViewSectionedDataSource<SectionModelType>
        // 4 - SectionModelType.Item
        let dataSource = RxTableViewSectionedReloadDataSource<Mentor> { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: "sectionCell", for: indexPath)
            cell.textLabel?.text = "\(item.word) - \(item.count)"
            return cell
        }
//        titleForHeaderInSection: { dataSource, index in
//            return mentor[index].name
//        }
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].name
        }
 
        Observable.just(mentor)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "sectionCell")
        tableView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

}
