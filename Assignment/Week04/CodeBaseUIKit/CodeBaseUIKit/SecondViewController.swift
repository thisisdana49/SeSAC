//
//  SecondViewController.swift
//  CodeBaseUIKit
//
//  Created by 조다은 on 1/13/25.
//

import UIKit
import SnapKit

class SecondViewController: UIViewController {

    let tabButtonOne = {
        let button = UIButton()
        button.setTitle("멤버십", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.backgroundColor = .naverBlack
//        button.layer.cornerRadius = 15
        
        return button
    }()
    let tabButtonTwo = {
        let button = UIButton()
        button.setTitle("현장결제", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 20
        
        return button
    }()
    
    let tabButtonThree = {
        let button = UIButton()
        button.setTitle("쿠폰", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.backgroundColor = .naverBlack
//        button.layer.cornerRadius = 15
        
        return button
    }()
    
    let payView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    let logoImageView = {
        let imageView = UIImageView()
        imageView.image = .naverLogo
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let closeButton = {
        let button = UIImageView()
        let image = UIImage(systemName: "xmark")?.withTintColor(.black).withRenderingMode(.alwaysOriginal)
        button.image = image
        button.contentMode = .scaleAspectFit
        
        return button
    }()
    
    let contentImageView = {
        let imageView = UIImageView()
        imageView.image = .naverLock
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let contentLabel = {
        let label = UILabel()
        label.text = "한 번만 인증하고\n비밀번호 없이 결제하세요"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    let checkLabel = {
        let label = UILabel()
        label.text = "바로 결제 사용하기"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        
        return label
    }()
    
    let confirmButton = {
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.backgroundColor = .naverPrimary
        button.layer.cornerRadius = 25
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureLayout()
    }
    
    func configureLayout() {
        view.backgroundColor = .naverBlack
        
        configureTabButtons()
        configurePayView()
    }
    
    func configureTabButtons() {
        view.addSubview(tabButtonTwo)
        view.addSubview(tabButtonOne)
        view.addSubview(tabButtonThree)
        
        tabButtonTwo.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(64)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        
        tabButtonOne.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(64)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        
        tabButtonThree.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(64)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
    }
    
    func configurePayView() {
        view.addSubview(payView)
        payView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(tabButtonTwo).offset(60)
            make.centerX.equalToSuperview()
            make.height.equalTo(460)
        }
        
        payView.addSubview(logoImageView)
        payView.addSubview(closeButton)
        payView.addSubview(contentImageView)
        payView.addSubview(contentLabel)
        payView.addSubview(checkLabel)
        payView.addSubview(confirmButton)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.leading.equalTo(16)
            make.width.equalTo(110)
        }
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.trailing.equalTo(-16)
            make.size.equalTo(25)
        }
        contentImageView.snp.makeConstraints { make in
            make.centerX.equalTo(payView)
            make.centerY.equalTo(payView).offset(-80)
            make.width.equalTo(140)
        }
        contentLabel.snp.makeConstraints { make in
            make.centerX.equalTo(payView)
            make.centerY.equalTo(payView).offset(20)
        }
        checkLabel.snp.makeConstraints { make in
            make.centerX.equalTo(payView)
            make.bottom.equalTo(confirmButton.snp.top).offset(-40)
        }
        confirmButton.snp.makeConstraints { make in
            make.centerX.equalTo(payView)
            make.bottom.equalTo(payView).inset(16)
            make.horizontalEdges.equalTo(payView).inset(16)
            make.height.equalTo(50)
        }
    }
}

#Preview {
    SecondViewController()
}
