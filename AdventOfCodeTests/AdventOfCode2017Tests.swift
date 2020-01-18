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

    func test2017day02() {
        let part1 = Puzzle_2017_02().solvePart1()
        XCTAssertEqual(part1, 45158)
        let part2 = Puzzle_2017_02().solvePart2()
        XCTAssertEqual(part2, 294)
    }
  
    func test2017day03() {
        let (part1, part2) = Puzzle_2017_03().solveBothParts()
        XCTAssertEqual(part1, 475)
        XCTAssertEqual(part2, 279138)
    }

    func test2017day04() {
        let (part1, part2) = Puzzle_2017_04().solveBothParts()
        XCTAssertEqual(part1, 383)
        XCTAssertEqual(part2, 265)
    }

    func test2017day05() {
        let (part1, part2) = Puzzle_2017_05().solveBothParts()
        XCTAssertEqual(part1, 356945)
        XCTAssertEqual(part2, 28372145)
    }

    func test2017day06() {
        let (part1, part2) = Puzzle_2017_06().solveBothParts()
        XCTAssertEqual(part1, 11137)
        XCTAssertEqual(part2, 1037)
    }

    func test2017day07() {
        let (part1, part2) = Puzzle_2017_07().solveBothParts()
        XCTAssertEqual(part1, "bsfpjtc")
        XCTAssertEqual(part2, 529)
    }

    func test2017day08() {
        let (part1, part2) = Puzzle_2017_08().solveBothParts()
        XCTAssertEqual(part1, 3612)
        XCTAssertEqual(part2, 3818)
    }

    func test2017day09() {
        let (part1, part2) = Puzzle_2017_09().solveBothParts()
        XCTAssertEqual(part1, 16689)
        XCTAssertEqual(part2, 7982)
    }

    func test2017day10() {
        let (part1, part2) = Puzzle_2017_10().solveBothParts()
        XCTAssertEqual(part1, 212)
        XCTAssertEqual(part2, "96de9657665675b51cd03f0b3528ba26")
    }

    func test2017day11() {
        let (part1, part2) = Puzzle_2017_11().solveBothParts()
        XCTAssertEqual(part1, 747)
        XCTAssertEqual(part2, 1544)
    }

    func test2017day12() {
        let (part1, part2) = Puzzle_2017_12().solveBothParts()
        XCTAssertEqual(part1, 141)
        XCTAssertEqual(part2, 171)
    }

    func test2017day13() {
        let (part1, part2) = Puzzle_2017_13().solveBothParts()
        XCTAssertEqual(part1, 1580)
        XCTAssertEqual(part2, 3943252)
    }

    func test2017day14() {
        let (part1, part2) = Puzzle_2017_14().solveBothParts()
        XCTAssertEqual(part1, 8216)
        XCTAssertEqual(part2, 1139)
    }

    func test2017day15() {
        let part1 = Puzzle_2017_15().solvePart1()
        XCTAssertEqual(part1, 626)
        let part2 = Puzzle_2017_15().solvePart2()
        XCTAssertEqual(part2, 306)
    }
    
}
