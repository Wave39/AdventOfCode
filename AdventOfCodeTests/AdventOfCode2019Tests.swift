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

    func test2019Puzzles() {
        
        // day 1
        let day01part1 = Puzzle_2019_01().solvePart1(str: Puzzle_2019_01_Input.puzzleInput)
        XCTAssertEqual(day01part1, 3295424)
        let day01part2 = Puzzle_2019_01().solvePart2(str: Puzzle_2019_01_Input.puzzleInput)
        XCTAssertEqual(day01part2, 4940279)
        
        // day 2
        let day02part1 = Puzzle_2019_02().solvePart1(str: Puzzle_2019_02_Input.puzzleInput)
        XCTAssertEqual(day02part1, 3895705)
        let day02part2 = Puzzle_2019_02().solvePart2(str: Puzzle_2019_02_Input.puzzleInput)
        XCTAssertEqual(day02part2, 6417)
        
        // day 3
        let day03part1 = Puzzle_2019_03().solvePart1(str: Puzzle_2019_03_Input.puzzleInput)
        XCTAssertEqual(day03part1, 1225)
        let day03part2 = Puzzle_2019_03().solvePart2(str: Puzzle_2019_03_Input.puzzleInput)
        XCTAssertEqual(day03part2, 107036)

        // day 4
        let day04part1 = Puzzle_2019_04().solvePart1(from: 134564, to: 585159)
        XCTAssertEqual(day04part1, 1929)
        let day04part2 = Puzzle_2019_04().solvePart2(from: 134564, to: 585159)
        XCTAssertEqual(day04part2, 1306)
        
        // day 5
        let day05part1 = Puzzle_2019_05().solvePart1(str: Puzzle_2019_05_Input.puzzleInput)
        XCTAssertEqual(day05part1, 13346482)
        let day05part2 = Puzzle_2019_05().solvePart2(str: Puzzle_2019_05_Input.puzzleInput)
        XCTAssertEqual(day05part2, 12111395)
        
        // day 6
        let day06part1 = Puzzle_2019_06().solvePart1(str: Puzzle_2019_06_Input.puzzleInput)
        XCTAssertEqual(day06part1, 261306)
        let day06part2 = Puzzle_2019_06().solvePart2(str: Puzzle_2019_06_Input.puzzleInput)
        XCTAssertEqual(day06part2, 382)
        
        // day 7
        let day07part1 = Puzzle_2019_07().solvePart1(str: Puzzle_2019_07_Input.puzzleInput, inputSignal: 0)
        XCTAssertEqual(day07part1, 914828)
        let day07part2 = Puzzle_2019_07().solvePart2(str: Puzzle_2019_07_Input.puzzleInput, inputSignal: 0)
        XCTAssertEqual(day07part2, 17956613)
        
        // day 8
        let day08part1 = Puzzle_2019_08().solvePart1(str: Puzzle_2019_08_Input.puzzleInput, imageWidth: 25, imageHeight: 6)
        XCTAssertEqual(day08part1, 1742)
        let day08part2 = Puzzle_2019_08().solvePart2(str: Puzzle_2019_08_Input.puzzleInput, imageWidth: 25, imageHeight: 6)
        XCTAssertEqual(String(day08part2), "011000011010001111100110010010000101000110000100101000000010010101110010010101100001000100100001111010010100100010010000100100111001100001001111010010")
        
    }

}
