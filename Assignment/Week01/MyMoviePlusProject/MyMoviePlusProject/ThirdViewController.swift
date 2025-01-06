//
//  FirstTabViewController.swift
//  MyMoviePlusProject
//
//  Created by 조다은 on 12/25/24.
//

import UIKit

class ThirdViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentlabel: UILabel!
    @IBOutlet var thumbnailImageArray: [UIImageView]!
    @IBOutlet var badgeViewArray: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    fileprivate func setUI() {
        setLabelUI()
        setThumbnailImageView()
    }
    
    private func setLabelUI() {
        titleLabel.text = "'나만의 자동 저장' 기능"
        contentlabel.text = "취향에 맞는 영화와 시리즈를 자동으로 저장해 드립니다.\n디바이스에 언제나 시청할 콘텐츠가 준비되니 지루할 틈이 없어요."
    }
    
    fileprivate func setThumbnailImageView() {
        for index in 0...2 {
            thumbnailImageArray[index].image = UIImage(named: "poster\(index + 1)")
            thumbnailImageArray[index].layer.cornerRadius = 5
            thumbnailImageArray[index].layer.masksToBounds = true
            let badge1 = UIImageView(image: UIImage(named: "badge1"))
            let badge2 = UIImageView(image: UIImage(named: "badge2"))
            let badge3 = UIImageView(image: UIImage(named: "badge3"))
            
            badge2.frame.size.height = 5
            badge3.frame.size.height = 5
            
            badgeViewArray[index].addSubview(badge1)
            badgeViewArray[index].addSubview(badge2)
            badgeViewArray[index].addSubview(badge3)
            
            badge1.translatesAutoresizingMaskIntoConstraints = false
            badge2.translatesAutoresizingMaskIntoConstraints = false
            badge3.translatesAutoresizingMaskIntoConstraints = false
            
            badge1.topAnchor.constraint(equalTo: badgeViewArray[index].topAnchor).isActive = true
            badge1.trailingAnchor.constraint(equalTo: badgeViewArray[index].trailingAnchor).isActive = true
            
            badge2.bottomAnchor.constraint(equalTo: badgeViewArray[index].bottomAnchor).isActive = true
            badge2.centerXAnchor.constraint(equalTo: badgeViewArray[index].centerXAnchor).isActive = true
            
            badge3.bottomAnchor.constraint(equalTo: badgeViewArray[index].bottomAnchor).isActive = true
            badge3.centerXAnchor.constraint(equalTo: badgeViewArray[index].centerXAnchor).isActive = true
            
            badgeViewArray[index].subviews.forEach { $0.isHidden = true }
        }
        thumbnailImageArray[0].transform = thumbnailImageArray[0].transform.rotated(by: -30 * CGFloat.pi / 180)
        thumbnailImageArray[1].transform = thumbnailImageArray[1].transform.rotated(by: 30 * CGFloat.pi / 180)
        thumbnailImageArray[2].transform = thumbnailImageArray[2].transform.rotated(by: .pi * 2)
        
        badgeViewArray[0].transform = badgeViewArray[0].transform.rotated(by: -30 * CGFloat.pi / 180)
        badgeViewArray[1].transform = badgeViewArray[1].transform.rotated(by: 30 * CGFloat.pi / 180)
        badgeViewArray[2].transform = badgeViewArray[2].transform.rotated(by: .pi * 2)
        
        for index in 0...2 {
            let randomInt = Int.random(in: 1...4)
            
            
            
            switch randomInt {
            case 1:
                badgeViewArray[index].subviews[0].isHidden = false
                badgeViewArray[index].subviews[1].isHidden = true
                badgeViewArray[index].subviews[2].isHidden = true
            case 2:
                badgeViewArray[index].subviews[0].isHidden = true
                badgeViewArray[index].subviews[1].isHidden = false
                badgeViewArray[index].subviews[2].isHidden = true
            case 3:
                badgeViewArray[index].subviews[0].isHidden = true
                badgeViewArray[index].subviews[1].isHidden = true
                badgeViewArray[index].subviews[2].isHidden = false
            case 4:
                badgeViewArray[index].subviews[0].isHidden = true
                badgeViewArray[index].subviews[1].isHidden = true
                badgeViewArray[index].subviews[2].isHidden = true
            default:
                print("default")
            }
        }
    }
}
