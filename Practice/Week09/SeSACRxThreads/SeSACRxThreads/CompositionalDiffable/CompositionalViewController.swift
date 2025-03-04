//
//  CompositionalViewController.swift
//  SeSACRxThreads
//
//  Created by 조다은 on 2/27/25.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
/*
 1. 겸침 허용 X - Hashable
 */
final class CompositionalViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    enum Section: CaseIterable {
        case First
        case Second
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    //
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    var list = [1, 2, 3, 5, 2412, 13, 6241, 241, 3623, 346, 2345 ,36, 354]
    var list2 = [6, 12, 22, 126, 0, 41, 12341, 234, 25345, 12425, 345243, 34535]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureDataSource()
        updateSnapshot()
        multiUnicast()
    }
    
    // Observable(unicast) - 구독 간 스트림이 공유되지 않는다.
    // Subject(multicast)  - 단일 스트림을 여러 구독자에게 공유한다. 모든 구독이 동일한 스트림을 받음. (≓ share)
    private func multiUnicast() {
//        let sampleInt = Observable<Int>.create { observer in
//            observer.onNext(Int.random(in: 1...100))
//            return Disposables.create()
//        }
        // Hot Observable VS Cold Observable
        // HOT
        // subject는 구독 시점과 상관 없이 이벤트를 방출할 수 있다
        // 데이터 스트림을 중간부터 확인하게 될 수 있다.
        
        // COLD
        // 구독이 발생할 때까지 기다렸다가 이벤트를 방출
        // 처음부터 모든 데이터 스트림을 확인할 수 있다...!!!
        
        let just = Observable.just([1, 3, 8])
        just.subscribe { <#Event<[Int]>#> in
            <#code#>
        }
        
        let sampleInt = PublishSubject<Int>()
        sampleInt.onNext(Int.random(in: 1...100))
        
        sampleInt
            .subscribe { value in
                print("1:", value)
            }
            .disposed(by: disposeBag)
        
        sampleInt
            .subscribe { value in
                print("2:", value)
            }
            .disposed(by: disposeBag)
        
        sampleInt
            .subscribe { value in
                print("3:", value)
            }
            .disposed(by: disposeBag)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            if sectionIndex == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                      heightDimension: .fractionalHeight(1/3))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                
                let innerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                                       heightDimension: .fractionalHeight(1))
                
                let innerGroup = NSCollectionLayoutGroup.vertical(layoutSize: innerSize,
                                                                  subitems: [item])
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(300),
                                                       heightDimension: .absolute(100))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [innerGroup])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                
                return section
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                //        section.interGroupSpacing = 20
                return section
            }
        }
        
        
        
        return layout
    }
    
    // 외부 그룹, 내부 그룹 활용
//    private func createLayout() -> UICollectionViewLayout {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                              heightDimension: .fractionalHeight(1/3))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        
//        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
//        
//        let innerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
//                                               heightDimension: .fractionalHeight(1))
//        
//        let innerGroup = NSCollectionLayoutGroup.vertical(layoutSize: innerSize,
//                                                          subitems: [item])
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(300),
//                                               heightDimension: .absolute(100))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [innerGroup])
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .groupPaging
//
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        return layout
//    }
    
    // 배너처럼 구현
//    private func createLayout() -> UICollectionViewLayout {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
//                                              heightDimension: .fractionalHeight(1))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        
//        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
//        
//        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(300),
//                                               heightDimension: .absolute(100))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        
//        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .groupPagingCentered
//        
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        return layout
//    }

//    private func createLayout() -> UICollectionViewLayout {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(1))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        let section = NSCollectionLayoutSection(group: group)
////        section.interGroupSpacing = 20
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        return layout
//    }

//    private func createLayout() -> UICollectionViewLayout {
//        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
//        
//        configuration.backgroundColor = .purple
//        configuration.showsSeparators = true
////        configuration.leadingSwipeActionsConfigurationProvider
//        
//        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
//        return layout
//    }
    
    private func configureDataSource() {
        // cell register
        let cellRegistration = UICollectionView.CellRegistration<CompositionalCollectionViewCell, Int> { cell, indexPath, itemIdentifier in
//            var content = UIListContentConfiguration.subtitleCell()
//            content.text =
//            content.image = UIImage(systemName: "star")
//            cell.contentConfiguration = content
            cell.label.text = "\(itemIdentifier)"
        }
        
        // cell for item at
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            print("cell registration", indexPath)
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            print("reusable cell", indexPath)
            return cell
        })
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(list, toSection: Section.First)
        snapshot.appendItems(list2, toSection: Section.Second)
        
        dataSource.apply(snapshot)
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make
            in
            make.edges.equalToSuperview()
        }
    }
}

