//
//  SimpleCollectionViewController.swift
//  SeSACRxThreads
//
//  Created by 조다은 on 2/26/25.
//

import UIKit
import SnapKit

/*
 Data
 -> Delegate, DataSource (인덱스 기반 O, list[indexPath.row]처럼)
 -> Diffable DataSource (인덱스 기반 X, 데이터(or모델) 기반, list[indexPath.row] 더 이상X)
 
 Layout
 -> FlowLayout
 ->
 -> List Configuration
 
 Presentation
 -> CellForRowAt / dequeReusableCell
 ->
 -> List Cell / dequeConfiguredReusableCell
 
 */

// uuid vs udid

struct Product: Hashable, Identifiable {
    let id = UUID() // 내용이 같아 앱이 터지는 것을 방지하기 위해 부여
    let name: String
    let price = 40000//Int.random(in: 1...10000) * 1000
    let count = 8//Int.random(in: 1...10)
}

final class SimpleCollectionViewController: UIViewController {
    
    // 이 VC 안에서 사용하는 CollectionView의 섹션임을 알리기 위해 위치
    enum Section: CaseIterable {
        case main
        case sub
    }

    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    // collectionView.register와 동일
    //    var registration: UICollectionView.CellRegistration<UICollectionViewListCell, String>!
//    var registration: UICollectionView.CellRegistration<UICollectionViewListCell, Product>!
    // <섹션을 구분해 줄 데이터 타입, 셀에 들어가는 데이터 타입>
    // numberOfItemsInSection, cellforItemAt
    var dataSource: UICollectionViewDiffableDataSource<Section, Product>!
    // Product Confirm to Hashable
    
    var list = [
//        "Hue", "Jack", "Bran", "Den"
//        1, 2, 3, 4
        Product(name: "AirPod Max"),
        Product(name: "TrackPad"),
        Product(name: "TrackPad"),
        Product(name: "Gold")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make
            in
            make.edges.equalToSuperview()
        }
        
        collectionView.delegate = self
//        collectionView.dataSource = self
        
        configureDataSource()
        updateSnapshot()
    }
    // Flow -> Compositional -> List Configuration
    private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemGreen
        let layout = UICollectionViewCompositionalLayout.list(using: configuration) // View에 꽉차게 TableView처럼

        return layout
    }

    private func configureDataSource() {
        // cellForItemAt에 작성했던 부분에 해당
        var registration =  UICollectionView.CellRegistration<UICollectionViewListCell, Product> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell() // 어떻게 생긴 system Cell을 쓸지를 결정
            content.text = "\(itemIdentifier.name)"
            content.textProperties.color = .systemPurple
            content.textProperties.font = .systemFont(ofSize: 14, weight: .bold)
            
            content.secondaryText = itemIdentifier.price.formatted() + "원"
            content.secondaryTextProperties.color = .systemBlue
            
            content.image = UIImage(systemName: "star")
            content.imageProperties.tintColor = .systemOrange
            
            cell.contentConfiguration = content
            
            var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
            
            backgroundConfig.backgroundColor = .systemYellow
            backgroundConfig.cornerRadius = 6
            backgroundConfig.strokeColor = .systemBlue
            backgroundConfig.strokeWidth = 2
            
            cell.backgroundConfiguration = backgroundConfig
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            // Q. list[indexPath.row] ??
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Product>()
        snapshot.appendSections(Section.allCases)
        // 각자 고유한 데이터이기만 하면 됨, Int,String,Bool등 타입은 상관 없음
        // 그러나 휴먼 에러를 방지하기 위해 Enum을 사용하는 것을 권장.
        snapshot.appendItems([
            Product(name: "죠리퐁")
        ] , toSection: .sub)
        snapshot.appendItems(list, toSection: .main)
        snapshot.appendItems([
            Product(name: "쿠크다스")
        ] , toSection: .sub)
        dataSource.apply(snapshot)
    }
    
//    private func configureCell() {
//        // cellForItemAt에 작성했던 부분에 해당
//        registration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
//            var content = UIListContentConfiguration.valueCell() // 어떻게 생긴 system Cell을 쓸지를 결정
//            content.text = "\(itemIdentifier.name)"
//            content.textProperties.color = .systemPurple
//            content.textProperties.font = .systemFont(ofSize: 14, weight: .bold)
//            
//            content.secondaryText = itemIdentifier.price.formatted() + "원"
//            content.secondaryTextProperties.color = .systemBlue
//            
//            content.image = UIImage(systemName: "star")
//            content.imageProperties.tintColor = .systemOrange
//            
//            cell.contentConfiguration = content
//            
//            var backgroundConfig = UIBackgroundConfiguration.listGroupedCell()
//            
//            backgroundConfig.backgroundColor = .systemYellow
//            backgroundConfig.cornerRadius = 6
//            backgroundConfig.strokeColor = .systemBlue
//            backgroundConfig.strokeWidth = 2
//            
//            cell.backgroundConfiguration = backgroundConfig
//        }
//    }
    
}


extension SimpleCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let data = list[indexPath.item]
//        dump(data)
        let dummy = dataSource.itemIdentifier(for: indexPath)
        dump(dummy)
        
//        let product = Product(name: "고래밥\(Int.random(in: 1...100))")
//        list.insert(product, at: 2)
        //        list.remove(at: indexPath.item)
        updateSnapshot() // apply
    }
    
    // Q. 얘는 어디로 가는 거지?
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return list.count
//    }
    
    /*
     dequeReusableCell
     customCell + identifier + register
     
     dequeConfiguredReusableCell
     systemCell +     X     + Cell Registration
     */
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: list[indexPath.row])
//        return cell
//    }

}
