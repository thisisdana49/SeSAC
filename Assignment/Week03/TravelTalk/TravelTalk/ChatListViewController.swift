//
//  ViewController.swift
//  TravelTalk
//
//  Created by 조다은 on 1/11/25.
//

import UIKit

class ChatListViewController: UIViewController {
    let chatLists: [ChatRoom] = mockChatList
    var filteredChatLists: [ChatRoom] = []
    var isSearching: Bool = false
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        configureListCollectionViewLayout()
        setUI()
        
        searchBar.delegate = self
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
        layout.itemSize = CGSizeMake(cellWidth, 80)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.collectionViewLayout = layout
    }
    
    private func setUI() {
        navigationItem.title = "TRAVEL TALK"
        navigationController?.navigationItem.backButtonTitle = "뒤로"
        
        searchBar.placeholder = "친구 이름을 검색해 보세요"
    }
}

// MARK: CollectionView Delegate, DataSource
extension ChatListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearching ? filteredChatLists.count : chatLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatListCollectionViewCell.identifier, for: indexPath) as? ChatListCollectionViewCell else { return UICollectionViewCell() }
        let item = isSearching ? filteredChatLists[indexPath.item] : chatLists[indexPath.item]
        let dateFromString = Date.fromString(item.chatList.last?.date ?? "", format: "yyyy-MM-dd HH:mm")
        let dateString = dateFromString?.toFormattedString("yyyy.MM.dd") ?? ""
        
        cell.configureData(
            image: item.chatroomImage.first ?? "",
            name: item.chatroomName,
            date: dateString,
            message: item.chatList.last?.message ?? ""
        )
        
        DispatchQueue.main.async {
            cell.roomImageView.layer.cornerRadius = cell.roomImageView.frame.height / 2
            cell.roomImageView.layer.borderColor = UIColor.systemGray5.cgColor
            cell.roomImageView.layer.borderWidth = 1
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = chatLists[indexPath.item]
        let sb = UIStoryboard(name: "Chat", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: ChatDetailViewController.identifier) as? ChatDetailViewController else { return }
        
        vc.chatRoom = item
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: SearchBar Delegate
extension ChatListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            print("is empty")
            isSearching = false
            filteredChatLists.removeAll()
            
        } else {
            print("is not empty")
            isSearching = true
            filteredChatLists = chatLists.filter {
                $0.chatroomName.contains(searchText)
                || $0.chatroomImage.contains(searchText)
            }
        }
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearching = false
        filteredChatLists.removeAll()
        collectionView.reloadData()
        searchBar.resignFirstResponder()
    }
}
