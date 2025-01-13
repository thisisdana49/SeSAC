//
//  BookCollectionViewCell.swift
//  MyFourthProject
//
//  Created by 조다은 on 1/13/25.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    let bookCoverImageView = UIImageView()
    
    // XIB가 있을 때 -> awakeFromNib
    // 그 외 -> init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(bookCoverImageView)
        
        bookCoverImageView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        bookCoverImageView.backgroundColor = .brown
    }
    
    // 왜 써야하는지는 투비컨티뉴...
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview {
    BookCollectionViewCell()
}
