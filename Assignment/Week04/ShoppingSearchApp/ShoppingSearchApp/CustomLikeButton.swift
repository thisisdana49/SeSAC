//
//  CustomLikeButton.swift
//  ShoppingSearchApp
//
//  Created by 조다은 on 3/4/25.
//

import UIKit
import RealmSwift

final class CustomLikeButton: UIButton {
    
    let realm = try! Realm()
    private var product: Product!
    
    let selectedImage = UIImage(systemName: "heart.fill")?.withTintColor(.systemRed).withRenderingMode(.alwaysOriginal)
    let unselectedImage = UIImage(systemName: "heart")?.withTintColor(.black).withRenderingMode(.alwaysOriginal)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    func setProductInfo(with product: Product) {
        self.product = product
        updateButtonUI()
    }
    
    private func configureButton() {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .clear
        
        switch state {
        case .selected:
            config.image = selectedImage
        case .normal:
            config.image = unselectedImage
        default:
            config.image = unselectedImage
        }
        
        configuration = config
        
        isEnabled = true
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        changesSelectionAsPrimaryAction = true
        configuration?.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 16, weight: .semibold)
    }
    
    @objc
    private func buttonTapped() {
        print("button tapped", product.productId, isSelected)
//        isSelected.toggle()
        // DB에 저장
        if !isSelected {
            do {
                try realm.write {
                    let data = LikeListTable(productId: product.productId,
                                             title: product.title,
                                             mallName: product.mallName,
                                             image: product.image,
                                             lprice: product.lprice,
                                             like: true)
                    realm.add(data)
                }
            } catch {
                print("렘에 저장이 실패한 경우")
            }
//            UserDefaultsManager.saveLikedMovie(movieID)
        } else {
            // DB에서 삭제
            do {
                try realm.write {
                    let data = realm.objects(LikeListTable.self)
                        .filter { [weak self] in
                            $0.productId == self?.product.productId }
                    realm.delete(data)
                }
            } catch {
                print("렘 데이터 삭제")
            }
//            UserDefaultsManager.removeLikedMovie(movieID)
        }
        updateButtonUI()
    }
    
    private func updateButtonUI() {
        // Like 여부에 따라 아이콘 이미지 업데이트
        var isSelectedProduct = realm.objects(LikeListTable.self).filter { [weak self] in
            $0.productId == self?.product.productId
        }.count > 0
        isSelected = isSelectedProduct

        var config = configuration
        config?.image = isSelectedProduct ? selectedImage : unselectedImage
        configuration = config
        
        setNeedsLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
