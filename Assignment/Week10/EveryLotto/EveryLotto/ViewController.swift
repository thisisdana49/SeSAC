//
//  ViewController.swift
//  EveryLotto
//
//  Created by 조다은 on 2/24/25.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class ViewController: UIViewController {

    private let viewModel =  ViewModel()
    private let disposeBag = DisposeBag()
    
    var resultLabel: [UILabel] = []
    let pickerView = UIPickerView()
    let pickerTextField = UITextField()
    let headerLabel = UILabel()
    let headerDateLabel = UILabel()
    let roundTitleLabel = UILabel()
    let resultView = UIStackView()
    let observableButton = UIButton()
    let singleButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        let input = ViewModel.Input(viewDidLoad: Observable.just(()),
                                    pickerText: pickerTextField.rx.text,
                                    selectPickerItem: pickerView.rx.modelSelected(Int.self).map{ $0.first! },
                                    editingDidEnd: pickerTextField.rx.controlEvent(.editingDidEnd),
                                    observableButtonTap: observableButton.rx.tap,
                                    singleButtonTap: singleButton.rx.tap
        )
        let output = viewModel.transform(input: input)

        output.roundList
            .bind(to: pickerView.rx.itemTitles) { _, item in
                return "\(item)"
            }
            .disposed(by: disposeBag)
        
        output.selectedItem
            .bind(with: self) { owner, value in
                owner.pickerTextField.text = value
            }
            .disposed(by: disposeBag)
        
        output.resultLotto
            .drive(with: self) { owner, value in
                for index in 0...value.drwtNums.count-1 {
                    owner.roundTitleLabel.text = "\(value.drwNo)회 당첨결과"
                    owner.headerDateLabel.text = "\(value.drwNoDate) 추첨"
                    owner.resultLabel[index].text = "\(value.drwtNums[index])"
                }
            }
            .disposed(by: disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension ViewController {
    
    private func configureHierarchy() {
        view.addSubview(pickerTextField)
        view.addSubview(headerLabel)
        view.addSubview(headerDateLabel)
        view.addSubview(roundTitleLabel)
        view.addSubview(resultView)
        view.addSubview(observableButton)
        view.addSubview(singleButton)
        
        for _ in 0...7 {
            let label = UILabel()
            resultView.addArrangedSubview(label)
            resultLabel.append(label)
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
        
        roundTitleLabel.snp.makeConstraints {
            $0.top.equalTo(headerLabel.snp.bottom).offset(48)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        resultView.snp.makeConstraints {
            $0.top.equalTo(roundTitleLabel.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(16)
            $0.height.equalTo(44)
        }
        
        for (_, label) in resultView.subviews.enumerated() {
            label.snp.makeConstraints {
                $0.centerY.equalToSuperview()
            }
        }
        
        observableButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(40)
        }
        
        singleButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(40)
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
        roundTitleLabel.text = "NNNN회 당첨결과"
        roundTitleLabel.textAlignment = .center
        roundTitleLabel.font = UIFont.systemFont(ofSize: 23, weight: .medium)
        
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
//                label.text = "\(resultLotto.drwtNums[index])"
                label.text = "\(index)"
                label.textAlignment = .center
                label.backgroundColor = .black
                label.textColor = .white
//                label.layer.cornerRadius = label.layer.frame.height / 2
                label.layer.masksToBounds = true
            }
        }
        
        observableButton.setTitle("Observable", for: .normal)
        observableButton.backgroundColor = .black
        
        singleButton.setTitle("Single", for: .normal)
        singleButton.backgroundColor = .black
    }
    
}
