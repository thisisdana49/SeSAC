//
//  ThirdTableViewController.swift
//  TourGuideApp
//
//  Created by 조다은 on 1/3/25.
//

import UIKit

class ThirdTableViewController: UITableViewController {

    @IBOutlet var shopListTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    var shoppingLists = ShoppingList().list
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingLists.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdTableViewCell", for: indexPath) as! ThirdTableViewCell
        
        let item = shoppingLists[indexPath.row]
        
        cell.baseView.backgroundColor = .systemGray6
        cell.baseView.layer.cornerRadius = 10
        
        cell.doneButton.isUserInteractionEnabled = true
        cell.doneButton.tag = indexPath.row
        cell.doneButton.setImage(UIImage(systemName: item.done ? "checkmark.square" : "square")?.withTintColor(.black).withRenderingMode(.alwaysOriginal), for: .normal)
        cell.doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        
        cell.titleLabel?.text = item.title
        cell.titleLabel.textColor = .black
        
        cell.bookmarkButton.isUserInteractionEnabled = true
        cell.bookmarkButton.tag = indexPath.row
        cell.bookmarkButton.setImage(UIImage(systemName: item.bookmark ? "star.fill" : "star")?.withTintColor(.black).withRenderingMode(.alwaysOriginal), for: .normal)
        cell.bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        shoppingLists.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let newItem = Shopping(title: shopListTextField.text ?? "error", done: false, bookmark: false)
        shoppingLists.append(newItem)
        shopListTextField.text = ""
        tableView.reloadData()
    }
    
    @objc func doneButtonTapped(_ sender: UIButton) {
        shoppingLists[sender.tag].done.toggle()
        tableView.reloadData()
    }
    
    @objc func bookmarkButtonTapped(_ sender: UIButton) {
        shoppingLists[sender.tag].bookmark.toggle()
        tableView.reloadData()
    }
    
    fileprivate func setUI() {
        navigationItem.title = "쇼핑"
        tableView.separatorStyle = .none
        shopListTextField.placeholder = "무엇을 구매하실 건가요?"
        shopListTextField.backgroundColor = .systemGray6
        
        addButton.isUserInteractionEnabled = true
        addButton.setTitle("추가", for: .normal)
        addButton.tintColor = .black
        addButton.backgroundColor = .systemGray5
        addButton.layer.cornerRadius = 10
    }
}
