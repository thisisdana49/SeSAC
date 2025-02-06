//
//  EmptyViewController.swift
//  MySeventhProject
//
//  Created by 조다은 on 2/6/25.
//

import UIKit

class EmptyViewModel {
    init() {
        print("EmptyViewModel Init")
    }
    
    deinit {
        print("EmptyViewModel Deinit")
    }
}

class EmptyViewController: UIViewController {

    let viewModel = EmptyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print(#function)
    }
        
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }

    deinit {
        print("EmptyViewController Deinit")
    }
    
}
