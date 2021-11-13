//
//  StringExtensionsTests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 2/9/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import XCTest

public class StringExtensionsTests: XCTestCase {
//    override func setUp() {
//    }

//    override func tearDown() {
//    }

    public func test_condenseWhitespace() {
        XCTAssertEqual("1   2".condenseWhitespace(), "1 2")
    }

    public func test_hasBracket() {
        XCTAssertFalse("123456".hasBracket())
        XCTAssertTrue("123[456".hasBracket())
        XCTAssertTrue("1234]56".hasBracket())
        XCTAssertTrue("123[4]56".hasBracket())
    }

    public func test_isStringHexadecimal() {
        XCTAssertFalse("".isStringHexadecimal())
        XCTAssertTrue("1234567890".isStringHexadecimal())
        XCTAssertTrue("abcdef".isStringHexadecimal())
        XCTAssertFalse("abcdefg".isStringHexadecimal())
        XCTAssertTrue("ABCDEF".isStringHexadecimal())
        XCTAssertFalse("ABCDEFG".isStringHexadecimal())
    }
}
