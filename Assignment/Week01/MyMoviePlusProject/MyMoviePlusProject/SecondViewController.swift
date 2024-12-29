//
//  FirstTabViewController.swift
//  MyMoviePlusProject
//
//  Created by 조다은 on 12/25/24.
//

import UIKit

class SecondViewController
: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var buttonArray: [UIButton]!
    
    @IBOutlet var contentsLabel: UILabel!
    @IBOutlet var descLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        if sender.isSelected {
            sender.backgroundColor = .white
            sender.setTitleColor(.black, for: .normal)
            for index in buttonArray {
                if index != sender {
                    index.isSelected = false
                    index.backgroundColor = .black
                    index.setTitleColor(.white, for: .normal)
                }
            }
        } else {
            sender.backgroundColor = .black
            sender.setTitleColor(.white, for: .normal)
        }
        
        switch sender {
            case buttonArray[0]:
            contentsLabel.text = "공개 예정"
            descLabel.text = "곧 공개 될 콘텐츠를 소개합니다"
        case buttonArray[1]:
            contentsLabel.text = "모두의 인기 콘텐츠"
            descLabel.text = "남녀노소 즐길 수 있는 콘텐츠를 소개합니다"
        case buttonArray[2]:
            contentsLabel.text = "TOP 10 시리즈"
            descLabel.text = "최근 핫한 TOP 10 시리즈를 소개합니다"
        default:
            self.contentsLabel.text = "이런! 찾으시는 작품이 없습니다."
            self.descLabel.text = "다른 영화, 시리즈, 배우, 감독 또는 장르를 검색해 보세요."
        }
    }
    
    fileprivate func setUI() {
        buttonTapped(buttonArray[0])
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            
            textField.backgroundColor = .darkGray
            textField.textColor = .lightGray
            
            if let leftView = textField.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = .lightGray
            }
        }
    }
}
