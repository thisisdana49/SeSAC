//
//  ViewController.swift
//  EveryLotto
//
//  Created by 조다은 on 2/24/25.
//

import UIKit
import SnapKit

final class ViewController: UIViewController {

    var resultLotto: Lotto?
    let pickerView = UIPickerView()
    let pickerTextField = UITextField()
    let headerLabel = UILabel()
    let headerDateLabel = UILabel()
    let roundTitlelabel = UILabel()
    let resultView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
    }
    
}

extension ViewController {
    
    private func configureHierarchy() {
        view.addSubview(pickerTextField)
        view.addSubview(headerLabel)
        view.addSubview(headerDateLabel)
        view.addSubview(roundTitlelabel)
        view.addSubview(resultView)
        
        for i in 0...7 {
            let label = UILabel()
            resultView.addArrangedSubview(label)
        }
    }
    
    private func configureLayout() {
        pickerTextField.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        
        headerLabel.snp.makeConstraints {
            $0.top.equalTo(pickerTextField.snp.bottom).offset(28)
            $0.leading.equalToSuperview().inset(20)
        }
        
        headerDateLabel.snp.makeConstraints {
            $0.top.equalTo(pickerTextField.snp.bottom).offset(28)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        roundTitlelabel.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(48)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        resultView.snp.makeConstraints {
            $0.top.equalTo(roundTitlelabel.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        for (index, label) in resultView.subviews.enumerated() {
            label.snp.makeConstraints {
                $0.centerY.equalToSuperview()
            }
        }
    }
    
    private func configureView() {
        pickerTextField.inputView = pickerView
        
        headerLabel.text = "당첨번호 안내"
        headerLabel.textAlignment = .left
        headerLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        headerDateLabel.text = "2024-04-30 추첨"
        headerDateLabel.textAlignment = .right
        headerDateLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        headerDateLabel.textColor = .systemGray
        
//        roundTitlelabel.text = "\(selectedRound)회 당첨결과"
        roundTitlelabel.text = "NNNN회 당첨결과"
        roundTitlelabel.textAlignment = .center
        roundTitlelabel.font = UIFont.systemFont(ofSize: 23, weight: .medium)
        
        resultView.axis = .horizontal
        resultView.distribution = .fillEqually
        resultView.spacing = 4
        resultView.alignment = .fill
        
        for (index, currentLabel) in resultView.subviews.enumerated() {
            let label = currentLabel as! UILabel
            if index == 6 {
                label.text = "+"
                label.textAlignment = .center
                label.font = UIFont.systemFont(ofSize: 22)
            } else {
                label.text = "\(resultLotto?.drwtNums[index])"
                label.textAlignment = .center
                label.backgroundColor = .black
                label.textColor = .white
//                label.layer.cornerRadius = label.layer.frame.height / 2
                label.layer.masksToBounds = true
            }
        }
    }
    
}
