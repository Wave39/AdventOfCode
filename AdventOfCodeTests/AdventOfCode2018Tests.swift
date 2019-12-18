//
//  AdventOfCode2018Tests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 12/8/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import XCTest

class AdventOfCode2018Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test2018day01() {
        let part1 = Puzzle_2018_01().solvePart1(str: Puzzle_2018_01_Input.puzzleInput)
        XCTAssertEqual(part1, 472)
        let part2 = Puzzle_2018_01().solvePart2(str: Puzzle_2018_01_Input.puzzleInput)
        XCTAssertEqual(part2, 66932)
    }
    
    func test2018day02() {
        let array = Puzzle_2018_02_Input.puzzleInput.parseIntoStringArray()
        let part1 = Puzzle_2018_02().solvePart1(arr: array)
        XCTAssertEqual(part1, 6696)
        let part2 = Puzzle_2018_02().solvePart2(arr: array)
        XCTAssertEqual(part2, "bvnfawcnyoeyudzrpgslimtkj")
    }

}
