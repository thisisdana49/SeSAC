//
//  ImageZoomViewViewController.swift
//  MyFourthProject
//
//  Created by 조다은 on 1/17/25.
//

import UIKit
import SnapKit

class ImageZoomViewViewController: UIViewController {
    
    private lazy var scrollView = {
        let view = UIScrollView()
        view.backgroundColor = .systemBlue
        view.backgroundColor = .systemGreen
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.bouncesVertically = false
        view.maximumZoomScale = 5
        view.minimumZoomScale = 1
        view.delegate = self
        
        return view
    }()
    
    // 즉시 실행 함수
    private let imageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .yellow
        view.image = UIImage(systemName: "star")
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        scrollView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.center.equalTo(view)
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(scrollView)
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapGesture))
        tap.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tap)
    }
    
    // 1배율 -> 2배율
    // 그 외 -> 기존대로
    @objc
    func doubleTapGesture() {
        if scrollView.zoomScale == 1 {
            scrollView.setZoomScale(3, animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
}

// MARK:
extension ImageZoomViewViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
}
