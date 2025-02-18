//
//  BirthdayViewController.swift
//  RxSampleProject
//
//  Created by 조다은 on 2/18/25.
//

import UIKit
import RxCocoa
import RxSwift

class BirthdayViewController: BaseViewController, ViewControllerProtocol {

    let birthDayPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "ko-KR")
        picker.maximumDate = Date()
        return picker
    }()
    
    let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 10
        return stack
    }()
    
    let yearLabel: UILabel = {
       let label = UILabel()
        label.text = "2023년"
        label.textColor = .black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    let monthLabel: UILabel = {
       let label = UILabel()
        label.text = "33월"
        label.textColor = .black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    let dayLabel: UILabel = {
       let label = UILabel()
        label.text = "99일"
        label.textColor = .black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    let validLabel: UILabel = {
       let label = UILabel()
        label.text = "성인인증이 완료 되었습니다."
        label.textColor = .black

        return label
    }()
    
    let ageValid = BehaviorSubject(value: "0")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        configure()
    }
    
    internal func bind() {
        birthDayPicker.rx.date
            .map { date -> (String, String, String) in
                let calendar = Calendar.current
                let year = calendar.component(.year, from: date)
                let month = calendar.component(.month, from: date)
                let day = calendar.component(.day, from: date)
                
                return ("\(year)", "\(month)", "\(day)")
            }
            .subscribe(with: self) { owner, value in
                let (year, month, day) = value
                owner.yearLabel.text = "\(year)년"
                owner.monthLabel.text = "\(month)월"
                owner.dayLabel.text = "\(day)일"
                owner.ageValid.onNext(year)
            } onError: { owner, error in
                print(error)
            } onCompleted: { owner in
                print("on completed")
            } onDisposed: { owner in
                print("on disposed")
            }
            .disposed(by: disposeBag)
        
        ageValid
            .map { value -> Bool in
                return Int(value)! > 2004
            }
            .bind(to: validLabel.rx.isHidden)
            .disposed(by: disposeBag)
    }
    
    internal func configure() {
        view.backgroundColor = .white
        
        view.addSubview(containerStackView)
        view.addSubview(birthDayPicker)
        view.addSubview(validLabel)

        containerStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        [yearLabel, monthLabel, dayLabel].forEach {
            $0.textAlignment = .center
            containerStackView.addArrangedSubview($0)
        }
        
        birthDayPicker.snp.makeConstraints {
            $0.top.equalTo(containerStackView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        validLabel.snp.makeConstraints {
            $0.top.equalTo(birthDayPicker.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
        }
    }
    
}
