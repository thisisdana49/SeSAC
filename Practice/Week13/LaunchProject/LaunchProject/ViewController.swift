//
//  ViewController.swift
//  LaunchProject
//
//  Created by 조다은 on 3/19/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var oneImageView: UIImageView!
    @IBOutlet var twoImageView: UIImageView!
    @IBOutlet var threeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Data
//        ImageNetworkManager.shared.fetchThumbnail { image in
//            self.oneImageView.image = image
//        }
        
        // 2. URLSession + GCD
//        ImageNetworkManager.shared.fetchThumbnailURLSession { response in
//            DispatchQueue.main.async {
//                switch response {
//                case .success(let success):
//                    self.oneImageView.image = success
//                case .failure(let failure):
//                    self.oneImageView.image = UIImage(systemName: "star")
//                }
//            }
//        }
        
        // 3. URLSession + Swift Concurrency (async await)
        // Task == DispatchQueue.global.async
        // Q. 메인의 async는 어디에? => 알아서 돌아옴...
        // @MainActor: Swift Concurrency를 작성한 코드에서 다시 메인 쓰레드로 돌려주는 역할을 수행
        Task {
            print("===3===", Thread.isMainThread)
            let result = try await ImageNetworkManager.shared.fetchAsyncAwait()
            oneImageView.image = result
            print("===4===", Thread.isMainThread)
        }
    }


}

