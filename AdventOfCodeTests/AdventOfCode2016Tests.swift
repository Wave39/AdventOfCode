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

}
