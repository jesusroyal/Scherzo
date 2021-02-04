//
//  ScherzoTests.swift
//  ScherzoTests
//
//  Created by Mike Shevelinsky on 02.02.2021.
//

import XCTest
@testable import Scherzo

class ScherzoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testApi() {
        let service = JokeService()

        let expectation = self.expectation(description: "Some")

        service.getJoke { (joke) in
            guard let joke = joke else {
                XCTFail("Joke is nil")
                return
            }
            if !joke.punchline.isEmpty && !joke.setup.isEmpty {
                expectation.fulfill()
            }
        }

        self.waitForExpectations(timeout: 20)

    }

}
