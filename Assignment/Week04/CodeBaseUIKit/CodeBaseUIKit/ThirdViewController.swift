//
//  ThirdViewController.swift
//  CodeBaseUIKit
//
//  Created by 조다은 on 1/13/25.
//

import UIKit
import SnapKit

class ThirdViewController: UIViewController {
    let movies: [Movie] = mockMovieLists
    lazy var searchTextField = {
        let textField = UITextField()
        textField.frame.size.width = 300
        textField.frame.size.height = 40
        textField.layer.addBorder([.bottom], color: .white, width: 2)
        
        return textField
    }()
    let backgroundImageView = {
        let imageView = UIImageView()
        imageView.image = .background
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    let backgroundView = {
        let view = UIView()
        view.backgroundColor = UIColor(.black).withAlphaComponent(0.5)
        
        return view
    }()
    
    let searchButton = {
        let button = UIButton()
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        
        return button
    }()
    lazy var tableView = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
        
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }

        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
        
        view.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(searchTextField.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ThirdTableViewCell.self, forCellReuseIdentifier: "ThirdTableViewCell")
        
        tableView.backgroundColor = .clear
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(30)
            make.bottom.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
        }
    }
    
}

extension ThirdViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdTableViewCell", for: indexPath) as? ThirdTableViewCell else { return UITableViewCell() }
        let row = movies[indexPath.row]
        
        cell.backgroundColor = .clear
        cell.rankingLabel.text = row.ranking
        cell.titleLabel.text = row.title
        cell.dateLabel.text = row.date
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

#Preview {
    ThirdViewController()
}
