//
//  TenCollectioinViewController.swift
//  MySecondApp
//
//  Created by 조다은 on 1/7/25.
//

import UIKit

/*
 1. 이름
 2. 부하직원 호출
 3. 필수 기능
 4. 부하직원 연결
 */

class TenCollectioinViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        
        let xib = UINib(nibName: "TenCollectionViewCell", bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: "TenCollectionViewCell")
//        collectionView.register(<#T##viewClass: AnyClass?##AnyClass?#>, forSupplementaryViewOfKind: <#T##String#>, withReuseIdentifier: <#T##String#>) 헤더와 푸터
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
        collectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TenCollectionViewCell", for: indexPath) as! TenCollectionViewCell

        return cell
    }
}
