//
//  ViewController.swift
//  TastyMap
//
//  Created by 조다은 on 1/8/25.
//

import UIKit
import MapKit

class MainViewController: UIViewController, MKMapViewDelegate {
    var restaurants = RestaurantList().restaurantArray
    var filteredRestaurants: [Restaurant] = []
    let categories = ["전체 보기", "한식🍚", "양식🍕", "일식🍣", "중식🍜", "분식🍢", "비건🌿", "카페☕️"]
    var annotations: [MKPointAnnotation] = [] {
        didSet {
            print("annotation did set")
            mapView.removeAnnotations(oldValue)
            for annotation in annotations {
                mapView.addAnnotation(annotation)
            }
        }
    }
    
    @IBOutlet var categoryScrollView: UIView!
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        setUI()
        configurationMapView()
    }

    private func configurationMapView() {
        for restaurant in restaurants {
            let center = CLLocationCoordinate2D(latitude: 37.6537943, longitude: 127.0480527)
            mapView.region = MKCoordinateRegion(center: center, latitudinalMeters: 700, longitudinalMeters: 700)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)
            annotation.title = "\(restaurant.name)"
            annotations.append(annotation)
        }
    }
    
    private func showAnnotations() {
        var newAnnotations: [MKPointAnnotation] = []
        for restaurant in filteredRestaurants {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)
            annotation.title = "\(restaurant.name)"
            newAnnotations.append(annotation)
        }
        annotations = newAnnotations
    }

    @objc
    func categoryButtonTapped(_ sender: UIButton) {
        print(#function, sender.tag)
        filteredRestaurants.removeAll()
        switch sender.tag {
        case 0:
            filteredRestaurants = restaurants
        case 1:
            filteredRestaurants = restaurants.filter { $0.category == "한식" }
        case 2:
            filteredRestaurants = restaurants.filter { $0.category == "양식" }
        case 3:
            filteredRestaurants = restaurants.filter { $0.category == "일식" }
        case 4:
            filteredRestaurants = restaurants.filter { $0.category == "중식" }
        case 5:
            filteredRestaurants = restaurants.filter { $0.category == "분식" }
        case 6:
            filteredRestaurants = restaurants.filter { $0.category == "비건" }
        case 7:
            filteredRestaurants = restaurants.filter { $0.category == "카페" }
        default: break
        }
        showAnnotations()
    }
    
    private func setUI() {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for index in 0..<categories.count {
            let button = UIButton()
            button.setAttributedTitle(NSAttributedString(string: categories[index], attributes: [.foregroundColor: UIColor.darkGray, .font: UIFont.systemFont(ofSize: 15, weight: .semibold)]), for: .normal)
            button.setTitleColor(.darkGray, for: .normal)
            button.backgroundColor = .white
            button.layer.cornerRadius = 15
            button.heightAnchor.constraint(equalToConstant: 30).isActive = true
            button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
            
            button.tag = index
            button.addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
        }

        categoryScrollView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: categoryScrollView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: categoryScrollView.trailingAnchor, constant: -10),
            stackView.topAnchor.constraint(equalTo: categoryScrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: categoryScrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: categoryScrollView.heightAnchor)
        ])
    }

}

