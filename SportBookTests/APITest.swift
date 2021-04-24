//
//  APITest.swift
//  SportBookTests
//
//  Created by Matthew Jagiela on 4/24/21.
//

import XCTest
import Combine
@testable import SportBook
class APITest: XCTestCase {
    let api = APIRequest()
    var subscriptions: Set<AnyCancellable> = []
    func testApiRequest() {
        let apiExpectation = expectation(description: "APIResult")
        api.getSportResults().receive(on: RunLoop.main).sink { completion in
            switch completion {
            case .failure(let error): XCTFail("Failure with error \(error)")
            case .finished: apiExpectation.fulfill()
            }
            
        } receiveValue: { _ in
            
            
        }.store(in: &subscriptions)
        waitForExpectations(timeout: 5)
    }

}
