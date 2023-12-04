//
//  AdventOfCode2023Tests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 12/1/23.
//  Copyright © 2023 Wave 39 LLC. All rights reserved.
//

import XCTest

final class AdventOfCode2023Tests: XCTestCase {

    public func test2023day01() {
        let part1 = Puzzle_2023_01().solvePart1()
        XCTAssertEqual(part1, 55_386)
        let part2 = Puzzle_2023_01().solvePart2()
        XCTAssertEqual(part2, 54_824)
    }

    public func test2023day02() {
        let part1 = Puzzle_2023_02().solvePart1()
        XCTAssertEqual(part1, 2_377)
        let part2 = Puzzle_2023_02().solvePart2()
        XCTAssertEqual(part2, 71_220)
    }

    public func test2023day03() {
        let part1 = Puzzle_2023_03().solvePart1()
        XCTAssertEqual(part1, 521_515)
        let part2 = Puzzle_2023_03().solvePart2()
        XCTAssertEqual(part2, 69_527_306)
    }

    public func test2023day04() {
        let part1 = Puzzle_2023_04().solvePart1()
        XCTAssertEqual(part1, 27_845)
        let part2 = Puzzle_2023_04().solvePart2()
        XCTAssertEqual(part2, 9_496_801)
    }

}
