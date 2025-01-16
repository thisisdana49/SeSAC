//
//  BookViewController.swift
//  MyFourthProject
//
//  Created by 조다은 on 1/13/25.
//

import UIKit
import SnapKit


class BookViewController: UIViewController {
    
    var mainView = BookView()
    
    // super XXX -> 기존 Apple이 만들어놓은 걸 다시 호출하는 일이 되기 때문에
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UserDefaultsManager.shared.age = 50
        print(UserDefaultsManager.shared.age)
        
        NetworkManager.shared.randomUser { name in
            self.navigationItem.title = name
        }
    }
}



//#Preview {
//    BookViewController()
//}
//
