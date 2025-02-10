import UIKit

protocol DanaProtocol: AnyObject {
    func numberOfRowsInSection()
}

class Main: DanaProtocol {
    
    func numberOfRowsInSection() {
        print(#function)
    }
    
    lazy var detail = {
        let view = Detail()
        print("Detail 클로저 즉시 실행")
        view.delegate = self
        return view
    }()
    init() {
        print("Detail Init")
    }
    
    deinit {
        print("Detail Deinit")
    }
}
/*
 tableView, collection View
 프로토콜 기반 역값 전달
 
 person property name. 클로저 구문
 */
class Detail {
    weak var delegate: DanaProtocol?
    func setup() {
        print(#function)
        delegate?.numberOfRowsInSection()
    }
    
    init() {
        print("Detail Init")
    }
    
    deinit {
        print("Detail Deinit")
    }
}

var main: Main? = Main() // 화면이 Appear한 상황
main?.detail
main = nil               // 화면이 Disappear한 상황
main?.detail




class Person {
    var name: String
    
    // self.name: Dana 인스턴스가 없어져도 name은 가지고 있겟다, 이 하나로 인하여 인스턴스 자체가 살아있게 되는 상황
    // weak self: Dana 인스턴스가 없어진다면 같이 가겠다...
    lazy var introduce = { [weak self] in
        print("Introduce ", self?.name)
    }
    
    init(name: String) {
        self.name = name
        print("Person Init")
    }
    
    deinit {
        print("Person Deinit")
    }
    
    func hello() {
        print(#function, name)
    }
}

// ARC: Automatic Reference Count
// Swift 메모리 관리 기법
var dana: Person? = Person(name: "Dana")

dana?.name = "Hue"
dana?.name
dana?.hello()
dana?.introduce()
let newIntroduce = dana?.introduce
newIntroduce?()

dana = nil // 인스턴스 해제 시점
print("dana nil")

dana?.name
dana?.hello()
dana?.introduce()
newIntroduce?()
