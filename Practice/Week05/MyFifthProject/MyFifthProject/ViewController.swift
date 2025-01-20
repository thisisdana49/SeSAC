//
//  ViewController.swift
//  MyFifthProject
//
//  Created by 조다은 on 1/20/25.
//

import UIKit
import SnapKit

/*
 1. GCD vs Swift Concurrency
    - GCD: sync/async/serial/concurrent -> dispatchgroup
 2. url ? AF.request ? -> router pattern
 */
class ViewController: UIViewController {
    
    let firstImageView = {
        let view = UIImageView()
        view.backgroundColor = .green
        
        return view
    }()
    
    let checkButton = {
        let view = UIButton()
        view.backgroundColor = .green
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
//        serialSync()
//        serialAsync()
//        concurrentSync()
        concurrentAsync()
    }
    
    // 생명주기랑 함꼐 보는 것도 좋은 방법!!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        DispatchQueue.main.async {
            print(#function)
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print(#function)
    }
    
    // 직렬 + 동기
    // 사실상 닭 혼자서 모든 일을 하는 것과 동일함.
    // 그래서 명시적으로 적어주었을 때!
    func serialSync() {
        print("START", terminator: " ")
        
        for i in 1...100 {
            print(i, terminator: " ")
        }
        
        // 무한 대기 상태인 교착 상태(DeadLock)가 됨
        DispatchQueue.main.sync {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        print("END", terminator: " ")
    }
    
    func serialAsync() {
        print("START", terminator: " ")
        
        DispatchQueue.main.async {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END", terminator: " ")
    }
    
    // 실질적으로 닭 혼자서 모든 일을 하는 것과 동일함.
    // 내부적으로는 닭이 처리하게 될 수도 있음.
    // 하지만 적절하게 분배하라고 했기 때문에 오류는 발생 X
    func concurrentSync() {
        print("START", terminator: " ")
        
        DispatchQueue.global().sync {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END", terminator: " ")
    }
    
    func concurrentAsync() {
        print("START", terminator: " ")
        
//        DispatchQueue.global().async {
//            for i in 1...100 {
//                print(i, terminator: " ")
//            }
//        }
            
        for i in 1...100 {
            DispatchQueue.global().async {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END", terminator: " ")
    }

    func configureView() {
        view.addSubview(firstImageView)
        view.addSubview(checkButton)
        
        checkButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        
        firstImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
        }
        
    }
    
    @objc
    func checkButtonTapped() {
        print(#function)
        let url = URL(string: "https://apod.nasa.gov/apod/image/2308/sombrero_spitzer_3000.jpg")!
//        let url = URL(string: "https://picsum.photos/200/300")!
        
        DispatchQueue.global().async {
            // Data(contentsOf: url)은 동기 처리 작업
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.firstImageView.image = image
                    }
                }
            }
        }
        
    }
}

