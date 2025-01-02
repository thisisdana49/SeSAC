//
//  BasicTableViewController.swift
//  MySecondApp
//
//  Created by 조다은 on 1/2/25.
//

import UIKit

class BasicTableViewController: UITableViewController {

    var list = ["Project", "Main Task", "SeSAC Assignment"] {
        didSet { // property가 달라질 때 실행되는 메서드
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 모두 같은 높이를 주려고 할 때는 그냥 이렇게 주면 됨.
        tableView.rowHeight = 80
        
        // create new Monster
        var monster = Monster(clothes: "Dress", speed: 10, power: 10, experience: 10) // 인스턴스 생성
        var monsterStrunct = MonsterStruct(clothes: <#T##String#>, speed: <#T##Int#>, power: <#T##Int#>, experience: <#T##Int#>)
    }
    
    // 1. Number of Section
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Default value is 1
        return 1
    }
    
    // 2. Number of Rows in Section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 왜 두 번 호출이 되나?
        // Apple이 부르는 거라서 의문을 가지지 않아도 될 듯함
        print(#function)
        return list.count
    }
    
    // ⭐️ 3. Cell design and Data
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell의 개수만큼 호출이 된다
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell")
        
        if indexPath.row >= 0 && indexPath.row < 3 {
            cell?.backgroundColor = .lightGray
        } else {
            cell?.backgroundColor = .white
        }
        // else 처리가 되어있지 않으면, 100% 모든 케이스에 대해서 처리를 해주지 않으면 ->
        
        cell?.textLabel?.text = list[indexPath.row]
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        cell?.detailTextLabel?.text = "상세보기"
        cell?.detailTextLabel?.setPrimaryLabel("test")
        
        print(#function, indexPath)
        
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, indexPath)
        list.remove(at: indexPath.row)
    }
    
    // 3. Height for Row
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 200
        } else {
            return 80
        }
    }
    
    @IBAction func randomTextTapped(_ sender: UIBarButtonItem) {
        let random = ["장보기", "영화보기", "쇼핑하기", "맛집탐방", "새싹과제", "산책하기"]
        let value = random.randomElement()!
        list.append(value)
        
        // view와 Data는 따로 놀기 때문에 갱신하며 잘 맞춰줘야 한다!
        tableView.reloadData()
    }
    
}
