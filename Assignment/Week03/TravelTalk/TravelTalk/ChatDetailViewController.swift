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
    @IBOutlet var textViewHeight: NSLayoutConstraint!
    @IBOutlet var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureTableViewUI()
        configureTextView()
        
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
    
    private func configureTextView() {
        textView.delegate = self
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 20.0
        textView.font = UIFont.systemFont(ofSize: 16.0)
        textView.textColor = UIColor.black
        textView.backgroundColor = .systemGray6
        textView.isEditable = true
        textView.isScrollEnabled = true
        textView.contentInset.top = 8
        textView.contentInset.left = 16
        textView.textContainerInset.right = 20
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
        let currentRow = chatRoom?.chatList[indexPath.row]
        let beforeRow = indexPath.row > 0 ? chatRoom?.chatList[indexPath.row - 1] : nil
        
        let currentRowDate = Date.fromString(currentRow?.date ?? "", format: "yyyy-MM-dd HH:mm")
        let beforeRowDate = beforeRow != nil ? Date.fromString(beforeRow?.date ?? "", format: "yyyy-MM-dd HH:mm") : nil
        let dateString = currentRowDate?.toFormattedString("hh:mm a") ?? ""
        
        let dayChange: Bool
        if let beforeRowDate = beforeRowDate {
            dayChange = !Calendar.current.isDate(beforeRowDate, inSameDayAs: currentRowDate!)
        } else {
            dayChange = false
        }
        
        let dateSeparator = currentRowDate?.toFormattedString("yyyy년 MM월 dd일")
        
        if currentRow?.user == .user {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatUserDetailTableViewCell.identifier) as? ChatUserDetailTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configureData(
                date: dateString,
                message: currentRow?.message ?? "",
                dayChange: dayChange,
                dateSeparator: dateSeparator ?? ""
            )
            
            return cell
    } else {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatDetailTableViewCell.identifier) as? ChatDetailTableViewCell else { return UITableViewCell()}
        
        cell.configureData(
            image: currentRow?.user.profileImage ?? "",
            name: currentRow?.user.rawValue ?? "",
            date: dateString,
            message: currentRow?.message ?? ""
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

// MARK: TextView Delegate
extension ChatDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        switch textView.numberOfLines() {
        case 1:
            textViewHeight.constant = 50
        case 2:
            textViewHeight.constant = 70
        case 3...:
            textViewHeight.constant = 90
        default:
            textViewHeight.constant = 50
        }
    }
}

extension UITextView {
    func numberOfLines() -> Int {
        let size = CGSize(width: frame.width, height: .infinity)
        let estimatedSize = sizeThatFits(size)
        
        return Int(estimatedSize.height / (self.font!.lineHeight))
    }
    
    func alignTextVerticallyInContainer() {
        var topCorrect = (self.bounds.height - self.contentSize.height * self.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect
        self.contentInset.top = topCorrect
    }
}
