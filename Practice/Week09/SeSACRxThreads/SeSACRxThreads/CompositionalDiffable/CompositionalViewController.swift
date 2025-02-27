//
//  CompositionalViewController.swift
//  SeSACRxThreads
//
//  Created by 조다은 on 2/27/25.
//

import UIKit
import SnapKit
/*
 1. 겸침 허용 X - Hashable
 */
final class CompositionalViewController: UIViewController {

    enum Section: CaseIterable {
        case First
        case Second
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    //
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    var list = [1, 2, 3, 5, 2412, 13, 6241, 241]
    var list2 = [1, 2, 6, 12, 22, 126, 0, 41]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureDataSource()
        updateSnapshot()
    }

    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3), heightDimension: .fractionalHeight(0.5))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    
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
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewCell, Int> { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.subtitleCell()
            content.text = "\(itemIdentifier)"
            content.image = UIImage(systemName: "star")
            cell.contentConfiguration = content
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

