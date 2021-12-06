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

    public func test2021day03() {
        let part1 = Puzzle_2021_03().solvePart1()
        XCTAssertEqual(part1, 2_250_414)
        let part2 = Puzzle_2021_03().solvePart2()
        XCTAssertEqual(part2, 6_085_575)
    }

    public func test2021day04() {
        let part1 = Puzzle_2021_04().solvePart1()
        XCTAssertEqual(part1, 8_136)
        let part2 = Puzzle_2021_04().solvePart2()
        XCTAssertEqual(part2, 12_738)
    }

    public func test2021day05() {
        let part1 = Puzzle_2021_05().solvePart1()
        XCTAssertEqual(part1, 5_084)
        let part2 = Puzzle_2021_05().solvePart2()
        XCTAssertEqual(part2, 17_882)
    }

    public func test2021day06() {
        let part1 = Puzzle_2021_06().solvePart1()
        XCTAssertEqual(part1, 390_011)
        let part2 = Puzzle_2021_06().solvePart2()
        XCTAssertEqual(part2, 1_746_710_169_834)
    }
}
