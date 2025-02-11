//
//  NasaViewController.swift
//  MySeventhProject
//
//  Created by 조다은 on 2/11/25.
//

import UIKit

enum Nasa: String, CaseIterable {
    // 열거형은 초기화가 되지 않기 때문에.
    static let baseURL = "https://apod.nasa.gov/apod/image/"
    
    case one = "2308/sombrero_spitzer_3000.jpg"
    case two = "2212/NGC1365-CDK24-CDK17.jpg"
    case three = "2307/M64Hubble.jpg"
    case four = "2306/BeyondEarth_Unknown_3000.jpg"
    case five = "2307/NGC6559_Block_1311.jpg"
    case six = "2304/OlympusMons_MarsExpress_6000.jpg"
    case seven = "2305/pia23122c-16.jpg"
    case eight = "2308/SunMonster_Wenz_960.jpg"
    case nine = "2307/AldrinVisor_Apollo11_4096.jpg"
    
    static var photo: URL {
        return URL(string: Nasa.baseURL + Nasa.allCases.randomElement()!.rawValue)!
    }
}

class NasaViewController: UIViewController {
    
    let requestButton = UIButton()
    let progressLabel = UILabel()
    let nasaImageView = UIImageView()
    
    var total: Double = 0
    var buffer: Data? {
        didSet {
            print("Buffer", buffer)
            let result = Double(buffer?.count ?? 0) / total
            progressLabel.text = "\(result * 100) / 100"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
        
//        buffer = Data() 처음에만 init 되고 버튼을 재선택 했을 때 비워지지 않아 적절하지 X
    }
    
    func configureHierarchy() {
        view.addSubview(requestButton)
        view.addSubview(progressLabel)
        view.addSubview(nasaImageView)
    }
    
    func configureLayout() {
        requestButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        progressLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(requestButton.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        nasaImageView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(progressLabel.snp.bottom).offset(20)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        requestButton.backgroundColor = .blue
        progressLabel.backgroundColor = .white
        progressLabel.text = "100% 중 35.5% 완료"
        nasaImageView.backgroundColor = .systemBrown
        requestButton.addTarget(self, action: #selector(requestButtonClicked), for: .touchUpInside)
    }
    
    @objc
    private func requestButtonClicked() {
        print(#function)
        buffer = Data()
        callRequest()
    }
    
    private func callRequest() {
        let request = URLRequest(url: Nasa.photo, timeoutInterval: 5)
        let configuration = URLSession(
            configuration: .default,
            delegate: self,
            delegateQueue: .main)
        
        configuration.dataTask(with: request).resume()
    }
}

extension NasaViewController: URLSessionDataDelegate {
    
    // 서버에서 최초로 응답을 받은 경우에 호출
    // : 상태코드
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        print("===1===", response)
        // 상태 코드가 성공일 때, contentLength
        if let response = response as? HTTPURLResponse,
           (200...299).contains(response.statusCode) {
            
            // 총 데이터의 양 얻기
            guard let contentLength = response.value(forHTTPHeaderField: "Content-Length") else {
                return .cancel
            }
            
            total = Double(contentLength)!
            
            return .allow
        } else {
            return .cancel
        }
    }
    // 서버에서 데이터를 받아올 때마다 반복적으로 호출
    // : 실질적인 데이터!!
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("===2===", data)
        buffer?.append(data)
        
    }
    // 응답이 완료가 되었을 때 호출
    // 실패든 성공이든 완료
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        print("===3===", error)
        if let error = error {
            progressLabel.text = "네트워크에 문제가 있습니다."
        } else {
            guard let buffer = buffer else {
                print("buffer 없음")
                return
            }
            
            let image = UIImage(data: buffer)
            nasaImageView.image = image
        }
    }
    
}
