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
    
}
