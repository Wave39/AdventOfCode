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

    public func test2022day02() {
        let part1 = Puzzle_2022_02().solvePart1()
        XCTAssertEqual(part1, 11_475)
        let part2 = Puzzle_2022_02().solvePart2()
        XCTAssertEqual(part2, 16_862)
    }

    public func test2022day03() {
        let part1 = Puzzle_2022_03().solvePart1()
        XCTAssertEqual(part1, 8_123)
        let part2 = Puzzle_2022_03().solvePart2()
        XCTAssertEqual(part2, 2_620)
    }

    public func test2022day04() {
        let part1 = Puzzle_2022_04().solvePart1()
        XCTAssertEqual(part1, 500)
        let part2 = Puzzle_2022_04().solvePart2()
        XCTAssertEqual(part2, 815)
    }

    public func test2022day05() {
        let part1 = Puzzle_2022_05().solvePart1()
        XCTAssertEqual(part1, "TLFGBZHCN")
        let part2 = Puzzle_2022_05().solvePart2()
        XCTAssertEqual(part2, "QRQFHFWCL")
    }

    public func test2022day06() {
        let part1 = Puzzle_2022_06().solvePart1()
        XCTAssertEqual(part1, 1_262)
        let part2 = Puzzle_2022_06().solvePart2()
        XCTAssertEqual(part2, 3_444)
    }

    public func test2022day07() {
        let part1 = Puzzle_2022_07().solvePart1()
        XCTAssertEqual(part1, 1_315_285)
        let part2 = Puzzle_2022_07().solvePart2()
        XCTAssertEqual(part2, 9_847_279)
    }

    public func test2022day08() {
        let part1 = Puzzle_2022_08().solvePart1()
        XCTAssertEqual(part1, 1_690)
        let part2 = Puzzle_2022_08().solvePart2()
        XCTAssertEqual(part2, 535_680)
    }

    public func test2022day09() {
        let part1 = Puzzle_2022_09().solvePart1()
        XCTAssertEqual(part1, 6_357)
        let part2 = Puzzle_2022_09().solvePart2()
        XCTAssertEqual(part2, 2_627)
    }

    public func test2022day10() {
        let part1 = Puzzle_2022_10().solvePart1()
        XCTAssertEqual(part1, 15_360)
        let part2 = Puzzle_2022_10().solvePart2()
        XCTAssertEqual(part2, "###..#..#.#....#..#...##..##..####..##..\n#..#.#..#.#....#..#....#.#..#....#.#..#.\n#..#.####.#....####....#.#......#..#..#.\n###..#..#.#....#..#....#.#.##..#...####.\n#....#..#.#....#..#.#..#.#..#.#....#..#.\n#....#..#.####.#..#..##...###.####.#..#.")
    }

    public func test2022day11() {
        let part1 = Puzzle_2022_11().solvePart1()
        XCTAssertEqual(part1, 72_884)
        let part2 = Puzzle_2022_11().solvePart2()
        XCTAssertEqual(part2, 15_310_845_153)
    }

    public func test2022day12() {
        let part1 = Puzzle_2022_12().solvePart1()
        XCTAssertEqual(part1, 394)
        let part2 = Puzzle_2022_12().solvePart2()
        XCTAssertEqual(part2, 388)
    }

    public func test2022day13() {
        let part1 = Puzzle_2022_13().solvePart1()
        XCTAssertEqual(part1, 5_503)
        let part2 = Puzzle_2022_13().solvePart2()
        XCTAssertEqual(part2, 20_952)
    }

    public func test2022day14() {
        let part1 = Puzzle_2022_14().solvePart1()
        XCTAssertEqual(part1, 768)
        let part2 = Puzzle_2022_14().solvePart2()
        XCTAssertEqual(part2, 26_686)
    }

    public func test2022day15() {
        let part1 = Puzzle_2022_15().solvePart1()
        XCTAssertEqual(part1, 5_870_800)
        let part2 = Puzzle_2022_15().solvePart2()
        XCTAssertEqual(part2, 10_908_230_916_597)
    }

    public func test2022day16() {
        let part1 = Puzzle_2022_16().solvePart1()
        XCTAssertEqual(part1, 2)
        let part2 = Puzzle_2022_16().solvePart2()
        XCTAssertEqual(part2, 2)
    }

    public func test2022day17() {
        let part1 = Puzzle_2022_17().solvePart1()
        XCTAssertEqual(part1, 2)
        let part2 = Puzzle_2022_17().solvePart2()
        XCTAssertEqual(part2, 2)
    }

    public func test2022day18() {
        let part1 = Puzzle_2022_18().solvePart1()
        XCTAssertEqual(part1, 4_608)
        let part2 = Puzzle_2022_18().solvePart2()
        XCTAssertEqual(part2, 2_652)
    }

    public func test2022day19() {
        let part1 = Puzzle_2022_19().solvePart1()
        XCTAssertEqual(part1, 2)
        let part2 = Puzzle_2022_19().solvePart2()
        XCTAssertEqual(part2, 2)
    }

    public func test2022day20() {
        let part1 = Puzzle_2022_20().solvePart1()
        XCTAssertEqual(part1, 2)
        let part2 = Puzzle_2022_20().solvePart2()
        XCTAssertEqual(part2, 2)
    }

    public func test2022day21() {
        let part1 = Puzzle_2022_21().solvePart1()
        XCTAssertEqual(part1, 54_703_080_378_102)
        let part2 = Puzzle_2022_21().solvePart2()
        XCTAssertEqual(part2, 3_952_673_930_912)
    }

    public func test2022day22() {
        let part1 = Puzzle_2022_22().solvePart1()
        XCTAssertEqual(part1, 126_350)
        let part2 = Puzzle_2022_22().solvePart2()
        XCTAssertEqual(part2, 129_339)
    }

    public func test2022day23() {
        let part1 = Puzzle_2022_23().solvePart1()
        XCTAssertEqual(part1, 4_052)
        let part2 = Puzzle_2022_23().solvePart2()
        XCTAssertEqual(part2, 978)
    }

    public func test2022day24() {
        let part1 = Puzzle_2022_24().solvePart1()
        XCTAssertEqual(part1, 2)
        let part2 = Puzzle_2022_24().solvePart2()
        XCTAssertEqual(part2, 2)
    }

    public func test2022day25() {
        let part1 = Puzzle_2022_25().solvePart1()
        XCTAssertEqual(part1, 2)
        let part2 = Puzzle_2022_25().solvePart2()
        XCTAssertEqual(part2, 2)
    }
}
