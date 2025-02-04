//
//  ExampleViewController.swift
//  MySeventhProject
//
//  Created by 조다은 on 2/4/25.
//

import UIKit
import SnapKit

class User<T> {

    var myFunction: (() -> Void)?
    
    var value: T {
        didSet {
            myFunction?()
        }
    }

    init(_ value: T) {
        self.value = value
    }
}

class ExampleViewController: UIViewController {

    let dana = User(12)

    var nickname = "조우니" {
        didSet {
            print("닉네임 \(nickname)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dana.myFunction = {
            print("nickname: \(self.nickname)")
            print("Any Function...")
        }
        
        dana.value = 1
        dana.value = 121
        dana.value = 222

        print("닉네임 \(nickname)")
        
        nickname = "우니"
        nickname = "우"
        
        configureView()
        test()
        print("===")
        test2()
    }

    func test2() {
        var num = Observable(3)

        num.bind { value in
            print(value)
        }

        num.value = 2
        num.value = 100
    }

    func test() {
        var num = 3

        print(num)

        num = 6
        num = 4
    }
    
    func configureView() {
        view.backgroundColor = .white
    }

}
