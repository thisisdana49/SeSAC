//
//  PosterViewController.swift
//  MyFifthProject
//
//  Created by 조다은 on 1/24/25.
//

import UIKit
import Kingfisher

class PosterViewController: UIViewController {

    lazy private var tableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.rowHeight = 200
        view.register(PosterTableViewCell.self, forCellReuseIdentifier: PosterTableViewCell.id)
        return view
    }()
    
    var list = ["Test1", "Test2", "Test3"]
    var detailList: [[RandomPhoto]] = [
        [], [], []
    ]
//    var detailList1 = ["star.fill", "pencil", "xmark", "heart"]
//    var detailList2 = ["star", "pencil", "xmark", "heart"]
//    var detailList3 = ["house", "pencil", "xmark", "heart"]
//    var detailList = [
//        ["star.fill", "pencil", "xmark", "heart"],
//        ["star", "pencil", "xmark", "heart"],
//        ["house", "pencil", "xmark", "heart"]
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        let group = DispatchGroup()
        
        group.enter()
        PhotoManager.shared.getRandomPhoto(api: .randomPhoto) { photo in
            self.detailList[0] = photo
            group.leave()
        } failHandler: {
            print("실패했어유")
        }
        
        group.enter()
        PhotoManager.shared.getRandomPhoto(api: .randomPhoto) { photo in
            self.detailList[1] = photo
            group.leave()
        } failHandler: {
            print("실패했어유")
        }
        
        group.enter()
        PhotoManager.shared.getRandomPhoto(api: .randomPhoto) { photo in
            self.detailList[2] = photo
            group.leave()
        } failHandler: {
            print("실패했어유")
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
            
        }
    }

}

extension PosterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PosterTableViewCell.id, for: indexPath) as! PosterTableViewCell
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(PosterCollectionViewCell.self, forCellWithReuseIdentifier: PosterCollectionViewCell.id)
        
        cell.collectionView.tag = indexPath.row
        cell.titleLabel.text = list[indexPath.row]
        cell.collectionView.backgroundColor = .systemPink
        cell.collectionView.reloadData()
        
        return cell
    }
    
}


extension PosterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView.tag == 0 {
//            return detailList1.count
//        } else if collectionView.tag == 1 {
//            return detailList2.count
//        } else {
//            return detailList3.count
//        }
        return detailList[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.id, for: indexPath) as! PosterCollectionViewCell
        
//        if collectionView.tag == 0 {
//            let data = detailList1[indexPath.row]
//            cell.posterImageView.image = UIImage(systemName: data)
//        } else if collectionView.tag == 1 {
//            let data = detailList2[indexPath.row]
//            cell.posterImageView.image = UIImage(systemName: data)
//        } else {
//            let data = detailList3[indexPath.row]
//            cell.posterImageView.image = UIImage(systemName: data)
//        }
        let data = detailList[collectionView.tag][indexPath.item]
        let link = URL(string: data.urls.thumb)
        cell.posterImageView.kf.setImage(with: link)
        
        return cell
    }
    
}
