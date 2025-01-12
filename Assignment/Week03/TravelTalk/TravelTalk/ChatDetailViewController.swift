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
        
        setUI()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        let id = ChatDetailTableViewCell.identifier
        let xib = UINib(nibName: id, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: id)
    }
    
    private func setUI() {
        navigationItem.title = chatRoom?.chatroomName
        navigationController?.navigationItem.backButtonTitle = "뒤로"

    }
}

// MARK: TableView Delegate, DataSource
extension ChatDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRoom?.chatList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatDetailTableViewCell.identifier) as? ChatDetailTableViewCell else { return UITableViewCell()}
        let row = chatRoom?.chatList[indexPath.row]
        
        cell.configureData(image: row?.user.profileImage ?? "", name: row?.user.rawValue ?? "", date: row?.date ?? "", message: row?.message ?? "")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
