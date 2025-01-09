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
    
    var countTrialNum: Int = 0
    var maxNumber: Int = 0 {
        didSet {
            answerNumber = Int.random(in: 1...maxNumber)
        }
    }
    var answerNumber: Int = 0
    lazy var arrangeNumbers: [Int] = Array(1...maxNumber)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureListCollectionViewLayout()
        setUI()
    }

    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let id = InProgressCollectionViewCell.identifier
        let xib = UINib(nibName: id, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: id)
    }
    
    private func configureListCollectionViewLayout() {
        let sectionInset: CGFloat = 16
        let cellSpacing: CGFloat = 10
        
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = (deviceWidth - (sectionInset * 2) - (cellSpacing * 5))
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSizeMake(cellWidth / 6, cellWidth / 6)
        layout.sectionInset = UIEdgeInsets(top: sectionInset/2, left: sectionInset, bottom: sectionInset/2, right: sectionInset)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .baseBlue
        collectionView.collectionViewLayout = layout
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
        
        resetButton.text = "다시 시작하기"
        resetButton.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        resetButton.textColor = .darkGray
        resetButton.textAlignment = .center

        confirmButton.setTitle("결과 확인하기", for: .normal)
        confirmButton.backgroundColor = .black
        confirmButton.setTitleColor(.white, for: .normal)
    }
}

// MARK:UICollectionView Protocol
extension InProgressViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrangeNumbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InProgressCollectionViewCell.identifier, for: indexPath) as? InProgressCollectionViewCell else { return UICollectionViewCell() }
        
        DispatchQueue.main.async {
            cell.backgroundColor = .baseBlue
            cell.baseView.layer.cornerRadius = cell.baseView.frame.width / 2
        }
        cell.contentLabel.text = "\(arrangeNumbers[indexPath.item])"
        
        return cell
    }

}
