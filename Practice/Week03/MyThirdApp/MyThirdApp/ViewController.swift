//
//  ViewController.swift
//  MyThirdApp
//
//  Created by 조다은 on 1/8/25.
//

import UIKit
import MapKit

struct User {
    var name: String
}

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var userTextField: UITextField!
    @IBOutlet var secondTextField: UITextField!
    @IBOutlet var mapView: MKMapView!
    
    let pickerView = UIPickerView()
    
    let list = ["가", "나", "다"]
    let array = [1, 2, 3, 4]
    
    // 특정 객체를 초기화하는 방법은 여러가지
    let users: [User] = [
        User(name: "Kim"),
        User(name: "Choi")
    ]
    
    // 이 방법은 시간이 많이 걸림
    let users2: [User] = [
        .init(name: "kim"),
        .init(name: "choi")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTextField.inputView = pickerView
        userTextField.tintColor = .red
        
        pickerView.delegate = self
        pickerView.dataSource = self
        userTextField.delegate = self
        secondTextField.delegate = self
        mapView.delegate = self
        
        configurationMapView()
    }
    
    func configurationMapView() {
        let center = CLLocationCoordinate2D(latitude: 37.65370, longitude: 127.04740)
        mapView.region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "씨드큐브"
        mapView.addAnnotation(annotation)
    }
    
    //MapView Delegate
    // 기능이 굉장히 많다...는 것.
}

// MARK: UIPickerViewDelegate
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? list.count : array.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? list[row] : String(array[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(component, row)
        if component == 0 {
            userTextField.text = list[row]
        } else {
            secondTextField.text = "\(array[row])"
        }
    }
    
}

// MARK: UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    // TextField Delegate
    // Enabled Return(Enter key) Action
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == secondTextField {
            view.endEditing(true)
        }
        return true
    }
}
