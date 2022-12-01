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
}
