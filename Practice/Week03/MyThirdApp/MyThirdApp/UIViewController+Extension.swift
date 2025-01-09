//
//  UIViewController+Extension.swift
//  MyThirdApp
//
//  Created by 조다은 on 1/9/25.
//

import UIKit

extension UIViewController {
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: 200, height: 200)
        
//        layout.itemSize = CGSize(width: view.window?.windowScene?.screen.bounds.width, height: 50)
//        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 120)
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
     
        return layout
    }
    

}
