//
//  BookView.swift
//  MyFourthProject
//
//  Created by 조다은 on 1/16/25.
//

import UIKit

class BookView: BaseView {
    lazy var collectionView = createCollectionView()
    
    func createCollectionView() -> UICollectionView {
        lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: "BookCollectionViewCell")

        return collectionView
    }
    
    override func configureHierarchy() {
        addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        backgroundColor = .white
    }
    
    func createCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 50)
        layout.scrollDirection = .vertical
        return layout
    }
}

// MARK: CollectionView Delegate
extension BookView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookCollectionViewCell", for: indexPath) as! BookCollectionViewCell
        cell.bookCoverImageView.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        let vc = KakaoBookSearchViewController()
//        present()
//        화면을 전환하는 메서드는 ViewController가 가지고 있는 속성이기 때문에, 다시 VC로 보내줘야함
//        그래서 VC의 역할(사용자와의 인터랙션 등)을 과도하게 View에게 넘겨주면 안 됨.
    }
}
