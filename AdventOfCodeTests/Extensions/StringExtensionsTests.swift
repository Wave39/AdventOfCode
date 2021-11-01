//
//  StringExtensionsTests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 2/9/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import XCTest

class StringExtensionsTests: XCTestCase {

//    override func setUp() {
//    }

//    override func tearDown() {
//    }

    func test_condenseWhitespace() {
        XCTAssertEqual("1   2".condenseWhitespace(), "1 2")
    }

    func test_hasBracket() {
        XCTAssertEqual("123456".hasBracket(), false)
        XCTAssertEqual("123[456".hasBracket(), true)
        XCTAssertEqual("1234]56".hasBracket(), true)
        XCTAssertEqual("123[4]56".hasBracket(), true)
    }

    func test_isStringHexadecimal() {
        XCTAssertEqual("".isStringHexadecimal(), false)
        XCTAssertEqual("1234567890".isStringHexadecimal(), true)
        XCTAssertEqual("abcdef".isStringHexadecimal(), true)
        XCTAssertEqual("abcdefg".isStringHexadecimal(), false)
        XCTAssertEqual("ABCDEF".isStringHexadecimal(), true)
        XCTAssertEqual("ABCDEFG".isStringHexadecimal(), false)
    }

}
