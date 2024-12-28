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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mainImage.layer.cornerRadius = 10
        thumbImage1.layer.cornerRadius = 5
        thumbImage2.layer.cornerRadius = 5
        thumbImage3.layer.cornerRadius = 5
        
        mainImage.layer.masksToBounds = true
        thumbImage1.layer.masksToBounds = true
        thumbImage2.layer.masksToBounds = true
        thumbImage3.layer.masksToBounds = true
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        switchRandomPoster()
//        switchRandomMark()
    }
    
    func getRandomFourPoster() -> [String] {
        var posterArray: [String] = []
        
        for _ in 0...3 {
            let randomInt = Int.random(in: 1...34)
            let posterName = "poster\(randomInt)"
            posterArray.append(posterName)
        }
        
        return posterArray
    }
    
    func switchRandomPoster() {
        let posterArray = getRandomFourPoster()
        mainImage.image = UIImage(named: posterArray[0])
        thumbImage1.image = UIImage(named: posterArray[1])
        thumbImage2.image = UIImage(named: posterArray[2])
        thumbImage3.image = UIImage(named: posterArray[3])
    }
    
    func switchRandomMark() {
        print("switch random mark")
    }
}
