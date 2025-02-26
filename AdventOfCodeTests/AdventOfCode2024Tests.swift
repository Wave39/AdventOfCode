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

    public func test2024day12() {
        let part1 = Puzzle_2024_12().solvePart1()
        XCTAssertEqual(part1, 1_473_408)
        let part2 = Puzzle_2024_12().solvePart2()
        XCTAssertEqual(part2, 886_364)
    }

    public func test2024day13() {
        let part1 = Puzzle_2024_13().solvePart1()
        XCTAssertEqual(part1, 39_996)
        let part2 = Puzzle_2024_13().solvePart2()
        XCTAssertEqual(part2, 73_267_584_326_867)
    }

    public func test2024day14() {
        let part1 = Puzzle_2024_14().solvePart1()
        XCTAssertEqual(part1, 230_435_667)
        let part2 = Puzzle_2024_14().solvePart2()
        XCTAssertEqual(part2, 7_709)
    }

    public func test2024day15() {
        let part1 = Puzzle_2024_15().solvePart1()
        XCTAssertEqual(part1, 1_398_947)
        let part2 = Puzzle_2024_15().solvePart2()
        XCTAssertEqual(part2, 1_397_393)
    }

    public func test2024day16() {
        let part1 = Puzzle_2024_16().solvePart1()
        XCTAssertEqual(part1, 143_580)
        let part2 = Puzzle_2024_16().solvePart2()
        XCTAssertEqual(part2, 645)
    }

    public func test2024day17() {
        let part1 = Puzzle_2024_17().solvePart1()
        XCTAssertEqual(part1, "2,1,0,1,7,2,5,0,3")
        let part2 = Puzzle_2024_17().solvePart2()
        XCTAssertEqual(part2, 267_265_166_222_235)
    }

    public func test2024day18() {
        let part1 = Puzzle_2024_18().solvePart1()
        XCTAssertEqual(part1, 294)
        let part2 = Puzzle_2024_18().solvePart2()
        XCTAssertEqual(part2.0, 31)
        XCTAssertEqual(part2.1, 22)
    }

    public func test2024day19() {
        let part1 = Puzzle_2024_19().solvePart1()
        XCTAssertEqual(part1, 296)
        let part2 = Puzzle_2024_19().solvePart2()
        XCTAssertEqual(part2, 619_970_556_776_002)
    }

    public func test2024day20() {
        let part1 = Puzzle_2024_20().solvePart1()
        XCTAssertEqual(part1, 1_426)
        let part2 = Puzzle_2024_20().solvePart2()
        XCTAssertEqual(part2, 1_000_697)
    }

    public func test2024day21() {
        let part1 = Puzzle_2024_21().solvePart1()
        XCTAssertEqual(part1, 107_934)
        let part2 = Puzzle_2024_21().solvePart2()
        XCTAssertEqual(part2, 130_470_079_151_124)
    }

    public func test2024day22() {
        let part1 = Puzzle_2024_22().solvePart1()
        XCTAssertEqual(part1, 19_458_130_434)
        let part2 = Puzzle_2024_22().solvePart2()
        XCTAssertEqual(part2, 2_130)
    }

    public func test2024day23() {
        let part1 = Puzzle_2024_23().solvePart1()
        XCTAssertEqual(part1, 1_046)
        let part2 = Puzzle_2024_23().solvePart2()
        XCTAssertEqual(part2, "de,id,ke,ls,po,sn,tf,tl,tm,uj,un,xw,yz")
    }

    public func test2024day24() {
        let part1 = Puzzle_2024_24().solvePart1()
        XCTAssertEqual(part1, 65_635_066_541_798)
        let part2 = Puzzle_2024_24().solvePart2()
        XCTAssertEqual(part2, "dgr,dtv,fgc,mtj,vvm,z12,z29,z37")
    }

    public func test2024day25() {
        let part1 = Puzzle_2024_25().solvePart1()
        XCTAssertEqual(part1, 2_885)
    }
}
