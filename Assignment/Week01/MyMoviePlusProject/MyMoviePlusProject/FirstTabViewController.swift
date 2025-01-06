//
//  FirstTabViewController.swift
//  MyMoviePlusProject
//
//  Created by 조다은 on 12/25/24.
//

import UIKit

class FirstTabViewController: UIViewController {
    
    @IBOutlet var mainLayerImage: UIImageView!
    @IBOutlet var thumbnailImageArray: [UIImageView]!
    @IBOutlet var badgeViewArray: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        switchRandomPoster()
        switchRandomBadge()
    }

    func switchRandomPoster() {
        var posterArray: [String] = []
        
        for _ in 0...3 {
            let randomInt = Int.random(in: 1...34)
            let posterName = "poster\(randomInt)"
            posterArray.append(posterName)
        }
        
        for index in 0...3 {
            thumbnailImageArray[index].image = UIImage(named: posterArray[index])
        }
    }
    
    public func switchRandomBadge() {
        for index in 0...2 {
            let randomInt = Int.random(in: 1...4)
            
            switch randomInt {
            case 1:
                badgeViewArray[index].subviews.forEach() {
                    $0.isHidden.toggle()
                }
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
    
    fileprivate func setMainImageUI() {
        thumbnailImageArray[0].layer.cornerRadius = 10
        thumbnailImageArray[0].layer.masksToBounds = true
        
        mainLayerImage.image = .background
        mainLayerImage.layer.cornerRadius = 10
    }
    
    fileprivate func setThumbnailImageUI() {
        for index in 1...3 {
            thumbnailImageArray[index].layer.cornerRadius = 5
            thumbnailImageArray[index].layer.masksToBounds = true
        }
    }
    
    fileprivate func setUI() {
        setMainImageUI()
        setThumbnailImageUI()
        
        for index in 0...2 {
            let badge1 = UIImageView(image: UIImage(named: "badge1"))
            let badge2 = UIImageView(image: UIImage(named: "badge2"))
            let badge3 = UIImageView(image: UIImage(named: "badge3"))
            
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
        
        switchRandomPoster()
        switchRandomBadge()
    }
}
