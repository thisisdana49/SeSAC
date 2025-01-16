//
//  BookViewController.swift
//  MyFourthProject
//
//  Created by 조다은 on 1/13/25.
//

import UIKit
import SnapKit


class BookViewController: UIViewController {
    
    var mainView = BookView()
    
    // super XXX -> 기존 Apple이 만들어놓은 걸 다시 호출하는 일이 되기 때문에
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
}

// MARK: CollectionView Delegate
extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BookCollectionViewCell
        cell.bookCoverImageView.layer.cornerRadius = 10
        return cell
    }
}

//#Preview {
//    BookViewController()
//}
//
