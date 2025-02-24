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

    private var resultLabel: [UILabel] = []
    private let pickerView = UIPickerView()
    private let pickerTextField = UITextField()
    private let headerLabel = UILabel()
    private let headerDateLabel = UILabel()
    private let separatorView = UIView()
    private let roundTitleLabel = UILabel()
    private let resultView = UIStackView()
    private let observableButton = UIButton()
    private let singleButton = UIButton()
    
    private let viewModel =  ViewModel()
    private let disposeBag = DisposeBag()
    
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
            .compactMap { $0 }
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
        view.addSubview(separatorView)
        view.addSubview(roundTitleLabel)
        view.addSubview(resultView)
        view.addSubview(observableButton)
        view.addSubview(singleButton)
        
        for _ in 0...7 {
            let label = CustomLabel()
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
        
        separatorView.snp.makeConstraints{
            $0.top.equalTo(headerDateLabel.snp.bottom).offset(12)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(1)
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
            $0.centerY.equalToSuperview().offset(-12)
            $0.leading.equalToSuperview().inset(32)
        }
        
        singleButton.snp.makeConstraints{
            $0.centerY.equalToSuperview().offset(-12)
            $0.trailing.equalToSuperview().inset(32)
        }
    }
    
    private func configureView() {
        pickerTextField.inputView = pickerView
        pickerTextField.borderStyle = .roundedRect
        pickerTextField.textAlignment = .center
        
        headerLabel.text = "당첨번호 안내"
        headerLabel.textAlignment = .left
        headerLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        headerDateLabel.text = "yyyy-MM-dd 추첨"
        headerDateLabel.textAlignment = .right
        headerDateLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        headerDateLabel.textColor = .systemGray
        
        separatorView.backgroundColor = .systemGray4
        
        roundTitleLabel.text = "NNNN회 당첨결과"
        roundTitleLabel.textAlignment = .center
        roundTitleLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        
        resultView.axis = .horizontal
        resultView.distribution = .fillEqually
        resultView.spacing = 4
        resultView.alignment = .fill
        
        for (index, currentLabel) in resultView.subviews.enumerated() {
            let label = currentLabel as! UILabel
            if index == 6 {
                label.text = "+"
                label.textColor = .black
                label.textAlignment = .center
                label.font = UIFont.systemFont(ofSize: 22)
            } else {
                resultLabel.append(label)
                label.text = "\(index)"
                label.textAlignment = .center
                label.backgroundColor = .black
                label.textColor = .white
                label.layer.cornerRadius = label.layer.frame.height / 2
                label.layer.masksToBounds = true
            }
        }
        
        var config1 = UIButton.Configuration.filled()
        let titleAttr1 = AttributedString.init("Call with Observable")
        config1.baseBackgroundColor = .systemPurple
        config1.attributedTitle = titleAttr1
        observableButton.configuration = config1
        
        var config2 = UIButton.Configuration.filled()
        let titleAttr2 = AttributedString.init("Call with Single")
        config2.baseBackgroundColor = .systemTeal
        config2.attributedTitle = titleAttr2
        singleButton.configuration = config2
    }
    
}
