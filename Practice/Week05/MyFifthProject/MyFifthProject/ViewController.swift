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
    
    let secondImageView = {
        let view = UIImageView()
        view.backgroundColor = .red
        
        return view
    }()
    
    let thirdImageView = {
        let view = UIImageView()
        view.backgroundColor = .blue
        
        return view
    }()
    
    let checkButton = {
        let view = UIButton()
        view.backgroundColor = .green
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        //        serialSync()
        //        serialAsync()
        //        concurrentSync()
        //        concurrentAsync()
//        example()
        example2()
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

    // Dispatch Group
    func example2() { // 모두 끝났을 때 얼럿을 주고 싶은 경우
        print("START")
        
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        print("ONE")
        
        DispatchQueue.global().async(group: group) {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        print("TWO")
        
        DispatchQueue.global().async(group: group) {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        print("END")
        
        group.notify(queue: .main) { // 신호를 받아야할 때가 대부분 main에서 필요한 때라서?
            print("알바생 3명 끝! 신호 받음!")
        }
    }

    
    func example() {
        print("START")
        
        DispatchQueue.global(qos: .userInteractive).async {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        print("ONE")
        
        DispatchQueue.global(qos: .background).async {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        print("TWO")
        
        DispatchQueue.global().async {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        print("END")
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
        DispatchQueue.global().async {
            
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        print("END", terminator: " ")
    }
    
    func configureView() {
        view.addSubview(firstImageView)
        view.addSubview(secondImageView)
        view.addSubview(thirdImageView)
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
        
        secondImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(firstImageView.snp.bottom).offset(20)
        }
        
        thirdImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(secondImageView.snp.bottom).offset(20)
        }
    }
    
    @objc
    func checkButtonTapped() {
        
        let group = DispatchGroup()
        
        group.enter()
            NetworkManager.shared.fetchImage { image in
                print("first image view succeed")
                group.leave() // 나 다 됐어 가볼게~
//                self.firstImageView.image = image
            }
        group.enter()
            NetworkManager.shared.fetchImage { image in
                print("second image view succeed")
                group.leave()
//                self.secondImageView.image = image
            }
        group.enter()
            NetworkManager.shared.fetchImage { image in
                print("third image view succeed")
                group.leave()
//                self.thirdImageView.image = image
            }
        
        group.notify(queue: .main) {
            print(#function, "It's all done!")
        }
        
        print(#function, "END")
    }
}

