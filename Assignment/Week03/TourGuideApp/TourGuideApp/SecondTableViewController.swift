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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travels.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let travel = travels[indexPath.row]
        
        if let grade = travel.grade, let save = travel.save, let img = travel.travel_image {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath) as? SecondTableViewCell else { return SecondTableViewCell() }
            tableView.rowHeight = 160
            cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
            
            cell.gradeLabel.tag = indexPath.row
            cell.saveLabel.tag = indexPath.row
            cell.likeButton.tag = indexPath.row
            
            cell.titleLabel.text = travel.title
            cell.titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            cell.titleLabel.textColor = .darkGray
            
            cell.descLabel.text = travel.description
            cell.descLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
            cell.descLabel.textColor = .systemGray
            setStarsLabel(from: grade, to: cell.gradeLabel)
            setFormattedNumberLabel(from: save, to: cell.saveLabel)
            
            if let imgURL = URL(string: img) {
                cell.travelImageView.kf.setImage(with: imgURL)
                cell.travelImageView.contentMode = .scaleAspectFill
                cell.travelImageView.layer.cornerRadius = 8
            } else {
                cell.travelImageView.image = .no
            }
            cell.likeButton.setImage(UIImage(systemName: travel.like! ?  "heart" : "heart.fill")?.withTintColor(.white).withRenderingMode(.alwaysOriginal), for: .normal)
            cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SecondAdTableViewCell", for: indexPath) as? SecondAdTableViewCell else { return SecondTableViewCell() }
            tableView.rowHeight = 90
            cell.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width, bottom: 0, right: 0)

            let colors: [UIColor] = [.pointPink, .pointGreen]
            let color = colors.randomElement()
            cell.baseView.backgroundColor = color
            cell.baseView.layer.cornerRadius = 10
            
            cell.contentLabel.textAlignment = .center
            cell.contentLabel.numberOfLines = 0
            cell.contentLabel.text = travel.title
            cell.contentLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            
            cell.badgeLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            cell.badgeLabel.textAlignment = .center
            cell.badgeLabel.text = "AD"
            cell.badgeLabel.backgroundColor = .white
            cell.badgeLabel.layer.cornerRadius = 10
            cell.badgeLabel.layer.masksToBounds = true
            
            return cell
        }
            
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        travels[sender.tag].like?.toggle()
        tableView.reloadData()
    }
    
    func setStarsLabel(from doubleValue: Double, to label: UILabel) {
        let randomNum = String(Int.random(in: 1...2000))
        let starCount = Int(round(doubleValue))
        let yellowStars = NSAttributedString(string: String(repeating: "★", count: starCount), attributes: [.foregroundColor: UIColor.pointYellow])
        
        let remaingCount = max(5 - starCount, 0)
        let grayStarts = NSAttributedString(string: String(repeating: "★", count: remaingCount), attributes: [.foregroundColor: UIColor.systemGray6, .font: UIFont.systemFont(ofSize: 15)])
        
        let reviewCount = " (\(randomNum))"
        let reviewString = NSAttributedString(string: reviewCount, attributes: [.foregroundColor: UIColor.systemGray3, .font: UIFont.systemFont(ofSize: 15)])
        
        let combinedStars = NSMutableAttributedString()
        combinedStars.append(yellowStars)
        combinedStars.append(grayStarts)
        combinedStars.append(reviewString)
        
        label.attributedText = combinedStars
    }

    func setFormattedNumberLabel(from intValue: Int, to label: UILabel) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedSave = numberFormatter.string(for: intValue) ?? ""
        
        let saveString = NSAttributedString(string: "· 저장 \(formattedSave)", attributes: [.foregroundColor: UIColor.systemGray3, .font: UIFont.systemFont(ofSize: 15)])
        
        label.attributedText = saveString
    }
}
