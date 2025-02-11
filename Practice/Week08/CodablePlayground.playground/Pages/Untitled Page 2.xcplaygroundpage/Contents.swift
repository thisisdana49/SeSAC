import UIKit

var greeting = "Hello, playground"

// 서버에서 응답값에 대한 키가 갑자기 이상하게 온다면?
// 혹은 갑자기 타입이 바뀌어서 온다면?
// 즉, 일정하지 않다면?
// SErver > String > Data > Struct > : Decodable. 디코딩. 역직렬화

let json = """
{
    "product_name": "도봉캠퍼스 캠핑카",
    "price": 12345000,
    "mall_name": "네이버"
}
"""

/*
 1. json과 동일한 키를 사용하기
 2. 런타임 이슈를 방지하기 위한 옵셔널, 데이터를 유실
 3. CodingKey
 4. 디코딩 전략 - 1) 스네이크 케이스
 */

struct Product: Decodable {
    let productName: String
    let price: Int
    let mallName: String
}

// String -> Data
guard let result = json.data(using: .utf8) else {
    fatalError("변환 실패")
}

let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase

// Data -> Struct
do {
    let value = try decoder.decode(Product.self, from: result)
    dump(value)
} catch {
    print(error)
}
