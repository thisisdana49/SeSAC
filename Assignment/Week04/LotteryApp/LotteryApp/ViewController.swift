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
    var roundLists: [Int] = Array(1...1154).reversed()
    var selectedRound: Int = 1154
    var resultLotto: Lotto?
    
    let pickerView = UIPickerView()
    
    let pickerTextField = UITextField()
    let headerLabel = UILabel()
    let headerDateLabel = UILabel()
    let roundTitlelabel = UILabel()
    let resultView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerTextField.delegate = self
        pickerView.delegate = self
        pickerView.dataSource = self
        
        configureHierarchy()
        configureLayout()
        configureView()
        
        pickerReturnTapped()
        getLotteryResult()
    }
    
    func configureHierarchy() {
        view.addSubview(pickerTextField)
        view.addSubview(headerLabel)
        view.addSubview(headerDateLabel)
        view.addSubview(roundTitlelabel)
        view.addSubview(resultView)
        
        for _ in 0...7 {
            let label = UILabel()
            resultView.addArrangedSubview(label)
        }
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
            make.top.equalTo(headerLabel.snp.bottom).offset(48)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        resultView.snp.makeConstraints { make in
            make.top.equalTo(roundTitlelabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(44)
        }
        
        for (index, label) in resultView.subviews.enumerated() {
            label.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
            }
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
        
        roundTitlelabel.text = "\(selectedRound)회 당첨결과"
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
    
    @objc
    func pickerReturnTapped() {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(selectedRound)"
        AF.request(url, method: .get).responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let value):
                self.resultLotto = value
                print("response is", self.resultLotto?.drwNoDate)
                
                DispatchQueue.main.async {
                    for (index, subview) in self.resultView.subviews.enumerated() {
                        guard let label = subview as? UILabel, let nums = self.resultLotto?.drwtNums else { continue }
                        if index == 6 {
                            label.text = "+"
                        } else if index == 7 {
                            label.text = "\(nums[6])"
                        } else {
                            label.text = "\(nums[index])"
                        }
                        label.layer.cornerRadius = label.frame.width / 2
                        label.setOwnColor()
                    }
                }
                
            case .failure(let error):
                print("Error fetching lotto results: \(error)")
                // Alert present
            }
        }
    }
    
    func getLotteryResult() {
        let standardDate = Date.fromString("2025-01-11", format: "yyyy-MM-dd")
        let weeks = Calendar.current.dateComponents([.weekOfMonth], from: standardDate!, to: Date())
        selectedRound += weeks.weekOfMonth ?? 0
        pickerReturnTapped()
    }
    
}

// MARK: UIPickerView Delegate, DataSource
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return roundLists.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(roundLists[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = "\(roundLists[row])"
        selectedRound = roundLists[row]
    }
    
}

// MARK: UITextField Delegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        roundTitlelabel.text = "\(selectedRound)회 당첨결과"
        pickerReturnTapped()
        return true
    }
}

#Preview {
    ViewController()
}
