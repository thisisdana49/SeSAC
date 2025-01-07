//
//  YellowViewController.swift
//  MySecondApp
//
//  Created by 조다은 on 1/7/25.
//

import UIKit

class YellowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func popButtonTapped(_ sender: UIButton) {
        print(#function)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        print(#function)
        dismiss(animated: true)
        // 위로 올라온 적이 없기 때문에 내려갈 수도 없음.
        // 코드 상에서 문제가 없지만 짝지가 없다는 것을 주의할 것.
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
