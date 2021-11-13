//
//  AdventOfCode2017Tests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 1/5/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import XCTest

public class AdventOfCode2017Tests: XCTestCase {
//    override func setUp() {
//    }

//    override func tearDown() {
//    }

    public func test2017day01() {
        let (part1, part2) = Puzzle_2017_01().solveBothParts()
        XCTAssertEqual(part1, 1_343)
        XCTAssertEqual(part2, 1_274)
    }

    public func test2017day02() {
        let part1 = Puzzle_2017_02().solvePart1()
        XCTAssertEqual(part1, 45_158)
        let part2 = Puzzle_2017_02().solvePart2()
        XCTAssertEqual(part2, 294)
    }

    public func test2017day03() {
        let (part1, part2) = Puzzle_2017_03().solveBothParts()
        XCTAssertEqual(part1, 475)
        XCTAssertEqual(part2, 279_138)
    }

    public func test2017day04() {
        let (part1, part2) = Puzzle_2017_04().solveBothParts()
        XCTAssertEqual(part1, 383)
        XCTAssertEqual(part2, 265)
    }

    public func test2017day05() {
        let (part1, part2) = Puzzle_2017_05().solveBothParts()
        XCTAssertEqual(part1, 356_945)
        XCTAssertEqual(part2, 28_372_145)
    }

    public func test2017day06() {
        let (part1, part2) = Puzzle_2017_06().solveBothParts()
        XCTAssertEqual(part1, 11_137)
        XCTAssertEqual(part2, 1_037)
    }

    public func test2017day07() {
        let (part1, part2) = Puzzle_2017_07().solveBothParts()
        XCTAssertEqual(part1, "bsfpjtc")
        XCTAssertEqual(part2, 529)
    }

    public func test2017day08() {
        let (part1, part2) = Puzzle_2017_08().solveBothParts()
        XCTAssertEqual(part1, 3_612)
        XCTAssertEqual(part2, 3_818)
    }

    public func test2017day09() {
        let (part1, part2) = Puzzle_2017_09().solveBothParts()
        XCTAssertEqual(part1, 16_689)
        XCTAssertEqual(part2, 7_982)
    }

    public func test2017day10() {
        let (part1, part2) = Puzzle_2017_10().solveBothParts()
        XCTAssertEqual(part1, 212)
        XCTAssertEqual(part2, "96de9657665675b51cd03f0b3528ba26")
    }

    public func test2017day11() {
        let (part1, part2) = Puzzle_2017_11().solveBothParts()
        XCTAssertEqual(part1, 747)
        XCTAssertEqual(part2, 1_544)
    }

    public func test2017day12() {
        let (part1, part2) = Puzzle_2017_12().solveBothParts()
        XCTAssertEqual(part1, 141)
        XCTAssertEqual(part2, 171)
    }

    public func test2017day13() {
        let (part1, part2) = Puzzle_2017_13().solveBothParts()
        XCTAssertEqual(part1, 1_580)
        XCTAssertEqual(part2, 3_943_252)
    }

    public func test2017day14() {
        let (part1, part2) = Puzzle_2017_14().solveBothParts()
        XCTAssertEqual(part1, 8_216)
        XCTAssertEqual(part2, 1_139)
    }

    public func test2017day15() {
        let part1 = Puzzle_2017_15().solvePart1()
        XCTAssertEqual(part1, 626)
        let part2 = Puzzle_2017_15().solvePart2()
        XCTAssertEqual(part2, 306)
    }

    public func test2017day16() {
        let part1 = Puzzle_2017_16().solvePart1()
        XCTAssertEqual(part1, "cknmidebghlajpfo")
        let part2 = Puzzle_2017_16().solvePart2()
        XCTAssertEqual(part2, "cbolhmkgfpenidaj")
    }

    public func test2017day17() {
        let part1 = Puzzle_2017_17().solvePart1()
        XCTAssertEqual(part1, 1_306)
        let part2 = Puzzle_2017_17().solvePart2()
        XCTAssertEqual(part2, 20_430_489)
    }

    public func test2017day18() {
        let part1 = Puzzle_2017_18().solvePart1()
        XCTAssertEqual(part1, 4_601)
        let part2 = Puzzle_2017_18().solvePart2()
        XCTAssertEqual(part2, 6_858)
    }

    public func test2017day19() {
        let (part1, part2) = Puzzle_2017_19().solveBothParts()
        XCTAssertEqual(part1, "VEBTPXCHLI")
        XCTAssertEqual(part2, 18_702)
    }

    public func test2017day20() {
        let part1 = Puzzle_2017_20().solvePart1()
        XCTAssertEqual(part1, 150)
        let part2 = Puzzle_2017_20().solvePart2()
        XCTAssertEqual(part2, 657)
    }

    public func test2017day21() {
        let (part1, part2) = Puzzle_2017_21().solveBothParts()
        XCTAssertEqual(part1, 125)
        XCTAssertEqual(part2, 1_782_917)
    }

    public func test2017day22() {
        let part1 = Puzzle_2017_22().solvePart1()
        XCTAssertEqual(part1, 5_433)
        let part2 = Puzzle_2017_22().solvePart2()
        XCTAssertEqual(part2, 2_512_599)
    }

    public func test2017day23() {
        let part1 = Puzzle_2017_23().solvePart1()
        XCTAssertEqual(part1, 8_281)
        let part2 = Puzzle_2017_23().solvePart2()
        XCTAssertEqual(part2, 911)
    }

    public func test2017day24() {
        let (part1, part2) = Puzzle_2017_24().solveBothParts()
        XCTAssertEqual(part1, 2_006)
        XCTAssertEqual(part2, 1_994)
    }

    public func test2017day25() {
        let part1 = Puzzle_2017_25().solvePart1()
        XCTAssertEqual(part1, 2_870)
    }
}
