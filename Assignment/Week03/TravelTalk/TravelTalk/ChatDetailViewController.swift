//
//  ChatDetailViewController.swift
//  TravelTalk
//
//  Created by 조다은 on 1/12/25.
//

import UIKit

class ChatDetailViewController: UIViewController {
    static let identifier = "ChatDetailViewController"
    var chatRoom: ChatRoom?
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        configureTableViewUI()
        
        setUI()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let idForOthers = ChatDetailTableViewCell.identifier
        let idForUser = ChatUserDetailTableViewCell.identifier
        let xibOthers = UINib(nibName: idForOthers, bundle: nil)
        let xibUser = UINib(nibName: idForUser, bundle: nil)
        tableView.register(xibOthers, forCellReuseIdentifier: idForOthers)
        tableView.register(xibUser, forCellReuseIdentifier: idForUser)
    }
    
    private func configureTableViewUI() {
        tableView.separatorStyle = .none
    }
    
    private func setUI() {
        navigationItem.title = chatRoom?.chatroomName
        navigationController?.navigationItem.backButtonTitle = "뒤로"
        
        let index = IndexPath(row: (chatRoom?.chatList.count ?? 1) - 1, section: 0)
        tableView.scrollToRow(at: index, at: .bottom, animated: false)
    }
}

// MARK: TableView Delegate, DataSource
extension ChatDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRoom?.chatList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = chatRoom?.chatList[indexPath.row]
        
        let dateFromString = Date.fromString(row?.date ?? "", format: "yyyy-MM-dd HH:mm")
        let dateString = dateFromString?.toFormattedString("hh:mm") ?? ""
        
        if row?.user == .user {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatUserDetailTableViewCell.identifier) as? ChatUserDetailTableViewCell else { return UITableViewCell()}
            
            cell.configureData(
                date: dateString,
                message: row?.message ?? "")
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatDetailTableViewCell.identifier) as? ChatDetailTableViewCell else { return UITableViewCell()}
            
            cell.configureData(
                image: row?.user.profileImage ?? "",
                name: row?.user.rawValue ?? "",
                date: dateString,
                message: row?.message ?? ""
            )
            
            DispatchQueue.main.async {
                cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.height / 2
                cell.profileImageView.layer.borderColor = UIColor.systemGray5.cgColor
                cell.profileImageView.layer.borderWidth = 1
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
