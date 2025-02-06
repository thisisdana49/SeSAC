//
//  BoxOfficeViewController.swift
//  SeSACSevenWeek_2
//
//  Created by Jack on 2/6/25.
//

import UIKit
import SnapKit

final class BoxOfficeViewController: UIViewController {
    
    private lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "날짜 선택"
        textField.borderStyle = .roundedRect 
        return textField
    }()
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        return picker
    }()
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("검색", for: .normal)
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MovieCell")
        tableView.dataSource = self
        return tableView
    }()
    
    private let viewModel = BoxOfficeViewModel()
     
    deinit {
        print("BoxOfficeViewController Deinit")
    }
     
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureConstraints()
        bindData()
    }
    
    
    private func bindData() {
 
    }
    
    @objc private func datePickerValueChanged() {
        print(datePicker.date)
    }
    
    @objc private func searchButtonTapped() {
        print(#function)
    }
}

extension BoxOfficeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputBoxOffice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        let data = viewModel.outputBoxOffice[indexPath.row]
        cell.textLabel?.text = "\(data.rank). \(data.movieNm) (관객수: \(data.audiCnt))"
        return cell
    }
}
 
extension BoxOfficeViewController {
    
    private func configureView() {
        view.backgroundColor = .white
        view.addSubview(dateTextField)
        view.addSubview(searchButton)
        view.addSubview(tableView)
    }
    
    private func configureConstraints() {
        dateTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalTo(searchButton.snp.left).offset(-10)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(dateTextField)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(60)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(dateTextField.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
}
