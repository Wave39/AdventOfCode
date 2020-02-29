//
//  AdventOfCode2015Tests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 2/14/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import XCTest

class AdventOfCode2015Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test2015day01() {
        let (part1, part2) = Puzzle_2015_01().solveBothParts()
        XCTAssertEqual(part1, 232)
        XCTAssertEqual(part2, 1783)
    }

    func test2015day02() {
        let (part1, part2) = Puzzle_2015_02().solveBothParts()
        XCTAssertEqual(part1, 1586300)
        XCTAssertEqual(part2, 3737498)
    }

    func test2015day03() {
        let (part1, part2) = Puzzle_2015_03().solveBothParts()
        XCTAssertEqual(part1, 2572)
        XCTAssertEqual(part2, 2631)
    }

    func test2015day04() {
        let (part1, part2) = Puzzle_2015_04().solveBothParts()
        XCTAssertEqual(part1, 117946)
        XCTAssertEqual(part2, 3938038)
    }

    func test2015day05() {
        let (part1, part2) = Puzzle_2015_05().solveBothParts()
        XCTAssertEqual(part1, 255)
        XCTAssertEqual(part2, 55)
    }

    func test2015day06() {
        let (part1, part2) = Puzzle_2015_06().solveBothParts()
        XCTAssertEqual(part1, 569999)
        XCTAssertEqual(part2, 17836115)
    }

    func test2015day07() {
        let (part1, part2) = Puzzle_2015_07().solveBothParts()
        XCTAssertEqual(part1, 16076)
        XCTAssertEqual(part2, 2797)
    }

    func test2015day08() {
        let (part1, part2) = Puzzle_2015_08().solveBothParts()
        XCTAssertEqual(part1, 1333)
        XCTAssertEqual(part2, 2046)
    }

    func test2015day09() {
        let (part1, part2) = Puzzle_2015_09().solveBothParts()
        XCTAssertEqual(part1, 141)
        XCTAssertEqual(part2, 736)
    }

    func test2015day10() {
        let (part1, part2) = Puzzle_2015_10().solveBothParts()
        XCTAssertEqual(part1, 492982)
        XCTAssertEqual(part2, 6989950)
    }

    func test2015day11() {
        let (part1, part2) = Puzzle_2015_11().solveBothParts()
        XCTAssertEqual(part1, "hepxxyzz")
        XCTAssertEqual(part2, "heqaabcc")
    }

    func test2015day12() {
        let (part1, part2) = Puzzle_2015_12().solveBothParts()
        XCTAssertEqual(part1, 119433)
        XCTAssertEqual(part2, 68466)
    }

    func test2015day13() {
        let (part1, part2) = Puzzle_2015_13().solveBothParts()
        XCTAssertEqual(part1, 709)
        XCTAssertEqual(part2, 668)
    }

    func test2015day14() {
        let (part1, part2) = Puzzle_2015_14().solveBothParts()
        XCTAssertEqual(part1, 2655)
        XCTAssertEqual(part2, 1059)
    }

    func test2015day15() {
        let (part1, part2) = Puzzle_2015_15().solveBothParts()
        XCTAssertEqual(part1, 13882464)
        XCTAssertEqual(part2, 11171160)
    }

    func test2015day16() {
        let (part1, part2) = Puzzle_2015_16().solveBothParts()
        XCTAssertEqual(part1, 103)
        XCTAssertEqual(part2, 405)
    }

}
