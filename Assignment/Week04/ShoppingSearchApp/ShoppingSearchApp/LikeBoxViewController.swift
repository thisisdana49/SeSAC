////
////  LikeBoxViewController.swift
////  ShoppingSearchApp
////
////  Created by 조다은 on 2/26/25.
////
//
//import UIKit
//
//final class LikeBoxViewController: UIViewController {
//
//    var products: [Product] = [
//        Product(
//            image: "https://shopping-phinf.pstatic.net/main_8684911/86849110626.9.jpg",
//            mallName: "거품ZERO마켓",
//            title: "큰 대왕오리인형 초 대형 거위 애착인형 모찌 동물 수면유도인형 50cm",
//            lprice: "13900"
//        ),
//        Product(
//            image: "https://shopping-phinf.pstatic.net/main_8813752/88137522441.jpg",
//            mallName: "블랑가또",
//            title: "블랑가또 오리 애착 인형 스몰 임신 출산 돌 선물",
//            lprice: "23900"
//        ),
//        Product(
//            image: "https://shopping-phinf.pstatic.net/main_8817166/88171661983.jpg",
//            mallName: "Likiss",
//            title: "베베더오리 미니 인형 키링(5type)",
//            lprice: "16000"
//        ),
//        Product(
//            image: "https://shopping-phinf.pstatic.net/main_8657721/86577211719.1.jpg",
//            mallName: "옥그라미 마켓",
//            title: "만세 오리인형 애착 대형 모찌 동물인형 선물 35cm",
//            lprice: "9180"
//        )
//    ]
//    
//    enum Section: CaseIterable {
//        case main
//    }
//    
//    let searchBar = UISearchBar()
//    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
//    var dataSource: UICollectionViewDiffableDataSource<Section, Product>!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureUI()
//        
//        configureDataSource()
//        updateSnapshot()
//    }
//    
//    deinit { print("Deinit LikeBox VC") }
//
//    private func configureDataSource() {
//        var registration =  UICollectionView.CellRegistration<UICollectionViewListCell, Product> { cell, indexPath, itemIdentifier in
//            var content = UIListContentConfiguration.accompaniedSidebarSubtitleCell()
//            content.text = "\(itemIdentifier.title)"
//            content.textProperties.color = .black
//            content.textProperties.font = .systemFont(ofSize: 15, weight: .bold)
//            
//            content.secondaryText = itemIdentifier.lprice + "원"
//            content.secondaryTextProperties.color = .systemGray
//            
//            content.image = UIImage(systemName: "cart.fill")
//            content.imageProperties.tintColor = .systemPurple
//            
//            cell.contentConfiguration = content
//            
//            var backgroundConfig = UIBackgroundConfiguration.listAccompaniedSidebarCell()
//            
//            backgroundConfig.backgroundColor = .white
//            
//            cell.backgroundConfiguration = backgroundConfig
//        }
//        
//        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
//            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
//            return cell
//        })
//    }
//    
//    private func updateSnapshot() {
//        var snapshot = NSDiffableDataSourceSnapshot<Section, Product>()
//        snapshot.appendSections(Section.allCases)
//        snapshot.appendItems(products, toSection: .main)
//        dataSource.apply(snapshot)
//    }
//    
//}
//
//extension LikeBoxViewController: UISearchBarDelegate {
//    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let text = searchBar.text else { return }
//        products.append(Product(image: "",
//                                mallName: "",
//                                title: text,
//                                lprice: "\(Int.random(in: 10000...999999))"))
//        updateSnapshot()
//        searchBar.text = ""
//    }
//    
//}
//
//extension LikeBoxViewController: UICollectionViewDelegate {
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        products.remove(at: indexPath.row)
//        print(dataSource.itemIdentifier(for: indexPath)!)
//        updateSnapshot()
//    }
//    
//}
//
//extension LikeBoxViewController {
//    
//    private func createLayout() -> UICollectionViewLayout {
//        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
////        configuration.showsSeparators = false
////        configuration.backgroundColor = .white
//        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
//
//        return layout
//    }
//    
//    private func configureUI() {
//        view.backgroundColor = .white
//        view.addSubview(searchBar)
//        view.addSubview(collectionView)
//        searchBar.snp.makeConstraints { make
//            in
//            make.top.equalTo(view.safeAreaLayoutGuide)
//            make.horizontalEdges.equalToSuperview()
//        }
//        collectionView.snp.makeConstraints { make
//            in
//            make.top.equalTo(searchBar.snp.bottom)
//            make.horizontalEdges.equalToSuperview()
//            make.bottom.equalToSuperview()
//        }
//        searchBar.placeholder = "위시리스트를 추가해 보세요"
//        searchBar.delegate = self
//        collectionView.delegate = self
//        collectionView.backgroundColor = .systemGray5
//    }
//    
//}
