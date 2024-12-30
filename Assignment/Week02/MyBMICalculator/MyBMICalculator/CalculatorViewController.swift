//
//  CalculatorViewController.swift
//  MyBMICalculator
//
//  Created by 조다은 on 12/30/24.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet var guideTitleLabel: UILabel!
    @IBOutlet var guideContentLabel: UILabel!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var heightLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var randomBmiButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    var nickname: String = ""
    var savedHeight: Double?
    var savedWeight: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nickname = UserDefaults.standard.string(forKey: "nickname")!
        
        let isSavedHeightData = UserDefaults.standard.bool(forKey: "\(nickname)Height")
        let isSavedWeightData = UserDefaults.standard.bool(forKey: "\(nickname)Weight")
        if isSavedHeightData {
            savedHeight = UserDefaults.standard.double(forKey: "\(nickname)Height")
            savedWeight = UserDefaults.standard.double(forKey: "\(nickname)Weight")
            heightTextField.text = String(round(savedHeight!))
            weightTextField.text = String(savedWeight!)
        }
        setUI()
    }
    
    @IBAction func randomBMIButtonTapped(_ sender: UIButton) {
        let height = Double.random(in: 140..<250) * 0.01
        let weight = Double.random(in: 30..<200)
        
        calculateBMI(h: height, w: weight)
    }
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        let height = (Double(heightTextField.text ?? "") ?? 0) * 0.01
        UserDefaults.standard.set(height * 100, forKey: "\(nickname)Height")
        print(UserDefaults.standard.string(forKey: "\(nickname)Height")!)
        if height < 0 || height > 250 {
            let alert = UIAlertController(title: "⚠️ 입력 오류", message: "입력한 키를 다시 한 번 확인해 주세요.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
            return
        }
        
        let weight = Double(weightTextField.text ?? "") ?? 0
        UserDefaults.standard.set(weight, forKey: "\(nickname)Weight")
        print(UserDefaults.standard.string(forKey: "\(nickname)Weight")!)
        if weight < 0 || weight > 200 {
            let alert = UIAlertController(title: "⚠️ 입력 오류", message: "입력한 체중을 다시 한 번 확인해 주세요.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
            return
        }
            
        calculateBMI(h: height, w: weight)
    }

    func calculateBMI(h height: Double, w weight: Double) {
        let bmi = weight / (height * height)
        let roundedBMI = getRoundedBMI(bmi: bmi)
        let obesity = getObesity(bmi: bmi)
        
        let alert = UIAlertController(title: "✅ BMI 결과", message: "\(nickname)님의 BMI 지수는 \(roundedBMI)로\n\(obesity)입니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func getRoundedBMI(bmi: Double) -> Double {
        let roundedBMI = Double(round(100 * bmi) / 100)
        return roundedBMI
    }
    
    func getObesity(bmi: Double) -> String {
        if bmi < 18.5 {
            return "저체중"
        } else if bmi < 23.0 {
            return "정상"
        } else if bmi < 25.0 {
            return "과체중"
        } else {
            return "비만"
        }
    }
    
    fileprivate func setUI() {
        guideTitleLabel.numberOfLines = 0
        guideTitleLabel.text = "체중과 키가\n어떻게 되시나요?"
        guideTitleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        
        guideContentLabel.numberOfLines = 0
        guideContentLabel.text = "\(nickname)님의 BMI 지수를\n알려드릴게요."
        guideContentLabel.font = UIFont.systemFont(ofSize: 16)
        guideContentLabel.textColor = .lightGray
        
        heightTextField.keyboardType = .numberPad
        heightTextField.textAlignment = .right
        heightTextField.placeholder = "168"
        heightTextField.font = UIFont.systemFont(ofSize: 16)
        heightTextField.frame.size.height = 50
        heightTextField.layer.borderWidth = 1
        heightTextField.layer.borderColor = UIColor.systemGray6.cgColor
        heightTextField.layer.cornerRadius = 10
        
        heightLabel.text = "cm"
        heightLabel.font = UIFont.systemFont(ofSize: 16)

        weightTextField.keyboardType = .numberPad
        weightTextField.textAlignment = .right
        weightTextField.placeholder = "42"
        weightTextField.font = UIFont.systemFont(ofSize: 16)
        weightTextField.frame.size.height = 50
        weightTextField.layer.borderWidth = 1
        weightTextField.layer.borderColor = UIColor.systemGray6.cgColor
        weightTextField.layer.cornerRadius = 10
        
        weightLabel.text = "kg"
        weightLabel.font = UIFont.systemFont(ofSize: 16)
        
        nextButton.setTitle("확인", for: .normal)
        nextButton.tintColor = .white
        nextButton.backgroundColor = .systemBlue
        nextButton.layer.cornerRadius = 10
        
        randomBmiButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        randomBmiButton.setTitleColor(UIColor.systemGray3, for: .normal)
    }
    
}
