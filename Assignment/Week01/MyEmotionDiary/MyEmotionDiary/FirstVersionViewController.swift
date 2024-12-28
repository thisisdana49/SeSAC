//
//  ViewController.swift
//  MyEmotionDiary
//
//  Created by 조다은 on 12/26/24.
//

import UIKit

class FirstVersionViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var hamburgerMenuImage: UIImageView!
    
    @IBOutlet var buttonOne: UIButton!
    @IBOutlet var buttonTwo: UIButton!
    @IBOutlet var buttonThree: UIButton!
    @IBOutlet var buttonFour: UIButton!
    @IBOutlet var buttonFive: UIButton!
    @IBOutlet var buttonSix: UIButton!
    @IBOutlet var buttonSeven: UIButton!
    @IBOutlet var buttonEight: UIButton!
    @IBOutlet var buttonNine: UIButton!
    
    @IBOutlet var labelOne: UILabel!
    @IBOutlet var labelTwo: UILabel!
    @IBOutlet var labelThree: UILabel!
    @IBOutlet var labelFour: UILabel!
    @IBOutlet var labelFive: UILabel!
    @IBOutlet var labelSix: UILabel!
    @IBOutlet var labelSeven: UILabel!
    @IBOutlet var labelEight: UILabel!
    @IBOutlet var labelNine: UILabel!
    
    @IBOutlet var versioinTwoButton: UIButton!
    
    var happyEmotionDegree: Int = 0
    var loveEmotionDegree: Int = 0
    var likeEmotionDegree: Int = 0
    var angryEmotionDegree: Int = 0
    var disappointedEmotionDegree: Int = 0
    var boredEmotionDegree: Int = 0
    var scaredEmotionDegree: Int = 0
    var badEmotionDegree: Int = 0
    var sadEmotionDegree: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }

    func setUI() {
        view.backgroundColor = .primary
        
        // title label
        titleLabel.text = "My Emotion Diary"
        titleLabel.textAlignment = .center
        
        // hamburger menu image view
        let image = UIImage(systemName: "line.horizontal.3")
        hamburgerMenuImage.image = image
        hamburgerMenuImage.tintColor = .black
       
        // happy cell
        buttonOne.setImage(.monoSlime1, for: .normal)
        buttonOne.setTitle("", for: .normal)
        labelOne.textAlignment = .center
        labelOne.text = "행복해 \(happyEmotionDegree)"

        // love cell
        buttonTwo.setImage(.monoSlime2, for: .normal)
        buttonTwo.setTitle("", for: .normal)
        labelTwo.textAlignment = .center
        labelTwo.text = "사랑해 \(loveEmotionDegree)"

        // like cell
        buttonThree.setImage(.monoSlime3, for: .normal)
        buttonThree.setTitle("", for: .normal)
        labelThree.textAlignment = .center
        labelThree.text = "좋아해 \(likeEmotionDegree)"

        // angry cell
        buttonFour.setImage(.monoSlime4, for: .normal)
        buttonFour.setTitle("", for: .normal)
        labelFour.textAlignment = .center
        labelFour.text = "화가나 \(angryEmotionDegree)"

        // dissapointed cell
        buttonFive.setImage(.monoSlime5, for: .normal)
        buttonFive.setTitle("", for: .normal)
        labelFive.textAlignment = .center
        labelFive.text = "꿀꿀해 \(disappointedEmotionDegree)"

        // bored cell
        buttonSix.setImage(.monoSlime6, for: .normal)
        buttonSix.setTitle("", for: .normal)
        labelSix.textAlignment = .center
        labelSix.text = "지루해 \(boredEmotionDegree)"

        // scared cell
        buttonSeven.setImage(.monoSlime7, for: .normal)
        buttonSeven.setTitle("", for: .normal)
        labelSeven.textAlignment = .center
        labelSeven.text = "무서워 \(scaredEmotionDegree)"

        // bad cell
        buttonEight.setImage(.monoSlime8, for: .normal)
        buttonEight.setTitle("", for: .normal)
        labelEight.textAlignment = .center
        labelEight.text = "속상해 \(badEmotionDegree)"

        // sad cell
        buttonNine.setImage(.monoSlime9, for: .normal)
        buttonNine.setTitle("", for: .normal)
        labelNine.textAlignment = .center
        labelNine.text = "슬프다 \(sadEmotionDegree)"
        
        versioinTwoButton.setTitle("Go to version 2", for: UIControl.State.normal)
        versioinTwoButton.setTitleColor(.white, for: .normal)
        versioinTwoButton.backgroundColor = .black
        versioinTwoButton.layer.cornerRadius = 5
    }
    
    func getRandomInt() -> Int {
        let min = 1
        let max = 100
        return Int.random(in: min...max)
    }
    
    @IBAction func buttonOneTapped(_ sender: UIButton) {
        let randomNumber = getRandomInt()
        labelOne.text = "행복해 \(randomNumber)"
    }
    
    @IBAction func buttonTwoTapped(_ sender: UIButton) {
        let randomNumber = getRandomInt()
        labelTwo.text = "사랑해 \(randomNumber)"
    }
    
    @IBAction func buttonThreeTapped(_ sender: UIButton) {
        let randomNumber = getRandomInt()
        labelThree.text = "좋아해 \(randomNumber)"
    }
    
    @IBAction func buttonFourTapped(_ sender: UIButton) {
        let randomNumber = getRandomInt()
        labelFour.text = "화가나 \(randomNumber)"
    }
    
    @IBAction func buttonFiveTapped(_ sender: UIButton) {
        let randomNumber = getRandomInt()
        labelFive.text = "꿀꿀해 \(randomNumber)"
    }
    
    @IBAction func buttonSixTapped(_ sender: UIButton) {
        let randomNumber = getRandomInt()
        labelSix.text = "지루해 \(randomNumber)"
    }
    
    @IBAction func buttonSevenTapped(_ sender: UIButton) {
        let randomNumber = getRandomInt()
        labelSeven.text = "무서워 \(randomNumber)"
    }
    
    @IBAction func buttonEightTapped(_ sender: UIButton) {
        let randomNumber = getRandomInt()
        labelEight.text = "속상해 \(randomNumber)"
    }
    
    @IBAction func buttonNineTapped(_ sender: UIButton) {
        let randomNumber = getRandomInt()
        labelNine.text = "슬프다 \(randomNumber)"
    }
}
