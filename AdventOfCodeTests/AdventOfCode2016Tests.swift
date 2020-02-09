//
//  AdventOfCode2016Tests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 2/8/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import XCTest

class AdventOfCode2016Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test2016day01() {
        let (part1, part2) = Puzzle_2016_01().solveBothParts()
        XCTAssertEqual(part1, 287)
        XCTAssertEqual(part2, 133)
    }

    func test2016day02() {
        let (part1, part2) = Puzzle_2016_02().solveBothParts()
        XCTAssertEqual(part1, "53255")
        XCTAssertEqual(part2, "7423A")
    }

}
