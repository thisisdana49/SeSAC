import UIKit


class Jack: SeSAC {
    
}

struct Den: SeSAC {
    
}

var mentor = Jack()
//mentor = Den() 넣을 수 없음
// 하지만
protocol SeSAC { }
var mentor2: SeSAC = Jack()
mentor2 = Den()


//class User {
//    let name: String
//    let age: Int
//    
//    init(name: String, age: Int) {
//        self.name = name
//        self.age = age
//        print("Class Init")
//    }
//    
//    deinit {
//        print(self, #function)
//    }
//}
//
//var jack: User? = User(name: "Jack", age: 11)
//print("---")
//jack?.name
//jack?.age
//
//jack = nil
//jack?.name
//jack?.age
