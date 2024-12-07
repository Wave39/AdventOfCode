//
//  AdventOfCode2024Tests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 12/3/24.
//  Copyright © 2024 Wave 39 LLC. All rights reserved.
//

import XCTest

final class AdventOfCode2024Tests: XCTestCase {
    public func test2024day01() {
        let part1 = Puzzle_2024_01().solvePart1()
        XCTAssertEqual(part1, 1_189_304)
        let part2 = Puzzle_2024_01().solvePart2()
        XCTAssertEqual(part2, 24_349_736)
    }

    public func test2024day02() {
        let part1 = Puzzle_2024_02().solvePart1()
        XCTAssertEqual(part1, 218)
        let part2 = Puzzle_2024_02().solvePart2()
        XCTAssertEqual(part2, 290)
    }

    public func test2024day03() {
        let part1 = Puzzle_2024_03().solvePart1()
        XCTAssertEqual(part1, 173_529_487)
        let part2 = Puzzle_2024_03().solvePart2()
        XCTAssertEqual(part2, 99_532_691)
    }

}
