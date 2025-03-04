//
//  CustomLikeButton.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 3/4/25.
//

import UIKit

final class CustomLikeButton: UIButton {
    
    private var productId: String = ""
    
    let selectedImage = UIImage(systemName: "heart.fill")?.withTintColor(.systemRed).withRenderingMode(.alwaysOriginal)
    let unselectedImage = UIImage(systemName: "heart")?.withTintColor(.black).withRenderingMode(.alwaysOriginal)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    func setProductID(_ id: String) {
        self.productId = id
        updateButtonUI()
    }
    
    private func configureButton() {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .clear
        
        config.image = isSelected ? selectedImage : unselectedImage
        configuration = config
        
        isEnabled = true
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        configuration?.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)
    }
    
    @objc
    private func buttonTapped() {
        print("button tapped", productId)
        isSelected.toggle()
        if isSelected {
            // DB에 저장
//            UserDefaultsManager.saveLikedMovie(movieID)
        } else {
            // DB에서 삭제
//            UserDefaultsManager.removeLikedMovie(movieID)
        }
        updateButtonUI()
    }
    
    private func updateButtonUI() {
        var config = configuration
        // Like 여부에 따라 아이콘 이미지 업데이트
//        if UserDefaultsManager.isLikedMovie(movieID) {
//            config?.image = selectedImage
//            isSelected = true
//        } else {
//            config?.image = unselectedImage
//            isSelected = false
//        }
        
        configuration = config
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
