//
//  ImagePickerViewController.swift
//  MySeventhProject
//
//  Created by 조다은 on 2/4/25.
//

import UIKit
import SnapKit

class ImagePickerViewController: UIViewController {

    let pickerButton = UIButton()
    let photoImageView = UIImageView()

    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
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
        present(imagePicker, animated: true)
    }
}

extension ImagePickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        let image = info[UIImagePickerController.InfoKey.originalImage]
        if let result = image as? UIImage {
            photoImageView.image = result
        } else {
            print("Error occured")
        }
        dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
    }
    
}
