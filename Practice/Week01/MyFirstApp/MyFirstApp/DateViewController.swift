//
//  DateViewController.swift
//  MyFirstApp
//
//  Created by 조다은 on 12/27/24.
//

import UIKit

class DateViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet var buttonList: [UIButton]!
    @IBOutlet var emotionLabel: UILabel!
    
    var emotions: [String] = ["Happy", "Sad", "Angry", "Surprise"]
    
    // Date: 영국 표준시 기준
    // 1. 그 나라에 맞는 시간대로 변경
    // 2. yyyy-MM-dd hh:mm:ss
    // yy년 MM월 dd일
    // DateFormatter로 해결 가능한.
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateButtonTapped(checkButton)
        
        
        // PoV. let은 상수인데 왜 변경을 할 수 있는 거지?하는 생각.
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 hh시 mm분 ss초 EEEE"
        
        let calendar = DateComponents()
//        calendar.year = 2025
        
        let formattedDate = formatter.string(from: datePicker.date)
        print(formattedDate)
        
        // ios15+ - formatted()
        print(datePicker.date.formatted())
        print(10010310230123.formatted())
        
        for i in 0..<buttonList.count {
            buttonList[i].setTitle("\(emotions[i])", for: .normal)
            buttonList[i].tag = i
        }
    }
    
    
    @IBAction func dateButtonTapped(_ sender: UIButton) {
        print(datePicker.date)
        resultLabel.text = datePicker.date.description
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        print(datePicker.date, sender.date)
        resultLabel.text = datePicker.date.description
    }
    
    @IBAction func keyboardDismiss(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func emotionButtonTapped(_ sender: UIButton) {
        // 1. 어떤 버튼을 클릭했는지 어떻게 알아?
        // -> currentTitle
        print(sender.currentTitle!)
        print(sender.tag)
        
//        let value = sender.currentTitle
        let value = emotions[sender.tag]
        
        if value == "Happy" {
            emotionLabel.text = ":)"
        } else if value == "Sad" {
            emotionLabel.text = ":("
        } else if value == "Angry" {
            emotionLabel.text = ":/"
        } else if value == "Surprise" {
            emotionLabel.text = ":O"
        }
        
    }
    
}
