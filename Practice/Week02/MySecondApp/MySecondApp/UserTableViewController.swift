//
//  UserTableViewController.swift
//  MySecondApp
//
//  Created by 조다은 on 1/3/25.
//

import UIKit

struct Duck {
    let name: String
    let message: String
    let profileImage: String
}

class UserTableViewController: UITableViewController {
    
    var friends = FriendsInfo().list
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UIBarButton도 UIControl을 상속 받고 있음.
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "bubble.fill"), style: .plain, target: self, action: #selector(rightBarButtonItemTapped))
        navigationItem.rightBarButtonItem = rightBarButton
        
        // xib cell
        // bundle에 관련해서는 언젠가 다음 시간에.
//        let nib = UINib(nibName: "NoProfileTableViewCell", bundle: nil)
//        tableView.register(nib, forCellReuseIdentifier: "NoProfileTableViewCell")
    }
    
    @objc func rightBarButtonItemTapped() {
        print(#function)
        // 1. 스토리보드를 특정 Practice
        let sb = UIStoryboard(name: "User", bundle: nil)
        
//        self.storyboard // 나 스토리보드 있지? -> 있음 아무래도
//        storyboard
        
        // 2. 전환할 뷰컨트롤러 가져오기
        //        let vc = BrownTableViewController() 코드 베이스로 작성할 경우
        let vc = sb.instantiateViewController(withIdentifier: "YellowViewController") as! YellowViewController
        
        // 3. 화면을 전한할 방법 선택하기 - Show Present
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "NoProfileTableViewCell", for: indexPath) as! NoProfileTableViewCell
        
        // ⬇️ UserTableViewCell의 인스턴스를 만듦
        // 그래서 각각의 인스턴스(김민준, 이서연...)들이 생겨나고 접근할 수 있는 것
        // 그런데 profile, alias 이런 건 달라도 identifier는 다 같지 않나? 한 공간에 두고 시용할 수 있지 않나?
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
        
        // cell의 identifier 이름과 UITableViewCell을 클래스 이름을 같게 하는게 좋음.
        // 어떻게하면 cellForRowAt의 코드 분량을 줄일 수 있을까?🤫
        // -> cell 파일 내부에 configureData 추가
        let friend = friends[indexPath.row]
        cell.configureData(row: friend)

        // cell. 아래에 자동완성으로 나오는 메서드, 프로퍼티들은 tableView가 이미 알고 있다고 보면 됨
        // 이미 연결고리로 서로 연결되어 있기 때문에 파일을 구분하는 것 -> 우리(개발자)의 편의
        
        
        // IBAction 대신에 코드로 연결
        // Function Types
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        // self : 이 TableView에서 일어날 일이야
        // .touchUpInside : 눌렀을 때 일어날 일이야
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    // cell 클릭 시
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, indexPath)
        let friend = friends[indexPath.row]
        
        // 1. 스토리보드를 특정 Practice
        let sb = UIStoryboard(name: "User", bundle: nil)
//        let brownVC = BrownViewController()
        
        // 2. 전환할 뷰컨트롤러 가져오기
        //        let vc = BrownTableViewController() 코드 베이스로 작성할 경우
        let vc = sb.instantiateViewController(withIdentifier: "BrownViewController") as! BrownViewController
//        값을 전달할 때 Outlet은 사용할 수 없다.
//        vc.testLabel.text = "다우니"
        // 2. Pass Data - vc가 갖고 있는 프로퍼티에 데이터 추가
        vc.contents = friend.name
        
//        vc.modalTransitionStyle = .crossDissolve
//        vc.modalPresentationStyle = .fullScreen
        
        // (Option) present이지만 navigation title도 쓰고 싶다면,
        // 다시 네비게이션 컨트롤러를 임베드해서 네비게이션 컨트롤러를 present
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        // 3. 화면을 전한할 방법 선택하기 - Modal
        present(nav, animated: true)
//        navigationController?.pushViewController(vc, animated: true)
//        Optioinal Chaining으로 인해, navigagtionController 다음 구문을 시행하지 않는 것.
        tableView.reloadData()
    }
    
    @objc func likeButtonTapped(_ sender: UIButton) {
        friends[sender.tag].like.toggle()
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .none)
    }
}
