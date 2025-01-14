//
//  RandomViewController.swift
//  MyFourthProject
//
//  Created by 조다은 on 1/14/25.
//

import UIKit
import SnapKit
import Alamofire




protocol Viewconfiguration: AnyObject {
    func configureHierarchy()   // addSubview
    func configureLayout()      // snapKit
    func configureView()        // property
}

class RandomViewController: UIViewController, Viewconfiguration {

    let dogImageView = UIImageView()
    let nameLabel = UILabel()
    let randomButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        view.addSubview(dogImageView)
        view.addSubview(nameLabel)
        view.addSubview(randomButton)
    }
    
    func configureLayout() {
        dogImageView.snp.makeConstraints { make in
            make.size.equalTo(300)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(dogImageView.snp.bottom).offset(20)
        }
        
        randomButton.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
        }
    }
    
    func configureView() {
        dogImageView.backgroundColor = .brown
        nameLabel.backgroundColor = .systemGreen
        randomButton.backgroundColor = .brown
        randomButton.addTarget(self, action: #selector(userButtonTapped), for: .touchUpInside)
    }
    
    
    // 왜 1 4 2 3?
    // 버튼을 눌렀는데, 통신하는데 10초가 걸리면 10초동안 사용자는 뭘하고 있을까요? 앱은 동작하고 있을까요?
    @objc
    func randomButtonTapped() {
        // 버튼 클릭 시 랜덤으로 강아지가 나오게.
        print("=======1=======")
        let url = "https://dog.ceo/api/breeds/image/random"
        AF.request(url, method: .get).responseDecodable(of: Dog.self) { response in
            print("=======2=======")
            switch response.result {
            case .success(let value):
                print(value.message)
                // 클로저 : AF 구문 안이기 때문에, 내꺼 nameLabel을 쓰겠다라는 의미
                let request = URLRequest(url: URL(string: value.message)!)
                URLSession.shared.dataTask(with: request) { data, resspone, error in
                    let image = UIImage(data: data!)
                    DispatchQueue.main.async {
                        self.dogImageView.image = image
                        self.nameLabel.text = value.message
                    }
                }.resume()
            case .failure(let error):
                print(error)
            }
            print("=======3=======")
        }
        print("=======4=======")
    }
    
    @objc
    func lottoButtonTapped() {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=888"
        AF.request(url, method: .get).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let value):
                self.nameLabel.text = value.drwNoDate + value.firstWinamnt.formatted()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc
    func userButtonTapped() {
        let url = "https://randomuser.me/api/?results=50"
        AF.request(url, method: .get).responseDecodable(of: User.self) { response in
            switch response.result {
            case .success(let value):
                self.nameLabel.text = value.results[Int.random(in: 0..<50)].name.last
            case .failure(let error):
                print(error)
            }
        }
    }
}

#Preview {
    RandomViewController()
}
