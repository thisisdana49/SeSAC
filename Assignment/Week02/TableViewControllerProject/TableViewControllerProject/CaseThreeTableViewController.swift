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

        navigationItem.title = "쇼핑"
        tableView.separatorStyle = .none
        todoTextField.placeholder = "무엇을 구매하실 건가요?"
        todoTextField.backgroundColor = .systemGray6
        
        addButton.setTitle("추가", for: .normal)
        addButton.backgroundColor = .systemGray5
        addButton.layer.cornerRadius = 5
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // tag를 0으로 줬더니 view의 색이 변하지 않았다. cell의 속성 tag 기본값이 0이라서 그런 것일까?
        let backgroundView = cell.viewWithTag(100)
        let checkboxImage = cell.viewWithTag(1) as? UIImageView
        let todoLabel = cell.viewWithTag(2) as? UILabel
        let bookmarkImage = cell.viewWithTag(3) as? UIImageView
        
        backgroundView?.backgroundColor = .systemGray6
        backgroundView?.layer.cornerRadius = 10
        checkboxImage?.image = UIImage(systemName: "checkmark.square")?.withTintColor(.black).withRenderingMode(.alwaysOriginal)
        todoLabel?.text = todoArray[indexPath.row]
        todoLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        bookmarkImage?.image = UIImage(systemName: "star")?.withTintColor(.black).withRenderingMode(.alwaysOriginal)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
    }
    
    @IBAction func addTodoButtonTapped(_ sender: UIButton) {
        todoArray.append(todoTextField.text ?? "")
        todoTextField.text = ""
        tableView.reloadData()
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
