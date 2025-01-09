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
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var resetLabel: UILabel!
    @IBOutlet var confirmButton: UIButton!

    var selectedNum: Int = -1 {
        didSet {
            confirmButton.isEnabled = selectedNum != -1 ? true : false
            confirmButton.backgroundColor = selectedNum != -1 ? .black : .darkGray
        }
    }
    
    var countTrialNum: Int = 0 {
        didSet {
            countTrialLabel.text = "시도 횟수: \(countTrialNum)"
        }
    }
    var minNumber: Int = 1
    var maxNumber: Int = 0
    lazy var answerNumber = Int.random(in: 1...maxNumber)
    lazy var arrangeNumbers: [Int] = Array(1...maxNumber)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureListCollectionViewLayout()
        setUI()
        setupGestureRecognizer()
        
        print(answerNumber)
    }
    
    // MARK: Actions
    
    @IBAction func confirmButtonTapped(_ sender: UIButton) {
        print(#function, arrangeNumbers[selectedNum], answerNumber)
        if arrangeNumbers[selectedNum] != answerNumber {
            if arrangeNumbers[selectedNum] > answerNumber {
                maxNumber = arrangeNumbers[selectedNum-1]
                arrangeNumbers.removeAll()
                arrangeNumbers = Array(minNumber...maxNumber)
                resultLabel.text = "DOWN!"
            } else {
                minNumber = arrangeNumbers[selectedNum+1]
                arrangeNumbers.removeAll()
                arrangeNumbers = Array(minNumber...maxNumber)
                resultLabel.text = "UP!"
            }
            countTrialNum += 1
            selectedNum = -1
            collectionView.reloadData()
        } else {
            resultLabel.text = "정답입니다!🎉\n한 번 더 도전하실래요?🥳"
            resetLabel.isHidden = false
            collectionView.isUserInteractionEnabled = false
        }
    }
    
    @objc private func resetLabelClicked(_ tapRecognizer: UITapGestureRecognizer) {
        dismiss(animated: true)
        print(#function)
    }
    
    private func setupGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(resetLabelClicked))
        resetLabel.addGestureRecognizer(tapGestureRecognizer)
        resetLabel.isUserInteractionEnabled = true
    }
    
    // MARK: configure vc
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
        view.backgroundColor = .baseBlue

        titleLabel.text = "UP DOWN"
        titleLabel.font = UIFont.systemFont(ofSize: 36, weight: .heavy)
        titleLabel.textAlignment = .center

        countTrialLabel.text = "시도 횟수: 0"
        countTrialLabel.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        countTrialLabel.textAlignment = .center
        
        resultLabel.text = ""
        resultLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        resultLabel.textAlignment = .center
        
        resetLabel.text = "다시 도전 해보기😙"
        resetLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        resetLabel.textColor = .darkGray
        resetLabel.textAlignment = .center
        resetLabel.isHidden = true
        
        confirmButton.isEnabled = false
        confirmButton.setTitle("결과 확인하기", for: .normal)
        confirmButton.backgroundColor = .darkGray
        confirmButton.setTitleColor(.white, for: .normal)
    }
}

// MARK: UICollectionView Protocol
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? InProgressCollectionViewCell else { return }
        if selectedNum == -1 {
            DispatchQueue.main.async {
                cell.isTriggered(isSelected: false)
            }
            selectedNum = indexPath.item
        } else if selectedNum == indexPath.item {
            cell.isTriggered(isSelected: true)
            selectedNum = -1
        } else {
            print("please unselect cell first", indexPath, selectedNum)
        }
    }
}
