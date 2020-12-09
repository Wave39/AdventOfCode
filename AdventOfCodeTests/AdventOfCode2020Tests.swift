//
//  AdventOfCode2020Tests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 11/24/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import XCTest

class AdventOfCode2020Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test2020day01() {
        let part1 = Puzzle_2020_01().solvePart1()
        XCTAssertEqual(part1, 494475)
        let part2 = Puzzle_2020_01().solvePart2()
        XCTAssertEqual(part2, 267520550)
    }
        
    func test2020day02() {
        let part1 = Puzzle_2020_02().solvePart1()
        XCTAssertEqual(part1, 474)
        let part2 = Puzzle_2020_02().solvePart2()
        XCTAssertEqual(part2, 745)
    }
        
    func test2020day03() {
        let part1 = Puzzle_2020_03().solvePart1()
        XCTAssertEqual(part1, 200)
        let part2 = Puzzle_2020_03().solvePart2()
        XCTAssertEqual(part2, 3737923200)
    }
        
    func test2020day04() {
        let part1 = Puzzle_2020_04().solvePart1()
        XCTAssertEqual(part1, 247)
        let part2 = Puzzle_2020_04().solvePart2()
        XCTAssertEqual(part2, 145)
    }
        
    func test2020day05() {
        let part1 = Puzzle_2020_05().solvePart1()
        XCTAssertEqual(part1, 813)
        let part2 = Puzzle_2020_05().solvePart2()
        XCTAssertEqual(part2, 612)
    }
        
    func test2020day06() {
        let part1 = Puzzle_2020_06().solvePart1()
        XCTAssertEqual(part1, 6259)
        let part2 = Puzzle_2020_06().solvePart2()
        XCTAssertEqual(part2, 3178)
    }
        
    func test2020day07() {
        let part1 = Puzzle_2020_07().solvePart1()
        XCTAssertEqual(part1, 242)
        let part2 = Puzzle_2020_07().solvePart2()
        XCTAssertEqual(part2, 176035)
    }
        
    func test2020day08() {
        let part1 = Puzzle_2020_08().solvePart1()
        XCTAssertEqual(part1, 1797)
        let part2 = Puzzle_2020_08().solvePart2()
        XCTAssertEqual(part2, 1036)
    }
        
    func test2020day09() {
        let part1 = Puzzle_2020_09().solvePart1()
        XCTAssertEqual(part1, 90433990)
        let part2 = Puzzle_2020_09().solvePart2()
        XCTAssertEqual(part2, 11691646)
    }
        
}
