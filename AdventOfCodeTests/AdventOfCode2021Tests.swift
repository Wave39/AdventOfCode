//
//  AdventOfCode2021Tests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 11/13/21.
//  Copyright © 2021 Wave 39 LLC. All rights reserved.
//

import XCTest

public class AdventOfCode2021Tests: XCTestCase {
//    override func setUp() {
//    }

//    override func tearDown() {
//    }

    public func test2021day01() {
        let part1 = Puzzle_2021_01().solvePart1()
        XCTAssertEqual(part1, 1_446)
        let part2 = Puzzle_2021_01().solvePart2()
        XCTAssertEqual(part2, 1_486)
    }

    public func test2021day02() {
        let part1 = Puzzle_2021_02().solvePart1()
        XCTAssertEqual(part1, 1_635_930)
        let part2 = Puzzle_2021_02().solvePart2()
        XCTAssertEqual(part2, 1_781_819_478)
    }

    public func test2021day03() {
        let part1 = Puzzle_2021_03().solvePart1()
        XCTAssertEqual(part1, 2_250_414)
        let part2 = Puzzle_2021_03().solvePart2()
        XCTAssertEqual(part2, 6_085_575)
    }

    public func test2021day04() {
        let part1 = Puzzle_2021_04().solvePart1()
        XCTAssertEqual(part1, 8_136)
        let part2 = Puzzle_2021_04().solvePart2()
        XCTAssertEqual(part2, 12_738)
    }

    public func test2021day05() {
        let part1 = Puzzle_2021_05().solvePart1()
        XCTAssertEqual(part1, 5_084)
        let part2 = Puzzle_2021_05().solvePart2()
        XCTAssertEqual(part2, 17_882)
    }

    public func test2021day06() {
        let part1 = Puzzle_2021_06().solvePart1()
        XCTAssertEqual(part1, 390_011)
        let part2 = Puzzle_2021_06().solvePart2()
        XCTAssertEqual(part2, 1_746_710_169_834)
    }

    public func test2021day07() {
        let part1 = Puzzle_2021_07().solvePart1()
        XCTAssertEqual(part1, 340_987)
        let part2 = Puzzle_2021_07().solvePart2()
        XCTAssertEqual(part2, 96_987_874)
    }

    public func test2021day08() {
        let part1 = Puzzle_2021_08().solvePart1()
        XCTAssertEqual(part1, 369)
        let part2 = Puzzle_2021_08().solvePart2()
        XCTAssertEqual(part2, 1_031_553)
    }

    public func test2021day09() {
        let part1 = Puzzle_2021_09().solvePart1()
        XCTAssertEqual(part1, 541)
        let part2 = Puzzle_2021_09().solvePart2()
        XCTAssertEqual(part2, 847_504)
    }

    public func test2021day10() {
        let part1 = Puzzle_2021_10().solvePart1()
        XCTAssertEqual(part1, 390_993)
        let part2 = Puzzle_2021_10().solvePart2()
        XCTAssertEqual(part2, 2_391_385_187)
    }

    public func test2021day11() {
        let part1 = Puzzle_2021_11().solvePart1()
        XCTAssertEqual(part1, 1_640)
        let part2 = Puzzle_2021_11().solvePart2()
        XCTAssertEqual(part2, 312)
    }

    public func test2021day12() {
        let part1 = Puzzle_2021_12().solvePart1()
        XCTAssertEqual(part1, 5_212)
        let part2 = Puzzle_2021_12().solvePart2()
        XCTAssertEqual(part2, 134_862)
    }

    public func test2021day13() {
        let (part1, part2String, _) = Puzzle_2021_13().solveBothParts()
        XCTAssertEqual(part1, 785)
        XCTAssertEqual(part2String, "####...##..##..#..#...##..##...##..#..#.#.......#.#..#.#..#....#.#..#.#..#.#..#.###.....#.#..#.####....#.#....#..#.####.#.......#.####.#..#....#.#.##.####.#..#.#....#..#.#..#.#..#.#..#.#..#.#..#.#..#.#.....##..#..#.#..#..##...###.#..#.#..#.")
    }

    public func test2021day14() {
        let part1 = Puzzle_2021_14().solvePart1()
        XCTAssertEqual(part1, 3_048)
        let part2 = Puzzle_2021_14().solvePart2()
        XCTAssertEqual(part2, 3_288_891_573_057)
    }

    public func test2021day15() {
        let part1 = Puzzle_2021_15().solvePart1()
        XCTAssertEqual(part1, 393)
        let part2 = Puzzle_2021_15().solvePart2()
        XCTAssertEqual(part2, 2_823)
    }

    public func test2021day16() {
        let part1 = Puzzle_2021_16().solvePart1()
        XCTAssertEqual(part1, 977)
        let part2 = Puzzle_2021_16().solvePart2()
        XCTAssertEqual(part2, 101_501_020_883)
    }

    public func test2021day17() {
        let part1 = Puzzle_2021_17().solvePart1()
        XCTAssertEqual(part1, 6_903)
        let part2 = Puzzle_2021_17().solvePart2()
        XCTAssertEqual(part2, 2_351)
    }

    public func test2021day18() {
        let part1 = Puzzle_2021_18().solvePart1()
        XCTAssertEqual(part1, 4_145)
        let part2 = Puzzle_2021_18().solvePart2()
        XCTAssertEqual(part2, 4_855)
    }

    public func test2021day19() {
        let part1 = Puzzle_2021_19().solvePart1()
        XCTAssertEqual(part1, 2)
        let part2 = Puzzle_2021_19().solvePart2()
        XCTAssertEqual(part2, 2)
    }

    public func test2021day20() {
        let part1 = Puzzle_2021_20().solvePart1()
        XCTAssertEqual(part1, 2)
        let part2 = Puzzle_2021_20().solvePart2()
        XCTAssertEqual(part2, 2)
    }

    public func test2021day21() {
        let part1 = Puzzle_2021_21().solvePart1()
        XCTAssertEqual(part1, 2)
        let part2 = Puzzle_2021_21().solvePart2()
        XCTAssertEqual(part2, 2)
    }

    public func test2021day22() {
        let part1 = Puzzle_2021_22().solvePart1()
        XCTAssertEqual(part1, 2)
        let part2 = Puzzle_2021_22().solvePart2()
        XCTAssertEqual(part2, 2)
    }

    public func test2021day23() {
        let part1 = Puzzle_2021_23().solvePart1()
        XCTAssertEqual(part1, 2)
        let part2 = Puzzle_2021_23().solvePart2()
        XCTAssertEqual(part2, 2)
    }

    public func test2021day24() {
        let part1 = Puzzle_2021_24().solvePart1()
        XCTAssertEqual(part1, 2)
        let part2 = Puzzle_2021_24().solvePart2()
        XCTAssertEqual(part2, 2)
    }

    public func test2021day25() {
        let part1 = Puzzle_2021_25().solvePart1()
        XCTAssertEqual(part1, 2)
        let part2 = Puzzle_2021_25().solvePart2()
        XCTAssertEqual(part2, 2)
    }
}
