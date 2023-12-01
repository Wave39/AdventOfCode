//
//  AdventOfCode2023Tests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 12/1/23.
//  Copyright © 2023 Wave 39 LLC. All rights reserved.
//

import XCTest

final class AdventOfCode2023Tests: XCTestCase {

    public func test2023day01() {
        let part1 = Puzzle_2023_01().solvePart1()
        XCTAssertEqual(part1, 55_386)
        let part2 = Puzzle_2023_01().solvePart2()
        XCTAssertEqual(part2, 54_824)
    }

}
