//
//  AdventOfCode2020Tests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 11/24/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import XCTest

public class AdventOfCode2020Tests: XCTestCase {
//    override func setUp() {
//    }

//    override func tearDown() {
//    }

    public func test2020day01() {
        let part1 = Puzzle_2020_01().solvePart1()
        XCTAssertEqual(part1, 494_475)
        let part2 = Puzzle_2020_01().solvePart2()
        XCTAssertEqual(part2, 267_520_550)
    }

    public func test2020day02() {
        let part1 = Puzzle_2020_02().solvePart1()
        XCTAssertEqual(part1, 474)
        let part2 = Puzzle_2020_02().solvePart2()
        XCTAssertEqual(part2, 745)
    }

    public func test2020day03() {
        let part1 = Puzzle_2020_03().solvePart1()
        XCTAssertEqual(part1, 200)
        let part2 = Puzzle_2020_03().solvePart2()
        XCTAssertEqual(part2, 3_737_923_200)
    }

    public func test2020day04() {
        let part1 = Puzzle_2020_04().solvePart1()
        XCTAssertEqual(part1, 247)
        let part2 = Puzzle_2020_04().solvePart2()
        XCTAssertEqual(part2, 145)
    }

    public func test2020day05() {
        let part1 = Puzzle_2020_05().solvePart1()
        XCTAssertEqual(part1, 813)
        let part2 = Puzzle_2020_05().solvePart2()
        XCTAssertEqual(part2, 612)
    }

    public func test2020day06() {
        let part1 = Puzzle_2020_06().solvePart1()
        XCTAssertEqual(part1, 6_259)
        let part2 = Puzzle_2020_06().solvePart2()
        XCTAssertEqual(part2, 3_178)
    }

    public func test2020day07() {
        let part1 = Puzzle_2020_07().solvePart1()
        XCTAssertEqual(part1, 242)
        let part2 = Puzzle_2020_07().solvePart2()
        XCTAssertEqual(part2, 176_035)
    }

    public func test2020day08() {
        let part1 = Puzzle_2020_08().solvePart1()
        XCTAssertEqual(part1, 1_797)
        let part2 = Puzzle_2020_08().solvePart2()
        XCTAssertEqual(part2, 1_036)
    }

    public func test2020day09() {
        let part1 = Puzzle_2020_09().solvePart1()
        XCTAssertEqual(part1, 90_433_990)
        let part2 = Puzzle_2020_09().solvePart2()
        XCTAssertEqual(part2, 11_691_646)
    }

    public func test2020day10() {
        let part1 = Puzzle_2020_10().solvePart1()
        XCTAssertEqual(part1, 2_240)
        let part2 = Puzzle_2020_10().solvePart2()
        XCTAssertEqual(part2, 99_214_346_656_768)
    }

    public func test2020day11() {
        let part1 = Puzzle_2020_11().solvePart1()
        XCTAssertEqual(part1, 2_275)
        let part2 = Puzzle_2020_11().solvePart2()
        XCTAssertEqual(part2, 2_121)
    }

    public func test2020day12() {
        let part1 = Puzzle_2020_12().solvePart1()
        XCTAssertEqual(part1, 1_589)
        let part2 = Puzzle_2020_12().solvePart2()
        XCTAssertEqual(part2, 23_960)
    }

    public func test2020day13() {
        let part1 = Puzzle_2020_13().solvePart1()
        XCTAssertEqual(part1, 3_246)
        let part2 = Puzzle_2020_13().solvePart2()
        XCTAssertEqual(part2, 1_010_182_346_291_467)
    }

    public func test2020day14() {
        let part1 = Puzzle_2020_14().solvePart1()
        XCTAssertEqual(part1, 9_628_746_976_360)
        let part2 = Puzzle_2020_14().solvePart2()
        XCTAssertEqual(part2, 4_574_598_714_592)
    }

    public func test2020day15() {
        let part1 = Puzzle_2020_15().solvePart1()
        XCTAssertEqual(part1, 1_025)
        let part2 = Puzzle_2020_15().solvePart2()
        XCTAssertEqual(part2, 129_262)
    }

    public func test2020day16() {
        let part1 = Puzzle_2020_16().solvePart1()
        XCTAssertEqual(part1, 23_054)
        let part2 = Puzzle_2020_16().solvePart2()
        XCTAssertEqual(part2, 51_240_700_105_297)
    }

    public func test2020day17() {
        let part1 = Puzzle_2020_17().solvePart1()
        XCTAssertEqual(part1, 319)
        let part2 = Puzzle_2020_17().solvePart2()
        XCTAssertEqual(part2, 2_324)
    }

    public func test2020day18() {
        let part1 = Puzzle_2020_18().solvePart1()
        XCTAssertEqual(part1, 8_298_263_963_837)
        let part2 = Puzzle_2020_18().solvePart2()
        XCTAssertEqual(part2, 145_575_710_203_332)
    }

    public func test2020day19() {
        let (part1, part2) = Puzzle_2020_19().solveBothParts()
        XCTAssertEqual(part1, 230)
        XCTAssertEqual(part2, 341)
    }

    public func test2020day20() {
        let part1 = Puzzle_2020_20().solvePart1()
        XCTAssertEqual(part1, 64_802_175_715_999)
        let part2 = Puzzle_2020_20().solvePart2()
        XCTAssertEqual(part2, 2_146)
    }

    public func test2020day21() {
        let (part1, part2) = Puzzle_2020_21().solveBothParts()
        XCTAssertEqual(part1, 1_882)
        XCTAssertEqual(part2, "xgtj,ztdctgq,bdnrnx,cdvjp,jdggtft,mdbq,rmd,lgllb")
    }

    public func test2020day22() {
        let part1 = Puzzle_2020_22().solvePart1()
        XCTAssertEqual(part1, 36_257)
        let part2 = Puzzle_2020_22().solvePart2()
        XCTAssertEqual(part2, 33_304)
    }

    public func test2020day23() {
        let part1 = Puzzle_2020_23().solvePart1()
        XCTAssertEqual(part1, "24987653")
        let part2 = Puzzle_2020_23().solvePart2()
        XCTAssertEqual(part2, 442_938_711_161)
    }

    public func test2020day24() {
        let part1 = Puzzle_2020_24().solvePart1()
        XCTAssertEqual(part1, 266)
        let part2 = Puzzle_2020_24().solvePart2()
        XCTAssertEqual(part2, 3_627)
    }

    public func test2020day25() {
        let part1 = Puzzle_2020_25().solvePart1()
        XCTAssertEqual(part1, 19_774_660)
    }
}
