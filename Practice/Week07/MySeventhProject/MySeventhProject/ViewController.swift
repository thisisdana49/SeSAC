//
//  ViewController.swift
//  MySeventhProject
//
//  Created by 조다은 on 2/3/25.
//

import UIKit
import CoreLocation
import MapKit
import SnapKit

class ViewController: UIViewController {
    
    // 1. 위치 매니저 생성: 위치에 관련한 대부분을 담당
    lazy var locationManager = CLLocationManager()
    let locationButton = UIButton()
    let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        //        NetworkManager.shared.getLotto3 { response in
        //            switch response {
        //            case .success(let success):
        //                <#code#>
        //            case .failure(let failure):
        //                <#code#>
        //            }
        //        }
        
        configureView()
        configureLocationManager()
        checkDeviceLocation()
    }
    
    @objc
    func locationButtonClicked() {
        locationManager.startUpdatingLocation()
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
    }
    
    
    func configureLocationManager() {
        // 3. 위치 프로토콜 연결
        locationManager.delegate = self
    }
    
    // Alert: 위치 서비스 -> 허용 Alert
    func checkDeviceLocation() {
        // iOS 시스템의 위치 서비스 활성화 여부 체크
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                // 현재 사용자 위치 권한 상태 확인
                // if 허용된 상태 > 권한 띄울 필요 X
                // if 거부한 상태 > 아이폰 설정 이동
                // if notDetermined > 권한 띄워주기
                
                // 해당 메서드 호출 자체로 Apple이 제공하는 Alert을 띄워주는 것
                DispatchQueue.main.async {
//                    self.locationManager.requestWhenInUseAuthorization()
                    self.checkCurrentLocationAuthorization()
                    print("위치 서비스가 꺼져 있어 위치 권한 요청을 할 수 없습니다.")
                }
            } else {
                print("위치 서비스가 꺼져 있어 위치 권한 요청을 할 수 없습니다.")
            }
        }
    }
    
    // 사용자의 현재 위치 권한 상태 확인
    func checkCurrentLocationAuthorization() {
        let status = locationManager.authorizationStatus
        
        switch status {
        case .notDetermined:
            print("이 권한에서만 권한 문구 띄울 수 있음")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("GPS 기능 X, 부모 권한 등")
        case .denied:
            print("유저가 직접 설정하지 않음, 설정으로 이동하는 얼럿 띄우기")
        case .authorizedWhenInUse:
            print("정상 로직 실행하면 됨. 날씨든.")
            locationManager.startUpdatingLocation()
        default:
            print("예외 상황발생")
        }
    }
    
    func configureView() {
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
        
        view.backgroundColor = .white
        locationButton.backgroundColor = .red
        view.addSubview(locationButton)
        locationButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
        locationButton.addTarget(self, action: #selector(locationButtonClicked), for: .touchUpInside)
    }
    
}


// 2. 위치 프로토콜 선언
extension ViewController: CLLocationManagerDelegate {
    
    // 사용자의 위치를 성공적으로 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.startUpdatingLocation()
        
        print(#function)
        print(locations.last?.coordinate)
        // 위도, 경도
        // 날씨 정보를 호출, 현재 위치로 이동 등과 같은 메서드를 이후로 실행
        
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate)
        } else {
            print("위치 정보를 받아오지 못했을 때의 처리")
        }
        // start를 했다면, 더이상 위치를 받지 않아도 되는 시점에 stop을 해주어야 함.
        locationManager.stopUpdatingLocation()
    }
    
    // 사용자의 위치를 성공적으로 가지고 오지 못한 경우
    // e.g. 사용자가 허용하지 않았을 때 / 자녀 보호 기능 등
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(#function)
    }
    
    // 실행이 되는 시점
    // 사용자의 권한 상태가 변경될 때 & locationManager 인스턴스가 생성이 될 때!!
    // e.g. 허용했었지만 시스템 설정에서 허용하지 않음으로 바꾸는 경우
    // iOS 14+
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkDeviceLocation()
    }
    
    // iOS 14 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
    
}
