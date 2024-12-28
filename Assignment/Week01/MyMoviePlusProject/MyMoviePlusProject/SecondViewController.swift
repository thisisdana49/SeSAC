//
//  FirstTabViewController.swift
//  MyMoviePlusProject
//
//  Created by 조다은 on 12/25/24.
//

import UIKit

class SecondViewController
: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func firstButtonHandler(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        if sender.isSelected {
            sender.backgroundColor = .white
            sender.setTitleColor(.black, for: .normal)
        } else {
            sender.backgroundColor = .black
            sender.setTitleColor(.white, for: .normal)
        }
    }
    
    @IBAction func secondButtonHandler(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        if sender.isSelected {
            sender.backgroundColor = .white
            sender.setTitleColor(.black, for: .normal)
        } else {
            sender.backgroundColor = .black
            sender.setTitleColor(.white, for: .normal)
        }
    }
    
    @IBAction func thirdButtonHandler(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        if sender.isSelected {
            sender.backgroundColor = .white
            sender.setTitleColor(.black, for: .normal)
        } else {
            sender.backgroundColor = .black
            sender.setTitleColor(.white, for: .normal)
        }
    }
}
