//
//  SearchResultViewController.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/15/25.
//

import UIKit
import Alamofire
import SnapKit

class SearchResultViewController: UIViewController, ViewConfiguration {
    let standardLists = ["정확도", "날짜순", "가격높은순", "가격낮은순"]
    let sortStandards = ["sim", "date", "dsc", "asc"]
    var searchWord: String = ""
    var sortStandard: String = "sim"
    var item: Item?
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    let totalLabel = UILabel()
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest()

        configureCollectionView()
        configureHierarchy()
        configureLayout()
        configureView()
        self.collectionView.reloadData()
    }

    func callRequest() {
        let url = "https://openapi.naver.com/v1/search/shop.json?query=\(searchWord)&sort=\(sortStandard)"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": naverClientID,
            "X-Naver-Client-Secret": naverClientSecret
        ]
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Item.self) { response in
            switch response.result {
            case .success(let value):
                self.item = value
                self.collectionView.reloadData()
                if let total = self.item?.total {
                    self.totalLabel.text = "\(total.formatted(.number))개의 검색 결과"
                }

//                dump(self.itemDetails.first!)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc
    func sortButtonTapped(_ button: UIButton) {
        print(#function)
        button.isSelected = true
        sortStandard = sortStandards[button.tag]
        print(#function, sortStandard, button.isSelected)
        if button.isSelected {
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
            for (_, e) in stackView.subviews.enumerated() {
                let index = e as! UIButton
                if index != button {
                    index.isSelected = false
                    index.backgroundColor = .black
                    index.setTitleColor(.white, for: .normal)
                }
            }
        } else {
            button.backgroundColor = .black
            button.setTitleColor(.white, for: .normal)
        }

        callRequest()
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: ItemCollectionViewCell.id)
        collectionView.backgroundColor = .black
    }
    
    func configureHierarchy() {
        view.addSubview(totalLabel)
        view.addSubview(collectionView)
        view.addSubview(stackView)
        
        for i in standardLists {
            let button = UIButton()
            button.setTitle(i, for: .normal)
            stackView.addArrangedSubview(button)
        }
    }
    
    func configureLayout() {
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview()
            make.height.equalTo(30)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom)
            make.leading.equalToSuperview()
//            make.width.equalToSuperview()
            make.height.equalTo(52)
        }
        
        for (index, button) in stackView.subviews.enumerated() {
            button.snp.makeConstraints { make in
                make.verticalEdges.equalToSuperview().inset(8)
            }
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func configureView() {
        view.backgroundColor = .black
        self.navigationItem.title = searchWord
        self.navigationController?.navigationBar.topItem?.title = ""
        
        totalLabel.textColor = .systemGreen
        totalLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        stackView.backgroundColor = .black
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        stackView.alignment = .leading
        
        // TODO: CustomButton으로 구현
        for (index, view) in stackView.subviews.enumerated() {
            guard let button = view as? UIButton else { return }
            button.setTitleColor(button.isSelected ? .black : .white, for: .normal)
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 5
            button.tag = index
            button.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        }
    }
    
    func createCollectionViewLayout() -> UICollectionViewFlowLayout {
        let sectionInset: CGFloat = 16
        let cellSpacing: CGFloat = 16
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = (deviceWidth - (sectionInset * 2) - cellSpacing)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSizeMake(cellWidth / 2, cellWidth / 2 * 1.6)
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionInset, bottom: 0, right: sectionInset)
        
        return layout
    }
    
}

// MARK: UICollectionView Delegate, DataSource
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return item?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionViewCell.id, for: indexPath) as? ItemCollectionViewCell, let item = item?.items[indexPath.item] else { return UICollectionViewCell() }
        
        cell.configureData(item: item)
        
        return cell
    }
    
}
