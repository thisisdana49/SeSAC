//
//  FirstTabViewController.swift
//  MyMoviePlusProject
//
//  Created by 조다은 on 12/25/24.
//

import UIKit

class FirstTabViewController: UIViewController {
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var thumbImage1: UIImageView!
    @IBOutlet weak var thumbImage2: UIImageView!
    @IBOutlet weak var thumbImage3: UIImageView!
    

    @IBOutlet var badgeViewArray: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        switchRandomPoster()
        
        mainImage.layer.cornerRadius = 10
        thumbImage1.layer.cornerRadius = 5
        thumbImage2.layer.cornerRadius = 5
        thumbImage3.layer.cornerRadius = 5
        
        mainImage.layer.masksToBounds = true
        thumbImage1.layer.masksToBounds = true
        thumbImage2.layer.masksToBounds = true
        thumbImage3.layer.masksToBounds = true
        
        for index in 0...2 {
            badgeViewArray[index].addSubview(UIImageView(image: UIImage(named: "badge1")))
            badgeViewArray[index].addSubview(UIImageView(image: UIImage(named: "blue")))
            badgeViewArray[index].addSubview(UIImageView(image: UIImage(named: "pink")))
            
            badgeViewArray[index].subviews.forEach { $0.isHidden = true }
        }
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        switchRandomPoster()
        switchRandomMark()
    }

    func switchRandomPoster() {
        var posterArray: [String] = []
        
        for _ in 0...3 {
            let randomInt = Int.random(in: 1...34)
            let posterName = "poster\(randomInt)"
            posterArray.append(posterName)
        }
        
        mainImage.image = UIImage(named: posterArray[0])
        thumbImage1.image = UIImage(named: posterArray[1])
        thumbImage2.image = UIImage(named: posterArray[2])
        thumbImage3.image = UIImage(named: posterArray[3])
    }
    
    func switchRandomMark() {
        
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
