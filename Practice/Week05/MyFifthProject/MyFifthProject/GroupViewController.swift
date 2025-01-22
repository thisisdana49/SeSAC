//
//  GroupViewController.swift
//  MyFifthProject
//
//  Created by 조다은 on 1/21/25.
//

import UIKit
import Kingfisher

class GroupViewController: UIViewController {
    
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
    
    var firstValue = ""
    var secondValue = ""
    var thirdValue = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        PhotoManager.shared.example2(api: .randomPhoto, type: RandomPhoto.self) { value in
//                    dump("통신 성공:\(value)")
//                } failHandler: { error in
//                    print("통신 실패")
//                    print(error)
//                }
        
        PhotoManager.shared.example2(api: .topic(id: "wallpapers"), type: Topic.self) { value in
            dump(value)
        } failHandler: { error in
            print("network error")
        }

        
//        PhotoManager.shared.example(api: .randomPhoto) { (value: RandomPhoto) in
//            print("Random Photo Network Success")
//            dump(value)
//        } failHandler: {
//            print("Network Failed")
//        }
//        PhotoManager.shared.example(api: .topic(id: "wallpapers")) { (value: Topic) in
//            print("Topics Network Success")
//            dump(value)
//        } failHandler: {
//            print("Network Failed")
//        }

        
//        example(a: 7) { value in
////            print(value)
//        }
//        
//        configureBorder(view: checkButton)
//        
//        Dummy(mainContents: 24, subContents: 1, others: 2)
//        Dummy(mainContents: true, subContents: true, others: 213)
        
//        let a = plus(a: "a", b: "b")
        
        // switch에서 default가 필요하거나 필요하지 않는 이유
//        var number = Int.random(in: 1...3)
//        switch number {
//        case 1: print("")
//        case 2: print("")
//        case 3: print("")
//        default:
//        }
        
        // 라이브러리나 프레임워크에서 만들어진 열거형의 모든 멤버(case)를 처리했음에도 불구하고
        // @unknown default를 써야지만이 앱이 강제종료 당하는 상황 등을 방지할 수 있다.
//        let value = NSTextAlignment.center
//        switch value {
//        case .left:
//            print("")
//        case .center:
//            print("")
//        case .right:
//            print("")
//        case .justified:
//            print("")
//        case .natural:
//            print("")
//        @unknown default: // 버전 이슈. 아직 @frozen이 아니라서 -> 추후의 버전에는 생길 수도 있기 때문에.
//            print("")
//        }
//        
//        PhotoManager.shared.callRequest(api: .randomPhoto)
//        PhotoManager.shared.callRequest(api: .photo(id: "HpZ6ucKjBtc"))
//        
        configureView()
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
        let vc = SearchViewController()
        navigationController?.pushViewController(vc, animated: true)
//        let group = DispatchGroup()
//        
//        group.enter()
//        PhotoManager.shared.getRandomPhoto { photo in
//            self.firstValue = photo.urls.thumb
//            group.leave()
//        } failHandler: {
//            group.leave()
//        }
//        
//        group.enter()
//        PhotoManager.shared.getRandomPhoto { photo in
//            self.secondValue = photo.urls.thumb
//            group.leave()
//        } failHandler: {
//            group.leave()
//        }
//        
//        group.enter()
//        PhotoManager.shared.getRandomPhoto { photo in
//            self.thirdValue = photo.urls.thumb
//            group.leave()
//        } failHandler: {
//            group.leave()
//        }
        
        // 누가 먼저 끝나는지 모르고, 순서를 보장해주는 것까지 핸들링하지는 못하지만
        // 세 통신이 모두 완료가 되었다는 신호를 확인할 수 있음.
        // 그렇다면 네트워크 통신이 느릴 때? Network condition이 좋지 않을 때.
//        group.notify(queue: .main) {
//            print(Thread.isMainThread) // 현재 스레드가 메인인지 아닌지를 알 수 있다.
//            self.firstImageView.kf.setImage(with: URL(string: self.firstValue))
//            self.secondImageView.kf.setImage(with: URL(string: self.secondValue))
//            self.thirdImageView.kf.setImage(with: URL(string: self.thirdValue))
//            print("끝!")
//        }
    }
}
