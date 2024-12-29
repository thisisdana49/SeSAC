//
//  ViewController.swift
//  MyNewCoinedWord
//
//  Created by 조다은 on 12/29/24.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    let newCoinedWordArray: [String: String] = [
        "중꺾그마": "‘중요한 건 꺾였는데도 그냥 하는 마음’의 줄임말. ‘중꺾마’의 다음 단계이다.",
        "맛꿀마": "JMT와 같이 맛있음을 표현하는 말. 경상도 사투리가 모티브이다.",
        "웅니": "언니를 아이처럼 귀엽게 부르는 말",
        "가나디": "강아지를 혀 짧은 발음으로 귀엽게 부르는 말. 캐릭터의 이름이기도 하다.",
        "쌈뽕하다": "멋진 것, 혹은 마음에 드는 것을 의미하는 긍정의 표현. 주로 ‘쌈@뽕하다’와 같이 @와 함께 쓰인다.",
        "럭키비키": "걸그룹 아이브 ‘장원영’이 시작한 유행어로, 운이 좋음을 표현한다.",
        "복복복": "사랑스럽게 쓰다듬을 때 나는 의성어",
    ]

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    // SearchBar Protocol
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        newCoinedWordArray.keys.forEach { key in
            if key.contains(searchBar.text!) {
                if key.contains(searchBar.text!) {
                    titleLabel.text = key
                    contentTextView.text = newCoinedWordArray[key]
                }
            }
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        newCoinedWordArray.keys.forEach { key in
            if key.contains(searchBar.text!) {
                if key.contains(searchBar.text!) {
                    titleLabel.text = key
                    contentTextView.text = newCoinedWordArray[key]
                }
            }
        }
    }

    @IBAction func tapGestureRecognized(_ sender: Any) {
        view.endEditing(true)
    }

    func setUI() {
        searchBar.tintColor = .accent

        setLabelUI()
        setTextViewUI()
    }

    func setLabelUI() {
        titleLabel.backgroundColor = .accent
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.text = #"궁금한 신조어를 검색 해보세요!"#
    }

    func setTextViewUI() {
        contentTextView.font = .systemFont(ofSize: 18, weight: .regular)
        contentTextView.text = "신조어의 뜻을 알려드립니다 :)"
    }
}
