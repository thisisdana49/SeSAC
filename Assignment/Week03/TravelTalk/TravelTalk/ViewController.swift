//
//  ViewController.swift
//  TravelTalk
//
//  Created by 조다은 on 1/11/25.
//

import UIKit

class ViewController: UIViewController {
    let chatLists: [ChatRoom] = mockChatList
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureListCollectionViewLayout()
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let id = ChatListCollectionViewCell.identifier
        let xib = UINib(nibName: id, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: id)
    }
    
    private func configureListCollectionViewLayout() {
        let sectionInset: CGFloat = 16
        
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = (deviceWidth - (sectionInset * 2))
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSizeMake(cellWidth, 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = layout
    }
}

// MARK: CollectionView Delegate, DataSource
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatListCollectionViewCell.identifier, for: indexPath) as? ChatListCollectionViewCell else { return UICollectionViewCell() }
        let item = chatLists[indexPath.item]
        
        cell.configureData(
            image: item.chatroomImage.first ?? "", name: item.chatroomName, date: item.chatList.last?.date ?? "", message: item.chatList.last?.message ?? "")
        
        return cell
    }
    
    
}
