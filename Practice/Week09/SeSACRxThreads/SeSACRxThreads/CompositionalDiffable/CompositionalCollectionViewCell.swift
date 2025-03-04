//
//  CompositionalCollectionViewCell.swift
//  SeSACRxThreads
//
//  Created by 조다은 on 2/27/25.
//

import UIKit

final class CompositionalCollectionViewCell: UICollectionViewCell {
    let label = {
        let view = UILabel()
        view.backgroundColor = .yellow
        view.textColor = .brown
        view.font = .systemFont(ofSize: 20, weight: .bold)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        contentView.addSubview(label)
        label.snp.makeConstraints{
            $0.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
