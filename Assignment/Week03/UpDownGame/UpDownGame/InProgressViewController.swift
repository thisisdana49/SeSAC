//
//  InProgressViewController.swift
//  UpDownGame
//
//  Created by 조다은 on 1/9/25.
//

import UIKit

class InProgressViewController: UIViewController {
    static let identifier = "InProgressViewController"

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var countTrialLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var resetButton: UILabel!
    @IBOutlet var confirmButton: UIButton!
    
    var maxNumber: Int = 0
    lazy var arrangeNumbers: [Int] = Array(1...maxNumber)

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    private func setUI() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .baseBlue

        titleLabel.text = "UP DOWN"
        titleLabel.font = UIFont.systemFont(ofSize: 36, weight: .heavy)
        titleLabel.textAlignment = .center

        countTrialLabel.text = "시도 횟수: 0"
        countTrialLabel.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        countTrialLabel.textAlignment = .center

        confirmButton.setTitle("결과 확인하기", for: .normal)
        confirmButton.backgroundColor = .black
        confirmButton.setTitleColor(.white, for: .normal)
    }
}
