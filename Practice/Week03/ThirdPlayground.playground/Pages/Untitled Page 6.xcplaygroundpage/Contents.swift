//: [Previous](@previous)

import UIKit


// tableView.delegate = self
// => Protocol as type
protocol Mentor {}

class Jack: Mentor {}
class Hue: Mentor {}
struct Bran: Mentor {}
struct Den: Mentor {}

//var mentor: Jack = Jack()
//mentor = Bran() 불가

var mentor: Mentor = Jack()
mentor = Bran()


// Method Requirements
// 구조체, 클래스, 열거형 모두 적용 가능
// UIViewController, UITableViewCell 와 같은 클래스들한테만 쓰도록 한정하는 것도 가능)
// Optional Protocol
@objc
protocol ViewPresentableProtocol: AnyObject { // -> 최적화라고 볼 수 있다. 연결고리를 클래스만 두는 것이기 때문.
    var backgroundColor: UIColor { get }
    var navigationTitleString: String { get set }
    // 어떻게 쓸지 알 수 없ㅇ기 때문에 let은 프로토콜에서 정의 불가
    
    func configureNavigationItem()
    func configureView()
    // Optional Protocol, Optional Requirements
    @objc optional func configureTextField()
}

class SearchViewController: ViewPresentableProtocol {
    var backgroundColor: UIColor = .blue
    var navigationTitleString: String {
        get {
            return "This is navigation title text"
        }
        set {
            navigationTitleString = newValue
        }
    }
    
//     Actor는 다음에.
    func configureNavigationItem() {
        <#code#>
    }
    
    func configureView() {
        <#code#>
    }
    
    func configureTextField() {
        <#code#>
    }
    
}

// 프로토콜 명세를 따르는 타입 == 프로토콜을 준수(confirm)한다.
class SettingViewController: ViewPresentableProtocol {
    
    func configureNavigationItem() {
        <#code#>
    }
    
    func configureView() {
        <#code#>
    }
    
    func configureTextField() {
        <#code#>
    }
    
    
}

// 구조체라서 적용 불가능!
//struct User: ViewPresentableProtocol { }


//: [Next](@next)
