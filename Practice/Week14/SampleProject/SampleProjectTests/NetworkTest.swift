//
//  NetworkTest.swift
//  SampleProjectTests
//
//  Created by 조다은 on 4/7/25.
//

import XCTest
@testable import SampleProject

final class NetworkTest: XCTestCase {

    var sut: NetworkManager!
    
    override func setUpWithError() throws {
        sut = NetworkManager.shared
        print(#function)
    }

    override func tearDownWithError() throws {
        print(#function)
        sut = nil
    }

    // response lotto bonusNo 1 - 45에 해당하면 성공
    // 응답값이 이상한데 왜 테케가 성공할까?
    // UnitTest는 동기에 최적화 되어있음. 비동기 메서드를 절대로 기다리지 않는다.
    // 비동기를 기다려줄 수 있는 코드를 우리가 직접 작성 해야 한다.
    // 1) expectation 2) wait 3) fulfill
    func testExample() throws {
        print("111111")
        
        // 1) expectation
        let promise = expectation(description: "로또 API CompletionHandler를 기다리는 중")
        
        sut.fetchLotto { lotto in
            let value = lotto.bnusNo
            XCTAssertLessThanOrEqual(value, 45, "45 이하여야 한다")
            XCTAssertGreaterThanOrEqual(value, 1, "1 이상이여야 한다")
            print("fetch Lotto")
            // 3) fulfill: 정의해둔 expectation이 충족되는 시점에 호출을 해서, 비동기 작업을 마무리해도 된다고 알려줌
            promise.fulfill()
        }
        print("222222")
        // 2) wait: 비동기 작업이 끝날 때까지 기다리는 타임아웃. 타임아웃이 지나면 실패로 간주
        wait(for: [promise], timeout: 5)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
