//
//  SearchResultView.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 1/16/25.
//

import UIKit
import SnapKit

class SearchResultView: BaseView {
    
    let standardLists = ["정확도", "날짜순", "가격높은순", "가격낮은순"]
    // TODO: 차이점 공부
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
    let totalLabel = UILabel()
    let stackView = UIStackView()
    var sortButtons: [UIButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(totalLabel)
        addSubview(collectionView)
        addSubview(stackView)
        
        for i in 0..<standardLists.count {
            let button = CustomButton(title: standardLists[i], tag: i)
            stackView.addArrangedSubview(button)
            sortButtons.append(button)
        }
    }
    
    override func configureLayout() {
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(16)
            make.height.equalTo(30)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom)
            make.leading.equalToSuperview().offset(12)
//            make.width.equalToSuperview()
            make.height.equalTo(36)
        }
        
        for (_, button) in stackView.subviews.enumerated() {
            button.snp.makeConstraints { make in
                make.verticalEdges.equalToSuperview()
            }
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        backgroundColor = .black
        collectionView.backgroundColor = .black
        
        totalLabel.textColor = .systemGreen
        totalLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
        stackView.backgroundColor = .black
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 4
        stackView.alignment = .center
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
