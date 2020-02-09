//
//  StringExtensionsTests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 2/9/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import XCTest

class StringExtensionsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_condenseWhitespace() {
        XCTAssertEqual("1   2".condenseWhitespace(), "1 2")
    }

    func test_hasBracket() {
        XCTAssertEqual("123456".hasBracket(), false)
        XCTAssertEqual("123[456".hasBracket(), true)
        XCTAssertEqual("1234]56".hasBracket(), true)
        XCTAssertEqual("123[4]56".hasBracket(), true)
    }

}
