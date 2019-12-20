//
//  AdventOfCodeTests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 12/8/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import XCTest

class AdventOfCode2019Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test2019day01() {
        let part1 = Puzzle_2019_01().solvePart1(str: Puzzle_2019_01_Input.puzzleInput)
        XCTAssertEqual(part1, 3295424)
        let part2 = Puzzle_2019_01().solvePart2(str: Puzzle_2019_01_Input.puzzleInput)
        XCTAssertEqual(part2, 4940279)
    }
    
    func test2019day02() {
        let part1 = Puzzle_2019_02().solvePart1(str: Puzzle_2019_02_Input.puzzleInput)
        XCTAssertEqual(part1, 3895705)
        let part2 = Puzzle_2019_02().solvePart2(str: Puzzle_2019_02_Input.puzzleInput)
        XCTAssertEqual(part2, 6417)
    }
    
    func test2019day03() {
        let part1 = Puzzle_2019_03().solvePart1(str: Puzzle_2019_03_Input.puzzleInput)
        XCTAssertEqual(part1, 1225)
        let part2 = Puzzle_2019_03().solvePart2(str: Puzzle_2019_03_Input.puzzleInput)
        XCTAssertEqual(part2, 107036)
    }
    
    func test2019day04() {
        let part1 = Puzzle_2019_04().solvePart1(from: 134564, to: 585159)
        XCTAssertEqual(part1, 1929)
        let part2 = Puzzle_2019_04().solvePart2(from: 134564, to: 585159)
        XCTAssertEqual(part2, 1306)
    }
    
    func test2019day05() {
        let part1 = Puzzle_2019_05().solvePart1(str: Puzzle_2019_05_Input.puzzleInput)
        XCTAssertEqual(part1, 13346482)
        let part2 = Puzzle_2019_05().solvePart2(str: Puzzle_2019_05_Input.puzzleInput)
        XCTAssertEqual(part2, 12111395)
    }
    
    func test2019day06() {
        let part1 = Puzzle_2019_06().solvePart1(str: Puzzle_2019_06_Input.puzzleInput)
        XCTAssertEqual(part1, 261306)
        let part2 = Puzzle_2019_06().solvePart2(str: Puzzle_2019_06_Input.puzzleInput)
        XCTAssertEqual(part2, 382)
    }
    
    func test2019day07() {
        let part1 = Puzzle_2019_07().solvePart1(str: Puzzle_2019_07_Input.puzzleInput, inputSignal: 0)
        XCTAssertEqual(part1, 914828)
        let part2 = Puzzle_2019_07().solvePart2(str: Puzzle_2019_07_Input.puzzleInput, inputSignal: 0)
        XCTAssertEqual(part2, 17956613)
    }
    
    func test2019day08() {
        let part1 = Puzzle_2019_08().solvePart1(str: Puzzle_2019_08_Input.puzzleInput, imageWidth: 25, imageHeight: 6)
        XCTAssertEqual(part1, 1742)
        let part2 = Puzzle_2019_08().solvePart2(str: Puzzle_2019_08_Input.puzzleInput, imageWidth: 25, imageHeight: 6)
        XCTAssertEqual(String(part2), "011000011010001111100110010010000101000110000100101000000010010101110010010101100001000100100001111010010100100010010000100100111001100001001111010010")
    }
    
    func test2019day09() {
        let part1 = Puzzle_2019_09().solvePart1()
        XCTAssertEqual(part1, 3409270027)
        let part2 = Puzzle_2019_09().solvePart2()
        XCTAssertEqual(part2, 82760)
    }

    func test2019day10() {
        let part1 = Puzzle_2019_10().solvePart1()
        XCTAssertEqual(part1.0, 344)
        let part2 = Puzzle_2019_10().solvePart2()
        XCTAssertEqual(part2, 2732)
    }

    func test2019day11() {
        let part1 = Puzzle_2019_11().solvePart1()
        XCTAssertEqual(part1, 2160)
        let part2 = Puzzle_2019_11().solvePart2()
        XCTAssertEqual(part2.0, "#....###..####.####..##...##..####.#####....#..#....#.#....#..#.#..#.#....#...#....#..#...#..###..#....#....###..###.#....###...#...#....#....#.##.#....#...#....#.#..#....#....#..#.#..#.#....#...####.#..#.####.####..##...###.#....####")
        XCTAssertEqual(part2.1, Point2D(x: 39, y: 6))
    }

    func test2019day12() {
        let part1 = Puzzle_2019_12().solvePart1()
        XCTAssertEqual(part1, 13399)
        let part2 = Puzzle_2019_12().solvePart2()
        XCTAssertEqual(part2, 312992287193064)
    }

    func test2019day13() {
        let part1 = Puzzle_2019_13().solvePart1()
        XCTAssertEqual(part1, 432)
        let part2 = Puzzle_2019_13().solvePart2()
        XCTAssertEqual(part2, 22225)
    }

    func test2019day14() {
        let part1 = Puzzle_2019_14().solvePart1()
        XCTAssertEqual(part1, 397771)
        let part2 = Puzzle_2019_14().solvePart2()
        XCTAssertEqual(part2, 3126714)
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
        XCTAssertEqual(part1, 5740)
        let part2 = Puzzle_2019_17().solvePart2()
        XCTAssertEqual(part2, 1022165)
    }

}
