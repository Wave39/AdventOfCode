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

}
