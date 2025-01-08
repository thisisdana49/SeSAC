//
//  ViewController.swift
//  TastyMap
//
//  Created by 조다은 on 1/8/25.
//

import UIKit
import MapKit

class MainViewController: UIViewController {
    @IBOutlet var categoryScrollView: UIView!
    @IBOutlet var mapView: MKMapView!
    let categories = ["전체 보기", "한식", "양식", "일식", "중식", "분식", "비건", "카페"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

    private func setUI() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false

        for category in categories {
            let button = UIButton()
            button.setAttributedTitle(NSAttributedString(string: category, attributes: [.foregroundColor: UIColor.darkGray, .font: UIFont.systemFont(ofSize: 15, weight: .semibold)]), for: .normal)
            button.setTitleColor(.darkGray, for: .normal)
            button.backgroundColor = .white
            button.layer.cornerRadius = 15
            button.heightAnchor.constraint(equalToConstant: 30).isActive = true
            stackView.addArrangedSubview(button)
        }

        categoryScrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: categoryScrollView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: categoryScrollView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: categoryScrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: categoryScrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: categoryScrollView.heightAnchor)
        ])
    }

}

