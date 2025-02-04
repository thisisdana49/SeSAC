//
//  WeatherViewController.swift
//  SeSACSevenWeek
//
//  Created by Jack on 2/3/25.
//

import UIKit
import CoreLocation
import MapKit
import Alamofire
import SnapKit

class WeatherViewController: UIViewController {
    
    var weather: Weather?
    
    lazy var locationManager = CLLocationManager()
    var currentAnnotation = MKPointAnnotation()
    var campusLocation: CLLocationCoordinate2D?
    private let mapView: MKMapView = {
        let view = MKMapView()
        return view
    }()
    
    private let weatherInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.text = "날씨 정보를 불러오는 중..."
        return label
    }()
    
    private let currentLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "location.fill"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .systemBlue
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4
        return button
    }()
    
    private let refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .systemBlue
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4
        return button
    }()
    
    private let imagePickerButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Load Photo"
        config.image = UIImage(named:  "photo")
        let button = UIButton(configuration: config)
        
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLocationManager()
        setupUI()
        setupConstraints()
        setupActions()
        checkDeviceLocationAuthorization()
    }
    
    private func fetchCurrentWeather(coordinate: CLLocationCoordinate2D) {
        NetworkManager.shared.fetchData(
            apiRequest: .currentWeather(lat: coordinate.latitude, lon: coordinate.longitude),
            requestType: Weather.self) { response in
                switch response {
                case .success(let value):
                    self.weather = value
//                    print(self.weather)
                    
                    DispatchQueue.main.async {
                        guard let dateStamp = self.weather?.dt,
                              let temp = self.weather?.main.temp,
                              let windSpeed = self.weather?.wind.speed,
                              let humidity = self.weather?.main.humidity else {
                            self.weatherInfoLabel.text = "현재 날씨 정보를 받아올 수 없습니다. 다시 시도해 주세요."
                            return
                        }
                        let date = Date(timeIntervalSince1970: TimeInterval(dateStamp))
                        let formattedDate = date.toFormattedString()
                        self.weatherInfoLabel.text = "\(formattedDate)\n현재온도: \(temp)℃\n풍속: \(windSpeed)m/s\n습도\(humidity)%"
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        [mapView, weatherInfoLabel, currentLocationButton, refreshButton, imagePickerButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.snp.height).multipliedBy(0.5)
        }
        
        weatherInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        currentLocationButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.width.height.equalTo(50)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.width.height.equalTo(50)
        }
        
        imagePickerButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }
    }
    
    private func setupActions() {
        currentLocationButton.addTarget(self, action: #selector(currentLocationButtonTapped), for: .touchUpInside)
        refreshButton.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
        imagePickerButton.addTarget(self, action: #selector(pickerButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc
    private func currentLocationButtonTapped() {
        locationManager.startUpdatingLocation()
    }
    
    @objc
    private func refreshButtonTapped() {
        print(#function)
        weatherInfoLabel.text = "날씨 정보를 다시 불러오는 중..."
        locationManager.startUpdatingLocation()
    }
    
    @objc
    private func pickerButtonTapped() {
        let photoVC = PhotoViewController()
        let navVC = UINavigationController(rootViewController: photoVC)
        present(navVC, animated: true)
    }
}


extension WeatherViewController {
    
    func configureLocationManager() {
        locationManager.delegate = self
        campusLocation = CLLocationCoordinate2D(latitude: 37.654379, longitude: 127.049871)
    }
    
    // 1) 사용자에게 권한 요청을 하기 위해, iOS 위치 서비스 활성화 여부 체크
    func checkDeviceLocationAuthorization() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                // 현재 사용자의 위치 권한 상태 확인
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authorization = self.locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                }
            } else {
                print("위치 서비스가 꺼져 있어 위치 권한 요청을 할 수 없어요.")
            }
        }
    }
    
    // 2) 사용자 위치 권한 상태 확인 후, 권한 요청
    func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        print(#function)
        switch status {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            setRegionAndAnnotation(center: campusLocation!)
            fetchCurrentWeather(coordinate: campusLocation!)
            print(#function, "권한 줄 수 있도록 설정으로 유도")
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default: print("Error")
        }
    }
    
    func showLocationSettingAlert() {
        let alert = UIAlertController(title: "위치 정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요", preferredStyle: .alert)
        
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let setting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(setting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(goSetting)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        mapView.setRegion(region, animated: true)
        currentAnnotation.coordinate = CLLocationCoordinate2D(latitude: center.latitude, longitude: center.longitude)
        DispatchQueue.main.async {
            self.mapView.addAnnotation(self.currentAnnotation)
        }
    }
    
}

// MARK: CLLocationManager Delegate
extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        if let coordinate = locations.first?.coordinate {
            setRegionAndAnnotation(center: coordinate)
            fetchCurrentWeather(coordinate: coordinate)
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        if locationManager.authorizationStatus == .denied {
            showLocationSettingAlert()
        } else {
            print(#function, error)
        }
    }
    
    // iOS14++
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkDeviceLocationAuthorization()
    }
    
    // iOS14-
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
    
}
