//
//  AdventOfCode2017Tests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 1/5/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import XCTest

class AdventOfCode2017Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test2017day01() {
        let (part1, part2) = Puzzle_2017_01().solveBothParts()
        XCTAssertEqual(part1, 1343)
        XCTAssertEqual(part2, 1274)
    }

}
