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
}
