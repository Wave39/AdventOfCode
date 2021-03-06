//
//  AdventOfCode2016Tests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 2/8/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import XCTest

class AdventOfCode2016Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test2016day01() {
        let (part1, part2) = Puzzle_2016_01().solveBothParts()
        XCTAssertEqual(part1, 287)
        XCTAssertEqual(part2, 133)
    }

    func test2016day02() {
        let (part1, part2) = Puzzle_2016_02().solveBothParts()
        XCTAssertEqual(part1, "53255")
        XCTAssertEqual(part2, "7423A")
    }

    func test2016day03() {
        let (part1, part2) = Puzzle_2016_03().solveBothParts()
        XCTAssertEqual(part1, 917)
        XCTAssertEqual(part2, 1649)
    }

    func test2016day04() {
        let (part1, part2) = Puzzle_2016_04().solveBothParts()
        XCTAssertEqual(part1, 278221)
        XCTAssertEqual(part2, 267)
    }

    func test2016day05() {
        let (part1, part2) = Puzzle_2016_05().solveBothParts()
        XCTAssertEqual(part1, "2414bc77")
        XCTAssertEqual(part2, "437e60fc")
    }

    func test2016day06() {
        let (part1, part2) = Puzzle_2016_06().solveBothParts()
        XCTAssertEqual(part1, "dzqckwsd")
        XCTAssertEqual(part2, "lragovly")
    }

    func test2016day07() {
        let (part1, part2) = Puzzle_2016_07().solveBothParts()
        XCTAssertEqual(part1, 118)
        XCTAssertEqual(part2, 260)
    }

    func test2016day08() {
        let (part1, part2) = Puzzle_2016_08().solveBothParts()
        XCTAssertEqual(part1, 123)
        XCTAssertEqual(part2, ".##..####.###..#..#.###..####.###....##.###...###.\n#..#.#....#..#.#..#.#..#....#.#..#....#.#..#.#....\n#..#.###..###..#..#.#..#...#..###.....#.#..#.#....\n####.#....#..#.#..#.###...#...#..#....#.###...##..\n#..#.#....#..#.#..#.#....#....#..#.#..#.#.......#.\n#..#.#....###...##..#....####.###...##..#....###..\n")
    }

    func test2016day09() {
        let (part1, part2) = Puzzle_2016_09().solveBothParts()
        XCTAssertEqual(part1, 99145)
        XCTAssertEqual(part2, 10943094568)
    }

    func test2016day10() {
        let (part1, part2) = Puzzle_2016_10().solveBothParts()
        XCTAssertEqual(part1, 181)
        XCTAssertEqual(part2, 12567)
    }

    func test2016day11() {
        let (part1, part2) = Puzzle_2016_11().solveBothParts()
        XCTAssertEqual(part1, 33)
        XCTAssertEqual(part2, 57)
    }

    func test2016day12() {
        let (part1, part2) = Puzzle_2016_12().solveBothParts()
        XCTAssertEqual(part1, 318077)
        XCTAssertEqual(part2, 9227731)
    }

    func test2016day13() {
        let (part1, part2) = Puzzle_2016_13().solveBothParts()
        XCTAssertEqual(part1, 86)
        XCTAssertEqual(part2, 127)
    }

    func test2016day14() {
        let (part1, part2) = Puzzle_2016_14().solveBothParts()
        XCTAssertEqual(part1, 15168)
        XCTAssertEqual(part2, 20864)
    }

    func test2016day15() {
        let (part1, part2) = Puzzle_2016_15().solveBothParts()
        XCTAssertEqual(part1, 203660)
        XCTAssertEqual(part2, 2408135)
    }

    func test2016day16() {
        let (part1, part2) = Puzzle_2016_16().solveBothParts()
        XCTAssertEqual(part1, "10010101010011101")
        XCTAssertEqual(part2, "01100111101101111")
    }

    func test2016day17() {
        let (part1, part2) = Puzzle_2016_17().solveBothParts()
        XCTAssertEqual(part1, "DRRDRLDURD")
        XCTAssertEqual(part2, 618)
    }

    func test2016day18() {
        let (part1, part2) = Puzzle_2016_18().solveBothParts()
        XCTAssertEqual(part1, 1982)
        XCTAssertEqual(part2, 20005203)
    }

    func test2016day19() {
        let (part1, part2) = Puzzle_2016_19().solveBothParts()
        XCTAssertEqual(part1, 1815603)
        XCTAssertEqual(part2, 1410630)
    }

    func test2016day20() {
        let (part1, part2) = Puzzle_2016_20().solveBothParts()
        XCTAssertEqual(part1, 4793564)
        XCTAssertEqual(part2, 146)
    }

    func test2016day21() {
        let (part1, part2) = Puzzle_2016_21().solveBothParts()
        XCTAssertEqual(part1, "gfdhebac")
        XCTAssertEqual(part2, "dhaegfbc")
    }

    func test2016day22() {
        let (part1, part2) = Puzzle_2016_22().solveBothParts()
        XCTAssertEqual(part1, 950)
        XCTAssertEqual(part2, 256)
    }

    func test2016day23() {
        let (part1, part2) = Puzzle_2016_23().solveBothParts()
        XCTAssertEqual(part1, 13958)
        XCTAssertEqual(part2, 479010518)
    }

    func test2016day24() {
        let (part1, part2) = Puzzle_2016_24().solveBothParts()
        XCTAssertEqual(part1, 456)
        XCTAssertEqual(part2, 704)
    }

    func test2016day25() {
        let part1 = Puzzle_2016_25().solvePart1()
        XCTAssertEqual(part1, 192)
    }

}
