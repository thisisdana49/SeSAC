//
//  PhotoCollectionViewCell.swift
//  WeatherMap
//
//  Created by 조다은 on 2/4/25.
//

import UIKit
import SnapKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static var id: String {
        String(describing: self)
    }
    
    var imageView = UIImageView()
    
    override init(frame: CGRect) {
        print(#function)
        super.init(frame: frame)
        
        addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
