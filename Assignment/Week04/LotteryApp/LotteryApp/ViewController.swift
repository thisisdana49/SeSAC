//
//  ViewController.swift
//  LotteryApp
//
//  Created by 조다은 on 1/14/25.
//

import UIKit
import SnapKit
import Alamofire

class ViewController: UIViewController, ViewConfiguration {
    var dummyRounds: [Int] = Array(1...10)
    
    let pickerView = UIPickerView()

    let pickerTextField = UITextField()
    let headerLabel = UILabel()
    let headerDateLabel = UILabel()
    let roundTitlelabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        configureHierarchy()
        configureLayout()
        configureView()
    }

    func configureHierarchy() {
        view.addSubview(pickerTextField)
        view.addSubview(headerLabel)
        view.addSubview(headerDateLabel)
        view.addSubview(roundTitlelabel)
    }
    
    func configureLayout() {
        pickerTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(pickerTextField.snp.bottom).offset(28)
            make.leading.equalToSuperview().inset(20)
        }
        
        headerDateLabel.snp.makeConstraints { make in
            make.top.equalTo(pickerTextField.snp.bottom).offset(28)
            make.trailing.equalToSuperview().inset(20)
        }
        
        roundTitlelabel.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(100)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    func configureView() {
        pickerTextField.borderStyle = .line
        pickerTextField.inputView = pickerView
        
        headerLabel.text = "당첨번호 안내"
        headerLabel.textAlignment = .left
        headerLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        headerDateLabel.text = "2024-04-30 추첨"
        headerDateLabel.textAlignment = .right
        headerDateLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        headerDateLabel.textColor = .systemGray
        
        roundTitlelabel.text = "913회 당첨결과"
        roundTitlelabel.textAlignment = .center
        roundTitlelabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
    }
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(dummyRounds[row])
    }
}

#Preview {
    ViewController()
}
