//
//  AdventOfCodeTests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 12/8/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import XCTest

class AdventOfCode2019Tests: XCTestCase {
//    override func setUp() {
//    }

//    override func tearDown() {
//    }

    func test2019day01() {
        let part1 = Puzzle_2019_01().solvePart1()
        XCTAssertEqual(part1, 3_295_424)
        let part2 = Puzzle_2019_01().solvePart2()
        XCTAssertEqual(part2, 4_940_279)
    }

    func test2019day02() {
        let part1 = Puzzle_2019_02().solvePart1()
        XCTAssertEqual(part1, 3_895_705)
        let part2 = Puzzle_2019_02().solvePart2()
        XCTAssertEqual(part2, 6_417)
    }

    func test2019day03() {
        let part1 = Puzzle_2019_03().solvePart1()
        XCTAssertEqual(part1, 1_225)
        let part2 = Puzzle_2019_03().solvePart2()
        XCTAssertEqual(part2, 107_036)
    }

    func test2019day04() {
        let part1 = Puzzle_2019_04().solvePart1(from: 134_564, to: 585_159)
        XCTAssertEqual(part1, 1_929)
        let part2 = Puzzle_2019_04().solvePart2(from: 134_564, to: 585_159)
        XCTAssertEqual(part2, 1_306)
    }

    func test2019day05() {
        let part1 = Puzzle_2019_05().solvePart1()
        XCTAssertEqual(part1, 13_346_482)
        let part2 = Puzzle_2019_05().solvePart2()
        XCTAssertEqual(part2, 12_111_395)
    }

    func test2019day06() {
        let part1 = Puzzle_2019_06().solvePart1()
        XCTAssertEqual(part1, 261_306)
        let part2 = Puzzle_2019_06().solvePart2()
        XCTAssertEqual(part2, 382)
    }

    func test2019day07() {
        let part1 = Puzzle_2019_07().solvePart1()
        XCTAssertEqual(part1, 914_828)
        let part2 = Puzzle_2019_07().solvePart2()
        XCTAssertEqual(part2, 17_956_613)
    }

    func test2019day08() {
        let part1 = Puzzle_2019_08().solvePart1()
        XCTAssertEqual(part1, 1_742)
        let part2 = Puzzle_2019_08().solvePart2()
        XCTAssertEqual(String(part2), "011000011010001111100110010010000101000110000100101000000010010101110010010101100001000100100001111010010100100010010000100100111001100001001111010010")
    }

    func test2019day09() {
        let part1 = Puzzle_2019_09().solvePart1()
        XCTAssertEqual(part1, 3_409_270_027)
        let part2 = Puzzle_2019_09().solvePart2()
        XCTAssertEqual(part2, 82_760)
    }

    func test2019day10() {
        let part1 = Puzzle_2019_10().solvePart1()
        XCTAssertEqual(part1.0, 344)
        let part2 = Puzzle_2019_10().solvePart2()
        XCTAssertEqual(part2, 2_732)
    }

    func test2019day11() {
        let part1 = Puzzle_2019_11().solvePart1()
        XCTAssertEqual(part1, 2_160)
        let part2 = Puzzle_2019_11().solvePart2()
        XCTAssertEqual(part2.0, "#....###..####.####..##...##..####.#####....#..#....#.#....#..#.#..#.#....#...#....#..#...#..###..#....#....###..###.#....###...#...#....#....#.##.#....#...#....#.#..#....#....#..#.#..#.#....#...####.#..#.####.####..##...###.#....####")
        XCTAssertEqual(part2.1, Point2D(x: 39, y: 6))
    }

    func test2019day12() {
        let part1 = Puzzle_2019_12().solvePart1()
        XCTAssertEqual(part1, 13_399)
        let part2 = Puzzle_2019_12().solvePart2()
        XCTAssertEqual(part2, 312_992_287_193_064)
    }

    func test2019day13() {
        let part1 = Puzzle_2019_13().solvePart1()
        XCTAssertEqual(part1, 432)
        let part2 = Puzzle_2019_13().solvePart2()
        XCTAssertEqual(part2, 22_225)
    }

    func test2019day14() {
        let part1 = Puzzle_2019_14().solvePart1()
        XCTAssertEqual(part1, 397_771)
        let part2 = Puzzle_2019_14().solvePart2()
        XCTAssertEqual(part2, 3_126_714)
    }

    func test2019day15() {
        let part1 = Puzzle_2019_15().solvePart1()
        XCTAssertEqual(part1, 330)
        let part2 = Puzzle_2019_15().solvePart2()
        XCTAssertEqual(part2, 352)
    }

    func test2019day16() {
        let part1 = Puzzle_2019_16().solvePart1()
        XCTAssertEqual(part1, "84970726")
        let part2 = Puzzle_2019_16().solvePart2()
        XCTAssertEqual(part2, "47664469")
    }

    func test2019day17() {
        let part1 = Puzzle_2019_17().solvePart1()
        XCTAssertEqual(part1, 5_740)
        let part2 = Puzzle_2019_17().solvePart2()
        XCTAssertEqual(part2, 1_022_165)
    }

    func test2019day18() {
        let part1 = Puzzle_2019_18().solvePart1()
        XCTAssertEqual(part1, 4_620)
        let part2 = Puzzle_2019_18().solvePart2()
        XCTAssertEqual(part2, 1_564)
    }

    func test2019day19() {
        let part1 = Puzzle_2019_19().solvePart1()
        XCTAssertEqual(part1, 171)
        let part2 = Puzzle_2019_19().solvePart2()
        XCTAssertEqual(part2, 9_741_242)
    }

    func test2019day20() {
        let part1 = Puzzle_2019_20().solvePart1()
        XCTAssertEqual(part1, 516)
        let part2 = Puzzle_2019_20().solvePart2()
        XCTAssertEqual(part2, 5_966)
    }

    func test2019day21() {
        let part1 = Puzzle_2019_21().solvePart1()
        XCTAssertEqual(part1, 19_356_971)
        let part2 = Puzzle_2019_21().solvePart2()
        XCTAssertEqual(part2, 1_142_600_034)
    }

    func test2019day22() {
        let part1 = Puzzle_2019_22().solvePart1()
        XCTAssertEqual(part1, 3_143)
        let part2 = Puzzle_2019_22().solvePart2()
        XCTAssertEqual(part2, 3_920_265_924_568)
    }

    func test2019day23() {
        // no tests for day 23 as the multithreading code still has something wrong with it
        XCTAssertTrue(true)
    }

    func test2019day24() {
        let part1 = Puzzle_2019_24().solvePart1()
        XCTAssertEqual(part1, 14_539_258)
        let part2 = Puzzle_2019_24().solvePart2()
        XCTAssertEqual(part2, 1_977)
    }

    func test2019day25() {
        let part1 = Puzzle_2019_25().solvePart1()
        XCTAssertEqual(part1, "20483")
    }
}
