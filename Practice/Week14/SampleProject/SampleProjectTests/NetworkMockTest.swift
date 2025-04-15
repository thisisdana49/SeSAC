//
//  NetworkMockTest.swift
//  SampleProjectTests
//
//  Created by 조다은 on 4/7/25.
//

import XCTest
@testable import SampleProject

final class NetworkMockTest: XCTestCase {

    var sut: NetworkProvider!
    
    override func setUpWithError() throws {
//        sut = Lotto mock data를 가지고 있는 클래스
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    // mockData를 잘 구성해야 한다. (다양하며, 실제 응답값 유형을 잘 지켜서)
    // 테스트의 일관성을 위해서 외부 환경에 영향을 받지 않게 구성
    func testExample() throws {
        sut.fetchLotto { lotto in
            // assert
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
