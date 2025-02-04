//
//  PhotoViewController.swift
//  WeatherMap
//
//  Created by 조다은 on 2/4/25.
//

import UIKit
import PhotosUI

class PhotoViewController: UIViewController {
    
    var passDelegate: GalleryImagePassDelegate?
    var photos: [UIImage] = []
    
    private let photoImageView = UIImageView()
    private lazy var photoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        //        setupConstraints()
        //        setupActions()
    }
    
    @objc
    func addButtonTapped() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 3
        configuration.mode = .default
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "Select Photos"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonTapped))
        
        
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        photoCollectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.id)
        photoCollectionView.collectionViewLayout = setLayout()
        
        view.addSubview(photoCollectionView)
        photoCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setLayout() -> UICollectionViewFlowLayout {
        let spacing: CGFloat = 4
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - (spacing * 2)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.itemSize = CGSize(width: cellWidth / 3, height: cellWidth / 3)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }
}


extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.id, for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        let photo = photos[indexPath.row]
        
        cell.imageView.image = photo
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.item]
        passDelegate?.didSelectImagesInGallery(photo)
        dismiss(animated: true)
    }
    
}


extension PhotoViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        results.forEach { result in
            if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                result.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                    if let castedImage = image as? UIImage {
                        self.photos.append(castedImage)
                    }
                    DispatchQueue.main.async {
                        self.photoCollectionView.reloadData()
                    }
                }
            }
        }
        dismiss(animated: true)
    }
    
}
