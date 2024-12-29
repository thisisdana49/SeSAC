//
//  ViewController.swift
//  MyNewCoinedWord
//
//  Created by 조다은 on 12/29/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        searchBar.tintColor = .accent
        
        titleLabel.backgroundColor = .accent
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.text = #"✅ 궁금한 신조어를 검색 해보세요!"#
        contentTextView.font = .systemFont(ofSize: 18, weight: .regular)
        contentTextView.text = "신조어의 뜻을 알려드립니다 :)"
    }
}

