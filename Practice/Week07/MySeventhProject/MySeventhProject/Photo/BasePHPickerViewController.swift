//
//  BasePHPickerViewController.swift
//  MySeventhProject
//
//  Created by 조다은 on 2/4/25.
//

import UIKit
import PhotosUI
import SnapKit

class BasePHPickerViewController: UIViewController {

    let pickerButton = UIButton()
    let photoImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }

    func configureView() {
        view.backgroundColor = .white
        view.addSubview(photoImageView)
        view.addSubview(pickerButton)

        photoImageView.snp.makeConstraints { make in
            make.size.equalTo(300)
            make.center.equalTo(view.safeAreaLayoutGuide)
        }

        pickerButton.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }

        pickerButton.addTarget(self, action: #selector(pickerButtonTapped), for: .touchUpInside)

        photoImageView.backgroundColor = .gray
        pickerButton.backgroundColor = .blue
    }

    @objc
    func pickerButtonTapped() {
        print(#function)

        var configuration = PHPickerConfiguration()
        configuration.filter = .any(of: [.screenshots, .images])
        configuration.selectionLimit = 3
        configuration.mode = .default
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension BasePHPickerViewController: PHPickerViewControllerDelegate {

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        print(#function, Thread.isMainThread)
        if let itemProvider = results.first?.itemProvider {
            print("1", Thread.isMainThread)
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                print("2", Thread.isMainThread)
                itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                   print("3", Thread.isMainThread)
                   DispatchQueue.main.async {
                       self.photoImageView.image = image as? UIImage
                   }
                }
            }
        }
        dismiss(animated: true)
    }
    
}
