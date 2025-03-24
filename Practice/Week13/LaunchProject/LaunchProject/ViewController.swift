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
    
    var nickname = "오리"
    
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
//        Task {
//            print("===3===", Thread.isMainThread)
//            let one = try await ImageNetworkManager.shared.fetchAsyncAwait()
//            oneImageView.image = one
//            print("===4===", Thread.isMainThread)
//            print("*** 1 ***")
//
//        }
//        
//        Task {
//            let two = try await ImageNetworkManager.shared.fetchAsyncAwait()
//            twoImageView.image = two
//            print("*** 2 ***")
//        }
//        
//        Task {
//            let three = try await ImageNetworkManager.shared.fetchAsyncAwait()
//            threeImageView.image = three
//            print("*** 3 ***")
//        }
        
        // 4. 여러 비동기를 동시에 실행해줄 수 없을지?
//        Task {
//            let result = try await ImageNetworkManager.shared.fetchAsyncLet()
//            oneImageView.image = result[0]
//            twoImageView.image = result[1]
//            threeImageView.image = result[2]
//        }
//        
//        // 5. 여러 비동기를 동시에 실행해줄 수 없을지? 동적으로 달라지는 경우
//        // => TaskGroup
//        Task {
//            let result = try await ImageNetworkManager.shared.fetchTaskGroup()
//            
//            oneImageView.image = result[0]
//            twoImageView.image = result[1]
//            threeImageView.image = result[2]
//        }
        
        
        DispatchQueue.global().async {
            self.nickname = "너구리"
        }

        DispatchQueue.global().async {
            self.nickname = "오리너구리"
        }
        
        DispatchQueue.global().async {
            self.nickname = "흑오리"
        }
        
        print(nickname)
    }


}

