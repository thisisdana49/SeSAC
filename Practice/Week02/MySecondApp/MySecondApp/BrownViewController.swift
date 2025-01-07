//
//  BrownViewController.swift
//  MySecondApp
//
//  Created by 조다은 on 1/7/25.
//

import UIKit

class BrownViewController: UIViewController {
    @IBOutlet var testLabel: UILabel!
    
    // 1. Pass Data - 데이터를 받을 공간(프로퍼티 생성)
    // ViewController에 init을 넣는 건 까다로운 작업이기 때문에 주로 그냥 Optional로 잡음
    var contents: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 3. Pass Data - 전달 받은 값을 화면에 표현
        navigationItem.title = "Brown"
        testLabel.text = contents
    }
    
    @IBAction func popButtonTapped(_ sender: UIButton) {
        print(#function)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        print(#function)
        dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
