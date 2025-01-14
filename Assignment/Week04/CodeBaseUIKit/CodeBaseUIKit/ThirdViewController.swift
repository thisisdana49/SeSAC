//
//  ThirdViewController.swift
//  CodeBaseUIKit
//
//  Created by 조다은 on 1/13/25.
//

import UIKit
import SnapKit
import Alamofire

class ThirdViewController: UIViewController, ViewConfiguration {
    
    private let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
    var dailyBoxOfficeLists: [dailyBoxOfficeList]?
    
    var searchDate = "20250113"
    
    lazy var searchTextField = UITextField()
    let backgroundImageView = UIImageView()
    let backgroundView = UIView()
    let searchButton = UIButton()
    lazy var tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        
        configureTableView()
        configureHierarchy()
        configureLayout()
        configureView()
        
        searchButtonTapped()
    }
    
    func configureHierarchy() {
        view.addSubview(backgroundImageView)
        view.addSubview(backgroundView)
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        backgroundImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }

        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(searchTextField.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        tableView.backgroundColor = .clear
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(30)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    func configureView() {
        searchTextField.frame.size.width = 300
        searchTextField.frame.size.height = 40
        searchTextField.layer.addBorder([.bottom], color: .white, width: 2)
        searchTextField.attributedPlaceholder = NSAttributedString(string: "원하는 날짜를 검색해주세요. ex. 240412", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, .font : UIFont.systemFont(ofSize: 16)])
        
        backgroundImageView.image = .background
        backgroundImageView.contentMode = .scaleAspectFill
        
        backgroundView.backgroundColor = UIColor(.black).withAlphaComponent(0.5)
        
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.black, for: .normal)
        searchButton.backgroundColor = .white
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    // MARK: Action method
    @objc
    func searchButtonTapped() {
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(apiKey!)&targetDt=\(searchDate)"
        AF.request(url, method: .get).responseDecodable(of: Movies.self) { response in
            switch response.result {
            case .success(let movies):
                self.dailyBoxOfficeLists = movies.boxOfficeResult.dailyBoxOfficeList
                print(self.dailyBoxOfficeLists?.first?.movieNm)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

// MARK: UITableView Delegate, UITableView DataSource
extension ThirdViewController: UITableViewDelegate, UITableViewDataSource {
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ThirdTableViewCell.self, forCellReuseIdentifier: "ThirdTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyBoxOfficeLists?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdTableViewCell", for: indexPath) as? ThirdTableViewCell else { return UITableViewCell() }
        let row = dailyBoxOfficeLists?[indexPath.row]
        
        cell.backgroundColor = .clear
        cell.rankingLabel.text = row?.rank
        cell.titleLabel.text = row?.movieNm
        cell.dateLabel.text = row?.openDt
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

// MARK: UITextField Delegate
extension ThirdViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
   
        searchDate = text
        searchButtonTapped()
        return true
    }
}


#Preview {
    ThirdViewController()
}
