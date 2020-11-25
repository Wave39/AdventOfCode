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
        XCTAssertEqual(part1, 2)
        let part2 = Puzzle_2020_01().solvePart2()
        XCTAssertEqual(part2, 2)
    }
        
}
