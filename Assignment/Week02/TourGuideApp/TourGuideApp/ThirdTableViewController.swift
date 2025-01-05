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
    
    let shoppingLists = ShoppingList().list
    
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
        
        cell.doneButton.setImage(UIImage(systemName: item.done ? "checkmark.square" : "square")?.withTintColor(.black).withRenderingMode(.alwaysOriginal), for: .normal)
        
        cell.titleLabel?.text = item.title
        cell.titleLabel.textColor = .black
        
        cell.bookmarkButton.setImage(UIImage(systemName: item.bookmark ? "star.fill" : "star")?.withTintColor(.black).withRenderingMode(.alwaysOriginal), for: .normal)

        return cell
    }

    fileprivate func setUI() {
        shopListTextField.placeholder = "무엇을 구매하실 건가요?"
        shopListTextField.backgroundColor = .systemGray6
        
        addButton.isUserInteractionEnabled = true
        addButton.setTitle("추가", for: .normal)
        addButton.tintColor = .black
        addButton.backgroundColor = .systemGray5
        addButton.layer.cornerRadius = 10
    }
}
