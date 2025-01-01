//
//  PracticeViewController.swift
//  MySecondApp
//
//  Created by 조다은 on 12/31/24.
//

import UIKit

class PracticeViewController: UIViewController {
    
    let colorList: [UIColor] = [.red, .green, .blue, .yellow]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self, #function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(self, #function)
    }
    
    // iOS 13.0+
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        print(self, #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view.backgroundColor = colorList.randomElement()
        super.viewDidAppear(animated)
        print(self, #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(self, #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(self, #function)
    }
    
    // 스토리 보드에서 연결하는 게 X, 코드로 직접 타이핑
    @IBAction func unwindToPracticeViewController(_ sender: UIStoryboardSegue) {
        print(#function)
    }
}
