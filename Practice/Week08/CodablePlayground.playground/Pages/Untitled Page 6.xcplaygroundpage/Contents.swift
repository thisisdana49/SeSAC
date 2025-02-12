import UIKit

// Struct -> Data -> String -> Server

struct User: Encodable  {
    let name: String
    let age: Int
    let birth: Date
}

let jack = User(name: "잭", age: 12, birth: Date())
let den = User(name: "덴", age: 99, birth: Date(timeInterval: -86400, since: Date()))
let bran = User(name: "브랜", age: 1, birth: Date(timeIntervalSinceNow: 86400 * 2))

let mentor = [jack, den, bran]

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
//encoder.dateEncodingStrategy = .iso8601

let format = DateFormatter()
format.dateFormat = "MM월 dd일, yyyy년"
encoder.dateEncodingStrategy = .formatted(format)

do {
    let result = try encoder.encode(mentor)
    print(result)
    
    guard let jsonString = String(data: result, encoding: .utf8) else {
        fatalError("ERROR")
    }
    print(jsonString)
    
} catch {
    print(error)
}
