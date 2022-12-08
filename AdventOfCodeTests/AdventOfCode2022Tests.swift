//
//  AdventOfCode2022Tests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 11/30/22.
//  Copyright © 2022 Wave 39 LLC. All rights reserved.
//

import XCTest

public class AdventOfCode2022Tests: XCTestCase {
//    override func setUpWithError() throws {
//    }
//
//    override func tearDownWithError() throws {
//    }

    public func test2022day01() {
        let part1 = Puzzle_2022_01().solvePart1()
        XCTAssertEqual(part1, 74_711)
        let part2 = Puzzle_2022_01().solvePart2()
        XCTAssertEqual(part2, 209_481)
    }

    public func test2022day02() {
        let part1 = Puzzle_2022_02().solvePart1()
        XCTAssertEqual(part1, 11_475)
        let part2 = Puzzle_2022_02().solvePart2()
        XCTAssertEqual(part2, 16_862)
    }

    public func test2022day03() {
        let part1 = Puzzle_2022_03().solvePart1()
        XCTAssertEqual(part1, 8_123)
        let part2 = Puzzle_2022_03().solvePart2()
        XCTAssertEqual(part2, 2_620)
    }

    public func test2022day04() {
        let part1 = Puzzle_2022_04().solvePart1()
        XCTAssertEqual(part1, 500)
        let part2 = Puzzle_2022_04().solvePart2()
        XCTAssertEqual(part2, 815)
    }

    public func test2022day05() {
        let part1 = Puzzle_2022_05().solvePart1()
        XCTAssertEqual(part1, "TLFGBZHCN")
        let part2 = Puzzle_2022_05().solvePart2()
        XCTAssertEqual(part2, "QRQFHFWCL")
    }

    public func test2022day06() {
        let part1 = Puzzle_2022_06().solvePart1()
        XCTAssertEqual(part1, 1_262)
        let part2 = Puzzle_2022_06().solvePart2()
        XCTAssertEqual(part2, 3_444)
    }

    public func test2022day07() {
        let part1 = Puzzle_2022_07().solvePart1()
        XCTAssertEqual(part1, 1_315_285)
        let part2 = Puzzle_2022_07().solvePart2()
        XCTAssertEqual(part2, 9_847_279)
    }

    public func test2022day08() {
        let part1 = Puzzle_2022_08().solvePart1()
        XCTAssertEqual(part1, 1_690)
        let part2 = Puzzle_2022_08().solvePart2()
        XCTAssertEqual(part2, 535_680)
    }
}
