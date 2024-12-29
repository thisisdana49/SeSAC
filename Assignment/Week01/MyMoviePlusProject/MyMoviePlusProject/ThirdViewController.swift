//
//  FirstTabViewController.swift
//  MyMoviePlusProject
//
//  Created by 조다은 on 12/25/24.
//

import UIKit

class ThirdViewController: UIViewController {
    

    @IBOutlet weak var thumbImage1: UIImageView!
    @IBOutlet weak var thumbImage2: UIImageView!
    @IBOutlet weak var thumbImage3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        thumbImage1.transform = thumbImage1.transform.rotated(by: -30 * CGFloat.pi / 180)
        thumbImage2.transform = thumbImage2.transform.rotated(by: 30 * CGFloat.pi / 180)
        thumbImage3.transform = thumbImage3.transform.rotated(by: .pi * 2)
        
        thumbImage1.layer.cornerRadius = 5
        thumbImage2.layer.cornerRadius = 5
        thumbImage3.layer.cornerRadius = 5
        
        thumbImage1.layer.masksToBounds = true
        thumbImage2.layer.masksToBounds = true
        thumbImage3.layer.masksToBounds = true
    }
    
    
}
