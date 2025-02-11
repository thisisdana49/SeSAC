import UIKit

var greeting = "Hello, playground"

// 서버에서 응답값에 대한 키가 갑자기 이상하게 온다면?
// 혹은 갑자기 타입이 바뀌어서 온다면?
// 즉, 일정하지 않다면?
// SErver > String > Data > Struct > : Decodable. 디코딩. 역직렬화

let json = """
{
    "product": "도봉캠퍼스 캠핑카",
    "price": 12345000,
    "mall": "네이버"
}
"""

/*
 1. json과 동일한 키를 사용하기
 2. 런타임 이슈를 방지하기 위한 옵셔널, 데이터를 유실
 3. CodingKey
 */

struct Product: Decodable {
    let item: String
    let price: Int
    let mall: String
    
    enum CodingKeys: String, CodingKey {
        case item = "product"
        case price
        case mall
    }
}

// String -> Data
guard let result = json.data(using: .utf8) else {
    fatalError("변환 실패")
}


// Data -> Struct
do {
    let value = try JSONDecoder().decode(Product.self, from: result)
    dump(value)
} catch {
    print(error)
}
