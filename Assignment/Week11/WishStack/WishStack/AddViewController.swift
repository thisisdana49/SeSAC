//
//  AddViewController.swift
//  WishStack
//
//  Created by 조다은 on 3/5/25.
//

import UIKit
import RealmSwift
import SnapKit

final class AddViewController: UIViewController {
     
    let photoImageView = UIImageView()
    let addButton = UIButton()
    let titleTextField = UITextField()
    let noteTextField = UITextField()

    var id: ObjectId!
    let repository: WishRepository = WishTableRepository()
    let folderRepository: FolderRepository = FolderTableRepository()
       
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureView()
        configureConstraints()
    }
    
    private func configureHierarchy() {
        view.backgroundColor = .white
        view.addSubview(photoImageView)
        view.addSubview(addButton)
        view.addSubview(titleTextField)
        view.addSubview(noteTextField)
    }
    
    @objc func addButtonClicked() {
        print(#function)
    }
 
    @objc func saveButtonClicked() {
        print(#function)

        let folder = folderRepository.fetchAll().where { $0.id == id }.first!
//        let wish = Wish(title: titleTextField.text ?? "제목 로드 오류",
//                        note: noteTextField.text ?? "메모 로드 오류")
        
//        repository.createItemInFolder(folder: folder, wish: wish)
        
        navigationController?.popViewController(animated: true)
    }
    
    private func configureView() {
        
        titleTextField.placeholder = "제목을 입력해보세요"
        noteTextField.placeholder = "메모를 입력해보세요"
        
        addButton.backgroundColor = .black
        addButton.setTitleColor(.white, for: .normal)
        addButton.setTitle("이미지 추가", for: .normal)
        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        
        photoImageView.backgroundColor = .lightGray
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
    }
    
     func configureConstraints() {
         photoImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        addButton.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalTo(view)
            make.top.equalTo(photoImageView.snp.bottom).offset(20)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalTo(view)
            make.top.equalTo(addButton.snp.bottom).offset(20)
        }
        
         noteTextField.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(48)
            make.centerX.equalTo(view)
            make.top.equalTo(titleTextField.snp.bottom).offset(20)
        }
    }
    
}
