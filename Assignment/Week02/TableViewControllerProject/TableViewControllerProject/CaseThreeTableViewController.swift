//
//  CaseThreeTableViewController.swift
//  TableViewControllerProject
//
//  Created by 조다은 on 1/2/25.
//

import UIKit

class CaseThreeTableViewController: UITableViewController {

    @IBOutlet var todoTextField: UITextField!
    @IBOutlet var addButton: UIButton!

    var todoArray: [String] = ["그립톡 구매하기", "사이다 사기", "아이패드 케이스 최저가 알아보기", "양말"]

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(
        _ tableView: UITableView, numberOfRowsInSection section: Int
    ) -> Int {
        return todoArray.count
    }

    override func tableView(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "reuseIdentifier", for: indexPath)

        let backgroundView = cell.viewWithTag(100)
        let checkboxButton = cell.viewWithTag(1) as? UIButton
        let todoLabel = cell.viewWithTag(2) as? UILabel
        let bookmarkButton = cell.viewWithTag(3) as? UIButton

        cell.selectionStyle = .none

        // tag를 0으로 줬더니 view의 배경색이 변하지 않았다. cell의 속성 tag 기본값이 0이라서 그런 것일까?
        backgroundView?.backgroundColor = .systemGray6
        backgroundView?.layer.cornerRadius = 10

        checkboxButton?.setImage(
            UIImage(systemName: "square")?.withTintColor(.black)
                .withRenderingMode(.alwaysOriginal), for: .normal)
        checkboxButton?.setImage(
            UIImage(systemName: "checkmark.square")?.withTintColor(.black)
                .withRenderingMode(.alwaysOriginal), for: .selected)
        checkboxButton?.tintColor = .clear
        checkboxButton?.addTarget(
            self, action: #selector(checkboxButtonTapped(sender:)),
            for: .touchUpInside)

        todoLabel?.text = todoArray[indexPath.row]
        todoLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)

        bookmarkButton?.setImage(
            UIImage(systemName: "star")?.withTintColor(.black)
                .withRenderingMode(.alwaysOriginal), for: .normal)
        bookmarkButton?.setImage(
            UIImage(systemName: "star.fill")?.withTintColor(.black)
                .withRenderingMode(.alwaysOriginal), for: .selected)
        bookmarkButton?.tintColor = .clear
        bookmarkButton?.isUserInteractionEnabled = true
        bookmarkButton?.addTarget(
            self, action: #selector(bookmarkButtonTapped(sender:)),
            for: .touchUpInside)

        return cell
    }

    override func tableView(
        _ tableView: UITableView, didSelectRowAt indexPath: IndexPath
    ) {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "reuseIdentifier", for: indexPath)
    }

    @IBAction func addTodoButtonTapped(_ sender: UIButton) {
        todoArray.append(todoTextField.text ?? "")
        todoTextField.text = ""
        tableView.reloadData()
    }

    @objc func checkboxButtonTapped(sender: UIButton) {
        print(sender.superview?.superview?.superview)

        if let cell = sender.superview?.superview?.superview as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell)
        {
            // indexPath를 사용하여 원하는 작업 수행
            let todoLabel = cell.viewWithTag(2) as? UILabel
            sender.isSelected.toggle()
            todoLabel?.textColor = sender.isSelected ? .systemGray2 : .black
        }
    }

    @objc func bookmarkButtonTapped(sender: UIButton) {
        sender.isSelected.toggle()
    }

    fileprivate func setUI() {
        navigationItem.title = "쇼핑"
        tableView.separatorStyle = .none
        todoTextField.placeholder = "무엇을 구매하실 건가요?"
        todoTextField.backgroundColor = .systemGray6

        addButton.setTitle("추가", for: .normal)
        addButton.backgroundColor = .systemGray5
        addButton.layer.cornerRadius = 5
        addButton.tintColor = .black
    }
}
