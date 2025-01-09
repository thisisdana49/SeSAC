//
//  ViewController.swift
//  UpDownGame
//
//  Created by 조다은 on 1/9/25.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var startImageView: UIImageView!
    @IBOutlet var startNumberTextField: UITextField!
    @IBOutlet var startButton: UIButton!
    
    @IBOutlet var labelTopMargin: NSLayoutConstraint!
    @IBOutlet var buttonBottomMargin: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startNumberTextField.delegate = self
        
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startNumberTextField.text = ""
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        guard let inputValue = startNumberTextField.text, let startNum = Int(inputValue) else {
            print("숫자 입력 요망")
            return
        }
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: InProgressViewController.identifier) as! InProgressViewController
        vc.maxNumber = startNum
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        present(vc, animated: true)
    }
    
    @IBAction func gestureRecognizerTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    private func setUI() {
        view.backgroundColor = .baseBlue
        
        titleLabel.text = "UP DOWN"
        titleLabel.font = UIFont.systemFont(ofSize: 36, weight: .heavy)
        titleLabel.textAlignment = .center
        
        subtitleLabel.text = "GAME"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        subtitleLabel.textAlignment = .center
        
        startImageView.image = .emotion1
        startImageView.contentMode = .scaleAspectFit
        
        startButton.setTitle("시작하기", for: .normal)
        startButton.backgroundColor = .black
        startButton.setTitleColor(.white, for: .normal)
    }
}

extension StartViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        labelTopMargin.constant -= 320
        buttonBottomMargin.constant = 320
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        labelTopMargin.constant = 32
        buttonBottomMargin.constant = 0
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
