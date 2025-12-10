//
//  AdventOfCode2025Tests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 11/28/25.
//  Copyright © 2025 Wave 39 LLC. All rights reserved.
//

import XCTest

final class AdventOfCode2025Tests: XCTestCase {
    public func test2025day01() {
        let part1 = Puzzle_2025_01().solvePart1()
        XCTAssertEqual(part1, 1_129)
        let part2 = Puzzle_2025_01().solvePart2()
        XCTAssertEqual(part2, 6_638)
    }

    public func test2025day02() {
        let part1 = Puzzle_2025_02().solvePart1()
        XCTAssertEqual(part1, 40_214_376_723)
        let part2 = Puzzle_2025_02().solvePart2()
        XCTAssertEqual(part2, 50_793_864_718)
    }

    public func test2025day03() {
        let part1 = Puzzle_2025_03().solvePart1()
        XCTAssertEqual(part1, 17_229)
        let part2 = Puzzle_2025_03().solvePart2()
        XCTAssertEqual(part2, 170_520_923_035_051)
    }

    public func test2025day04() {
        let part1 = Puzzle_2025_04().solvePart1()
        XCTAssertEqual(part1, 1_587)
        let part2 = Puzzle_2025_04().solvePart2()
        XCTAssertEqual(part2, 8_946)
    }

    public func test2025day05() {
        let part1 = Puzzle_2025_05().solvePart1()
        XCTAssertEqual(part1, 756)
        let part2 = Puzzle_2025_05().solvePart2()
        XCTAssertEqual(part2, 355_555_479_253_787)
    }

    public func test2025day06() {
        let part1 = Puzzle_2025_06().solvePart1()
        XCTAssertEqual(part1, 4_722_948_564_882)
        let part2 = Puzzle_2025_06().solvePart2()
        XCTAssertEqual(part2, 9_581_313_737_063)
    }

    public func test2025day07() {
        let part1 = Puzzle_2025_07().solvePart1()
        XCTAssertEqual(part1, 1_622)
        let part2 = Puzzle_2025_07().solvePart2()
        XCTAssertEqual(part2, 10_357_305_916_520)
    }

    public func test2025day08() {
        let part1 = Puzzle_2025_08().solvePart1()
        XCTAssertEqual(part1, 57_564)
        let part2 = Puzzle_2025_08().solvePart2()
        XCTAssertEqual(part2, 133_296_744)
    }

    public func test2025day09() {
        let part1 = Puzzle_2025_09().solvePart1()
        XCTAssertEqual(part1, 4_752_484_112)
        let part2 = Puzzle_2025_09().solvePart2()
        XCTAssertEqual(part2, 1_465_767_840)
    }

    public func test2025day10() {
        let part1 = Puzzle_2025_10().solvePart1()
        XCTAssertEqual(part1, 2)
        let part2 = Puzzle_2025_10().solvePart2()
        XCTAssertEqual(part2, 2)
    }

    public func test2025day11() {
        let part1 = Puzzle_2025_11().solvePart1()
        XCTAssertEqual(part1, 2)
        let part2 = Puzzle_2025_11().solvePart2()
        XCTAssertEqual(part2, 2)
    }

    public func test2025day12() {
        let part1 = Puzzle_2025_12().solvePart1()
        XCTAssertEqual(part1, 2)
        let part2 = Puzzle_2025_12().solvePart2()
        XCTAssertEqual(part2, 2)
    }
}
