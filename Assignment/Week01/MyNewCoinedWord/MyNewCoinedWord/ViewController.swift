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
        "JMT": "존맛탱을 영어로, 다시 이니셜만 남긴 고도화 된 표현. 번외로 JMTGR(존맛탱구리)가 있다.",
        "TMT": "투머치토커의 줄임말. 말이 과하게 많은 사람을 대상으로 하는 표현이다.",
        "맛꿀마": "JMT와 같이 맛있음을 표현하는 말. 경상도 사투리가 모티브이다.",
        "웅니": "언니를 아이처럼 귀엽게 부르는 말",
        "가나디": "강아지를 혀 짧은 발음으로 귀엽게 부르는 말. 캐릭터의 이름이기도 하다.",
        "쌈뽕하다": "멋진 것, 혹은 마음에 드는 것을 의미하는 긍정의 표현. 주로 ‘쌈@뽕하다’와 같이 @와 함께 쓰인다.",
        "럭키비키": "걸그룹 아이브 ‘장원영’이 시작한 유행어로, 운이 좋음을 표현한다.",
        "복복복": "사랑스럽게 쓰다듬을 때 나는 의성어",
    ]

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var labelView: UIView!
    @IBOutlet var titleLabelView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }

    // SearchBar Protocol
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchInputText(searchBar: searchBar)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchInputText(searchBar: searchBar)
    }

    func searchInputText(searchBar: UISearchBar) {
        guard let searchText = searchBar.text?.uppercased(), !searchText.isEmpty
        else {
            titleLabel.text = "✅  검색 결과가 없습니다."
            contentTextView.text = "목록 중 하나를 클릭해볼까요?"
            return
        }

        if let meaning = newCoinedWordArray[searchText] {
            titleLabel.text = "✅  \(searchText)"
            contentTextView.text = meaning
        } else {
            titleLabel.text = "✅  '\(searchText)'에 대한 검색 결과가 없습니다."
            contentTextView.text = "목록 중 하나를 선택해볼까요?"
        }
    }

    @IBAction func tapGestureRecognized(_ sender: Any) {
        view.endEditing(true)
    }

    fileprivate func getRandomKeys() -> [String] {
        var keys: Set<String> = []

        while keys.count < 4 {
            if let key = newCoinedWordArray.keys.randomElement() {
                keys.insert(key)
            }
        }

        return Array(keys).sorted()
    }

    @objc func wordLabelTapped(_ sender: UITapGestureRecognizer) {
        guard let tappedLabel = sender.view as? UILabel,
            let word = tappedLabel.text
        else { return }

        let meaning = newCoinedWordArray[word]
        titleLabel.text = "✅  \(word)"
        contentTextView.text = meaning
    }

    fileprivate func setUI() {
        setSearchBarUI()
        setKeywordLabelUI()
        setTextViewUI()
        setLabelViewUI()
    }

    fileprivate func setSearchBarUI() {
        if let textField = searchBar.value(forKey: "searchField")
            as? UITextField
        {

            textField.backgroundColor = .accent
            textField.textColor = .gray

            if let leftView = textField.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(
                    .alwaysTemplate)
                leftView.tintColor = .gray
            }
        }
    }

    fileprivate func setKeywordLabelUI() {
        titleLabelView.backgroundColor = .accent
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.text = "✅  궁금한 신조어를 검색 해보세요!"
    }

    fileprivate func setTextViewUI() {
        contentTextView.font = .systemFont(ofSize: 18, weight: .regular)
        contentTextView.text = "뭐라고 검색할지 고민된다면 추천 검색어 중에 하나를 골라보세요😉"
    }

    fileprivate func setLabelViewUI() {
        labelView.subviews.forEach { $0.removeFromSuperview() }

        let randomKeys = getRandomKeys()
        print("random keys: \(randomKeys)")

        var xOffset: CGFloat = 0
        let labelHeight: CGFloat = 30
        let labelSpacing: CGFloat = 10

        for key in randomKeys {
            let wordLabel = UILabel()
            wordLabel.text = key
            wordLabel.textAlignment = .center
            wordLabel.font = UIFont.systemFont(ofSize: 15)
            wordLabel.textColor = .black
            wordLabel.backgroundColor = .accent
            wordLabel.layer.masksToBounds = true
            wordLabel.layer.cornerRadius = 5

            let labelWidth = wordLabel.intrinsicContentSize.width + 20
            wordLabel.frame = CGRect(
                x: xOffset, y: 10, width: labelWidth, height: labelHeight)

            let tapGesture = UITapGestureRecognizer(
                target: self, action: #selector(wordLabelTapped(_:)))
            wordLabel.isUserInteractionEnabled = true
            wordLabel.addGestureRecognizer(tapGesture)
            labelView.addSubview(wordLabel)
            xOffset += labelWidth + labelSpacing
        }
    }

}
