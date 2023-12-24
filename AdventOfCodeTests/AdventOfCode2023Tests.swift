//
//  AdventOfCode2023Tests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 12/1/23.
//  Copyright © 2023 Wave 39 LLC. All rights reserved.
//

import XCTest

public class AdventOfCode2023Tests: XCTestCase {
    public func test2023day01() {
        let part1 = Puzzle_2023_01().solvePart1()
        XCTAssertEqual(part1, 55_386)
        let part2 = Puzzle_2023_01().solvePart2()
        XCTAssertEqual(part2, 54_824)
    }

    public func test2023day02() {
        let part1 = Puzzle_2023_02().solvePart1()
        XCTAssertEqual(part1, 2_377)
        let part2 = Puzzle_2023_02().solvePart2()
        XCTAssertEqual(part2, 71_220)
    }

    public func test2023day03() {
        let part1 = Puzzle_2023_03().solvePart1()
        XCTAssertEqual(part1, 521_515)
        let part2 = Puzzle_2023_03().solvePart2()
        XCTAssertEqual(part2, 69_527_306)
    }

    public func test2023day04() {
        let part1 = Puzzle_2023_04().solvePart1()
        XCTAssertEqual(part1, 27_845)
        let part2 = Puzzle_2023_04().solvePart2()
        XCTAssertEqual(part2, 9_496_801)
    }

    public func test2023day05() {
        let part1 = Puzzle_2023_05().solvePart1()
        XCTAssertEqual(part1, 309_796_150)

        // The part 2 test is commented out for now, as it takes far too long.
        // let part2 = Puzzle_2023_05().solvePart2()
        // XCTAssertEqual(part2, 50_716_416)
    }

    public func test2023day06() {
        let part1 = Puzzle_2023_06().solvePart1()
        XCTAssertEqual(part1, 840_336)
        let part2 = Puzzle_2023_06().solvePart2()
        XCTAssertEqual(part2, 41_382_569)
    }

    public func test2023day07() {
        let part1 = Puzzle_2023_07().solvePart1()
        XCTAssertEqual(part1, 253_933_213)
        let part2 = Puzzle_2023_07().solvePart2()
        XCTAssertEqual(part2, 253_473_930)
    }

    public func test2023day08() {
        let part1 = Puzzle_2023_08().solvePart1()
        XCTAssertEqual(part1, 19_951)
        let part2 = Puzzle_2023_08().solvePart2()
        XCTAssertEqual(part2, 16_342_438_708_751)
    }

    public func test2023day09() {
        let part1 = Puzzle_2023_09().solvePart1()
        XCTAssertEqual(part1, 1_789_635_132)
        let part2 = Puzzle_2023_09().solvePart2()
        XCTAssertEqual(part2, 913)
    }

    public func test2023day10() {
        let part1 = Puzzle_2023_10().solvePart1()
        XCTAssertEqual(part1, 7_145)
        let part2 = Puzzle_2023_10().solvePart2()
        XCTAssertEqual(part2, 445)
    }

    public func test2023day11() {
        let part1 = Puzzle_2023_11().solvePart1()
        XCTAssertEqual(part1, 10_313_550)
        let part2 = Puzzle_2023_11().solvePart2()
        XCTAssertEqual(part2, 611_998_089_572)
    }

    public func test2023day12() {
        let part1 = Puzzle_2023_12().solvePart1()
        XCTAssertEqual(part1, 7_195)
        let part2 = Puzzle_2023_12().solvePart2()
        XCTAssertEqual(part2, 33_992_866_292_225)
    }

    public func test2023day13() {
        let part1 = Puzzle_2023_13().solvePart1()
        XCTAssertEqual(part1, 33_195)
        let part2 = Puzzle_2023_13().solvePart2()
        XCTAssertEqual(part2, 31_836)
    }

    public func test2023day14() {
        let part1 = Puzzle_2023_14().solvePart1()
        XCTAssertEqual(part1, 105_003)
        let part2 = Puzzle_2023_14().solvePart2()
        XCTAssertEqual(part2, 93_742)
    }

    public func test2023day15() {
        let part1 = Puzzle_2023_15().solvePart1()
        XCTAssertEqual(part1, 513_214)
        let part2 = Puzzle_2023_15().solvePart2()
        XCTAssertEqual(part2, 258_826)
    }

    public func test2023day16() {
        let part1 = Puzzle_2023_16().solvePart1()
        XCTAssertEqual(part1, 6_902)
        let part2 = Puzzle_2023_16().solvePart2()
        XCTAssertEqual(part2, 7_697)
    }

    public func test2023day17() {
        let part1 = Puzzle_2023_17().solvePart1()
        XCTAssertEqual(part1, 847)
        let part2 = Puzzle_2023_17().solvePart2()
        XCTAssertEqual(part2, 997)
    }

    public func test2023day18() {
        let part1 = Puzzle_2023_18().solvePart1()
        XCTAssertEqual(part1, 56_678)
        let part2 = Puzzle_2023_18().solvePart2()
        XCTAssertEqual(part2, 79_088_855_654_037)
    }

    public func test2023day19() {
        let part1 = Puzzle_2023_19().solvePart1()
        XCTAssertEqual(part1, 492_702)
        let part2 = Puzzle_2023_19().solvePart2()
        XCTAssertEqual(part2, 138_616_621_185_978)
    }

    public func test2023day20() {
        let part1 = Puzzle_2023_20().solvePart1()
        XCTAssertEqual(part1, 787_056_720)
        let part2 = Puzzle_2023_20().solvePart2()
        XCTAssertEqual(part2, 212_986_464_842_911)
    }

    public func test2023day21() {
        let part1 = Puzzle_2023_21().solvePart1()
        XCTAssertEqual(part1, 3_594)
        let part2 = Puzzle_2023_21().solvePart2()
        XCTAssertEqual(part2, 605_247_138_198_755)
    }

    public func test2023day22() {
        let part1 = Puzzle_2023_22().solvePart1()
        XCTAssertEqual(part1, 443)
        let part2 = Puzzle_2023_22().solvePart2()
        XCTAssertEqual(part2, 69_915)
    }

    public func test2023day23() {
        let part1 = Puzzle_2023_23().solvePart1()
        XCTAssertEqual(part1, 2_042)
        let part2 = Puzzle_2023_23().solvePart2()
        XCTAssertEqual(part2, 6_466)
    }

    public func test2023day24() {
        let part1 = Puzzle_2023_24().solvePart1()
        XCTAssertEqual(part1, 16_172)
        let part2 = Puzzle_2023_24().solvePart2()
        XCTAssertEqual(part2, 600_352_360_036_779)
    }

    public func test2023day25() {
        let part1 = Puzzle_2023_25().solvePart1()
        XCTAssertEqual(part1, 2)
        let part2 = Puzzle_2023_25().solvePart2()
        XCTAssertEqual(part2, 2)
    }
}
