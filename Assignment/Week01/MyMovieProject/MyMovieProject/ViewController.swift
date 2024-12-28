//
//  ViewController.swift
//  MyMovieProject
//
//  Created by 조다은 on 12/25/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var thumbImage1: UIImageView!
    @IBOutlet weak var thumbImage2: UIImageView!
    @IBOutlet weak var thumbImage3: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        thumbImage1.layer.cornerRadius = thumbImage1.frame.height / 2
        thumbImage2.layer.cornerRadius = thumbImage1.frame.height / 2
        thumbImage3.layer.cornerRadius = thumbImage1.frame.height / 2
        
        thumbImage1.layer.borderWidth = 2
        thumbImage2.layer.borderWidth = 2
        thumbImage3.layer.borderWidth = 2
        
        thumbImage1.layer.masksToBounds = true
        thumbImage2.layer.masksToBounds = true
        thumbImage3.layer.masksToBounds = true
        
        thumbImage1.layer.borderColor = UIColor.lightGray.cgColor
        thumbImage2.layer.borderColor = UIColor.lightGray.cgColor
        thumbImage3.layer.borderColor = UIColor.lightGray.cgColor
    }
}

