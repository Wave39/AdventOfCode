//
//  AdventOfCode2021Tests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 11/13/21.
//  Copyright © 2021 Wave 39 LLC. All rights reserved.
//

import XCTest

public class AdventOfCode2021Tests: XCTestCase {
//    override func setUp() {
//    }

//    override func tearDown() {
//    }

    public func test2021day01() {
        let part1 = Puzzle_2021_01().solvePart1()
        XCTAssertEqual(part1, 1_446)
        let part2 = Puzzle_2021_01().solvePart2()
        XCTAssertEqual(part2, 1_486)
    }

    public func test2021day02() {
        let part1 = Puzzle_2021_02().solvePart1()
        XCTAssertEqual(part1, 1_635_930)
        let part2 = Puzzle_2021_02().solvePart2()
        XCTAssertEqual(part2, 1_781_819_478)
    }
}
