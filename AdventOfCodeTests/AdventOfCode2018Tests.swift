//
//  AdventOfCode2018Tests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 12/8/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import XCTest

class AdventOfCode2018Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test2018day01() {
        let part1 = Puzzle_2018_01().solvePart1()
        XCTAssertEqual(part1, 472)
        let part2 = Puzzle_2018_01().solvePart2()
        XCTAssertEqual(part2, 66932)
    }
    
    func test2018day02() {
        let part1 = Puzzle_2018_02().solvePart1()
        XCTAssertEqual(part1, 6696)
        let part2 = Puzzle_2018_02().solvePart2()
        XCTAssertEqual(part2, "bvnfawcnyoeyudzrpgslimtkj")
    }

    func test2018day03() {
        let results = Puzzle_2018_03().solveBothParts()
        XCTAssertEqual(results.0, 116920)
        XCTAssertEqual(results.1, 382)
    }
    
    func test2018day04() {
        let part1 = Puzzle_2018_04().solvePart1()
        XCTAssertEqual(part1, 72925)
        let part2 = Puzzle_2018_04().solvePart2()
        XCTAssertEqual(part2, 49137)
    }
    
    func test2018day05() {
        let part1 = Puzzle_2018_05().solvePart1()
        XCTAssertEqual(part1, 9386)
        let part2 = Puzzle_2018_05().solvePart2()
        XCTAssertEqual(part2, 4876)
    }
    
    func test2018day06() {
        let part1 = Puzzle_2018_06().solvePart1()
        XCTAssertEqual(part1, 3290)
        let part2 = Puzzle_2018_06().solvePart2()
        XCTAssertEqual(part2, 45602)
    }
    
    func test2018day07() {
        let part1 = Puzzle_2018_07().solvePart1()
        XCTAssertEqual(part1, "BFKEGNOVATIHXYZRMCJDLSUPWQ")
        let part2 = Puzzle_2018_07().solvePart2()
        XCTAssertEqual(part2, 1020)
    }
    
    func test2018day08() {
        let (part1, part2) = Puzzle_2018_08().solveBothParts()
        XCTAssertEqual(part1, 49426)
        XCTAssertEqual(part2, 40688)
    }
    
}
