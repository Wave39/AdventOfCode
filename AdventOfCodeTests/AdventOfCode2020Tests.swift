//
//  AdventOfCode2020Tests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 11/24/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import XCTest

class AdventOfCode2020Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test2020day01() {
        let part1 = Puzzle_2020_01().solvePart1()
        XCTAssertEqual(part1, 494475)
        let part2 = Puzzle_2020_01().solvePart2()
        XCTAssertEqual(part2, 267520550)
    }
        
    func test2020day02() {
        let part1 = Puzzle_2020_02().solvePart1()
        XCTAssertEqual(part1, 474)
        let part2 = Puzzle_2020_02().solvePart2()
        XCTAssertEqual(part2, 745)
    }
        
    func test2020day03() {
        let part1 = Puzzle_2020_03().solvePart1()
        XCTAssertEqual(part1, 200)
        let part2 = Puzzle_2020_03().solvePart2()
        XCTAssertEqual(part2, 3737923200)
    }
        
    func test2020day04() {
        let part1 = Puzzle_2020_04().solvePart1()
        XCTAssertEqual(part1, 247)
        let part2 = Puzzle_2020_04().solvePart2()
        XCTAssertEqual(part2, 145)
    }
        
    func test2020day05() {
        let part1 = Puzzle_2020_05().solvePart1()
        XCTAssertEqual(part1, 813)
        let part2 = Puzzle_2020_05().solvePart2()
        XCTAssertEqual(part2, 612)
    }
        
    func test2020day06() {
        let part1 = Puzzle_2020_06().solvePart1()
        XCTAssertEqual(part1, 6259)
        let part2 = Puzzle_2020_06().solvePart2()
        XCTAssertEqual(part2, 3178)
    }
        
    func test2020day07() {
        let part1 = Puzzle_2020_07().solvePart1()
        XCTAssertEqual(part1, 242)
        let part2 = Puzzle_2020_07().solvePart2()
        XCTAssertEqual(part2, 176035)
    }
        
    func test2020day08() {
        let part1 = Puzzle_2020_08().solvePart1()
        XCTAssertEqual(part1, 1797)
        let part2 = Puzzle_2020_08().solvePart2()
        XCTAssertEqual(part2, 1036)
    }
        
    func test2020day09() {
        let part1 = Puzzle_2020_09().solvePart1()
        XCTAssertEqual(part1, 90433990)
        let part2 = Puzzle_2020_09().solvePart2()
        XCTAssertEqual(part2, 11691646)
    }
      
    func test2020day10() {
        let part1 = Puzzle_2020_10().solvePart1()
        XCTAssertEqual(part1, 2240)
        let part2 = Puzzle_2020_10().solvePart2()
        XCTAssertEqual(part2, 99214346656768)
    }
    
    func test2020day11() {
        let part1 = Puzzle_2020_11().solvePart1()
        XCTAssertEqual(part1, 2275)
        let part2 = Puzzle_2020_11().solvePart2()
        XCTAssertEqual(part2, 2121)
    }
    
    func test2020day12() {
        let part1 = Puzzle_2020_12().solvePart1()
        XCTAssertEqual(part1, 1589)
        let part2 = Puzzle_2020_12().solvePart2()
        XCTAssertEqual(part2, 23960)
    }
    
    func test2020day13() {
        let part1 = Puzzle_2020_13().solvePart1()
        XCTAssertEqual(part1, 3246)
        let part2 = Puzzle_2020_13().solvePart2()
        XCTAssertEqual(part2, 1010182346291467)
    }
    
    func test2020day14() {
        let part1 = Puzzle_2020_14().solvePart1()
        XCTAssertEqual(part1, 9628746976360)
        let part2 = Puzzle_2020_14().solvePart2()
        XCTAssertEqual(part2, 4574598714592)
    }
    
    func test2020day15() {
        let part1 = Puzzle_2020_15().solvePart1()
        XCTAssertEqual(part1, 1025)
        let part2 = Puzzle_2020_15().solvePart2()
        XCTAssertEqual(part2, 129262)
    }
    
    func test2020day16() {
        let part1 = Puzzle_2020_16().solvePart1()
        XCTAssertEqual(part1, 23054)
        let part2 = Puzzle_2020_16().solvePart2()
        XCTAssertEqual(part2, 51240700105297)
    }
    
    func test2020day17() {
        let part1 = Puzzle_2020_17().solvePart1()
        XCTAssertEqual(part1, 319)
        let part2 = Puzzle_2020_17().solvePart2()
        XCTAssertEqual(part2, 2324)
    }
    
    func test2020day18() {
        let part1 = Puzzle_2020_18().solvePart1()
        XCTAssertEqual(part1, 8298263963837)
        let part2 = Puzzle_2020_18().solvePart2()
        XCTAssertEqual(part2, 145575710203332)
    }
    
    func test2020day19() {
        let (part1, part2) = Puzzle_2020_19().solveBothParts()
        XCTAssertEqual(part1, 230)
        XCTAssertEqual(part2, 341)
    }
    
    func test2020day20() {
        let part1 = Puzzle_2020_20().solvePart1()
        XCTAssertEqual(part1, 64802175715999)
        let part2 = Puzzle_2020_20().solvePart2()
        XCTAssertEqual(part2, 2146)
    }
    
    func test2020day21() {
        let (part1, part2) = Puzzle_2020_21().solveBothParts()
        XCTAssertEqual(part1, 1882)
        XCTAssertEqual(part2, "xgtj,ztdctgq,bdnrnx,cdvjp,jdggtft,mdbq,rmd,lgllb")
    }
    
    func test2020day22() {
        let part1 = Puzzle_2020_22().solvePart1()
        XCTAssertEqual(part1, 36257)
        let part2 = Puzzle_2020_22().solvePart2()
        XCTAssertEqual(part2, 33304)
    }
    
    func test2020day23() {
        let part1 = Puzzle_2020_23().solvePart1()
        XCTAssertEqual(part1, "24987653")
        let part2 = Puzzle_2020_23().solvePart2()
        XCTAssertEqual(part2, 442938711161)
    }
    
    func test2020day24() {
        let part1 = Puzzle_2020_24().solvePart1()
        XCTAssertEqual(part1, 266)
        let part2 = Puzzle_2020_24().solvePart2()
        XCTAssertEqual(part2, 3627)
    }
    
    func test2020day25() {
        let part1 = Puzzle_2020_25().solvePart1()
        XCTAssertEqual(part1, 19774660)
    }
    
}
