//
//  SecondTableViewController.swift
//  TourGuideApp
//
//  Created by 조다은 on 1/3/25.
//

import UIKit
import Kingfisher

class SecondTableViewController: UITableViewController {
    var travels = TravelInfo().travel
    var reviewNumArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 1...travels.count {
            let randomNum = String(Int.random(in: 1...1000))
            reviewNumArray.append(randomNum)
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let travel = travels[indexPath.row]
        
        if !travel.ad {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondTableViewCell.identifier, for: indexPath) as? SecondTableViewCell else { return SecondTableViewCell() }
            let nextRow = min(indexPath.row + 1, travels.count - 1)
            if travels[nextRow].ad {
                cell.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
            } else {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            }

            cell.configureData(row: travel, index: indexPath.row, reviewNum: reviewNumArray[indexPath.row])
            cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondAdTableViewCell.identifier, for: indexPath) as? SecondAdTableViewCell else { return SecondAdTableViewCell() }
            cell.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)
            cell.configureData(row: travel)
            
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let travel = travels[indexPath.row]
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        if !travel.ad {
            let vc = sb.instantiateViewController(withIdentifier: "SecondDetailViewController") as! SecondDetailViewController
            vc.travel = travel
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = sb.instantiateViewController(withIdentifier: "SecondAdDetailViewController") as! SecondAdDetailViewController
            vc.adTitle = travel.title
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            
            present(nav, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        travels[sender.tag].like?.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
}
