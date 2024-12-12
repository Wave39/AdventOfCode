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

    public func test2024day04() {
        let part1 = Puzzle_2024_04().solvePart1()
        XCTAssertEqual(part1, 2_390)
        let part2 = Puzzle_2024_04().solvePart2()
        XCTAssertEqual(part2, 1_809)
    }

    public func test2024day05() {
        let part1 = Puzzle_2024_05().solvePart1()
        XCTAssertEqual(part1, 6_384)
        let part2 = Puzzle_2024_05().solvePart2()
        XCTAssertEqual(part2, 5_353)
    }

    public func test2024day06() {
        let part1 = Puzzle_2024_06().solvePart1()
        XCTAssertEqual(part1, 4_890)
        let part2 = Puzzle_2024_06().solvePart2()
        XCTAssertEqual(part2, 1_995)
    }

    public func test2024day07() {
        let part1 = Puzzle_2024_07().solvePart1()
        XCTAssertEqual(part1, 8_401_132_154_762)
        let part2 = Puzzle_2024_07().solvePart2()
        XCTAssertEqual(part2, 95_297_119_227_552)
    }

    public func test2024day08() {
        let part1 = Puzzle_2024_08().solvePart1()
        XCTAssertEqual(part1, 285)
        let part2 = Puzzle_2024_08().solvePart2()
        XCTAssertEqual(part2, 944)
    }

    public func test2024day09() {
        let part1 = Puzzle_2024_09().solvePart1()
        XCTAssertEqual(part1, 6_461_289_671_426)
        let part2 = Puzzle_2024_09().solvePart2()
        XCTAssertEqual(part2, 6_488_291_456_470)
    }

    public func test2024day10() {
        let part1 = Puzzle_2024_10().solvePart1()
        XCTAssertEqual(part1, 468)
        let part2 = Puzzle_2024_10().solvePart2()
        XCTAssertEqual(part2, 966)
    }

    public func test2024day11() {
        let part1 = Puzzle_2024_11().solvePart1()
        XCTAssertEqual(part1, 203_228)
        let part2 = Puzzle_2024_11().solvePart2()
        XCTAssertEqual(part2, 240_884_656_550_923)
    }

}
