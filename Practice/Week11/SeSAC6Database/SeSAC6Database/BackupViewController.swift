//
//  BackupViewController.swift
//  SeSAC6Database
//
//  Created by 조다은 on 3/10/25.
//

import UIKit
import SnapKit
import Zip

/*
 TODO:
 - 사진 데이터는 백업되고 있지 않음.
 - 백업 압축 파일에 default.realm만 있는 상황
 - 폴더 기반으로 이미지 저장하면 효율적
 
 - 백업 파일명, 해제 시 내부 점검
 - 복구 후 압축파일 제거 & 잘못된 파일도 제거
 - 현재 JackArchive.zip의 임의의 리터럴값임
 - 대개 앱이름_날짜_시간 과 같이 명세하는 방식을 사용함
 
 - 백업본 A. 근데 까먹고 새로 설치한 앱에 데이터를 많이 쌓아둔 상황.
 - 그리고 나중에 알게 되고, 또 백업을 만들면 -> 덮어 써짐
 - default.realm -> 무조건! 앱을 처음 실행해야만 동작.
 -> 그래서 json으로 백업/복구하는 방식: 테이블에 구애 받지 않고, 복구 시 바로 적용할 수 있는 등의 장점.
 
 - 잘못된 정보 중 하나) 도큐먼트나 파일앱을 다룰 때, info.plist에서 어떤 값을 설정해라?
 -> 필요한 권한만을 주어야 함.
 그리고 때에 따라,
 1) default.realm -> 라이브러리에 저장하거나,
 2) default.realm에 비밀번호를 걸기도 함
 */

class BackupViewController: UIViewController {
    
    let backupButton = {
        let view = UIButton()
        view.backgroundColor = .systemOrange
        return view
    }()
    
    let restoreButton = {
        let view = UIButton()
        view.backgroundColor = .systemGreen
        return view
    }()
    
    let backupTableView = {
        let view = UITableView()
        view.rowHeight = 50
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setConstraints()
        view.backgroundColor = .white
        backupTableView.delegate = self
        backupTableView.dataSource = self
    }
    
    func configure() {
        view.addSubview(backupTableView)
        view.addSubview(backupButton)
        view.addSubview(restoreButton)
        backupButton.addTarget(self, action: #selector(backupButtonTapped), for: .touchUpInside)
        restoreButton.addTarget(self, action: #selector(restoreButtonTapped), for: .touchUpInside)
    }
    
    func setConstraints() {
        backupTableView.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
        }
        
        backupButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.top.leading.equalTo(view.safeAreaLayoutGuide)
        }
        
        restoreButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.top.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func documentDirectoryPath() -> URL? {
        guard let documentDirectory = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return nil }
        return documentDirectory
    }
    
    @objc
    func backupButtonTapped() {
        print(#function)
        // 도큐먼트 위치 조회
        guard let path = documentDirectoryPath() else {
            print("도큐먼트 위치에 오류가 있습니다")
            return
        }
        
        // 백업할 파일을 조회
        let realmFile = path.appendingPathComponent("default.realm")
        
        // 백업할 파일 경료가 유효한지 확인
        guard FileManager.default.fileExists(atPath: realmFile.path()) else {
            print("백업할 파일이 없습니다")   // 앱 다운 후 바로 백업 버튼을 누른다면? -> 이런 케이스에 대한 처리도 필요할 것!!
            return
        }
        
        // 압축하고자 하는 파일을 urlPath에 추가
        var urlPaths = [URL]()      // 이미지도 경로에 추가해야함.(혼자 과제)
        urlPaths.append(realmFile)
        
        // 백업할 파일을 압축 파일로 묶는 작업
        do {
            let filePath = try Zip.quickZipFiles(urlPaths, fileName: "JackArchive") { progress in
                print(progress)
            }
            print("Zip location", filePath)
        } catch {
            print("압축을 실패했어요")
            // 기기 용량 부족, 화면 dimiss, 다른 탭 전환, 백그라운드 등 다양한 원인
        }
    }
    
    @objc
    func restoreButtonTapped() {
        let document = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        document.delegate = self
        document.allowsMultipleSelection = false
        present(document, animated: true)
    }
    
}

extension BackupViewController: UIDocumentPickerDelegate {
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        // 파일앱의 경로(앱의 경로와 상관 X)
        guard let selectedFileURL = urls.first else {
            print("선택한 파일에 오류가 있습니다")
            return
        }
        
        // 파일앱 데이터 -> 도큐먼트 폴더로 넣기
        guard let path = documentDirectoryPath() else {
            print("도큐먼트 위치에 오류가 있습니다")
            return
        }
        
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        // 압축 파일을 저장하고, 풀면 끝!
        // 이미 경로에 파일이 존재하는지 확인 -> 압축을 바로 해제 (때에 따라, 이미 존재하더라도 그냥 덮어쓰는 경우도 있음. 로직은 천차만별)
        // 경로에 파일이 존재하지 안않는다면는다면 -> 파일 앱의 압축 파일 -> 도큐먼트 경로로 복사 -> 도큐먼트에 저장 -> 저장된 압축 파일을 해제
        if FileManager.default.fileExists(atPath: sandboxFileURL.path()) {
            let fileURL = path.appendingPathComponent("JackArchive.zip")
            
            do {
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil) { progress in
                    print(progress)
                } fileOutputHandler: { unzippedFile in
                    print("압축 해제 완료", unzippedFile)
                }
            } catch {
                print("압축 해제 실패")
            }
        } else {
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                
                let fileURL = path.appendingPathComponent("JackArchive.zip")
                
                do {
                    try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil) { progress in
                        print(progress)
                    } fileOutputHandler: { unzippedFile in
                        print("압축 해제 완료", unzippedFile)
                    }
                } catch {
                    print("압축 해제 실패")
                }
            } catch {
                print("파일 copy 실패")
            }
        }
    }
    
}

extension BackupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func fetchZipList() -> [String] {
        // 도큐먼트 위치 조회
        guard let path = documentDirectoryPath() else {
            print("도큐먼트 위치에 오류가 있습니다")
            return []
        }
        
        var list: [String] = []
            
        do {
            let docs = try FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
//            dump(docs)
            
            let zip = docs.filter { $0.pathExtension == "zip" }
//            dump("zip", zip)
            list = zip.map { $0.lastPathComponent }
            
        } catch {
            print("목록 조회 실패")
        }
                
        return list
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchZipList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = fetchZipList()[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // JackArchive.zip 구성이 되어있는 파일을 외부로 보내기
        guard let path = documentDirectoryPath() else {
            print("도큐먼트 위치에 오류가 있습니다")
            return
        }
        
        let backupFileURL = path.appendingPathComponent(fetchZipList()[indexPath.row])
        
        let vc = UIActivityViewController(activityItems: [backupFileURL], applicationActivities: nil)
        present(vc, animated: true)
    }
    
}
