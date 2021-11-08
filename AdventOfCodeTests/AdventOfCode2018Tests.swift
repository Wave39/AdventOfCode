//
//  AdventOfCode2018Tests.swift
//  AdventOfCodeTests
//
//  Created by Brian Prescott on 12/8/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import XCTest

class AdventOfCode2018Tests: XCTestCase {
//    override func setUp() {
//    }

//    override func tearDown() {
//    }

    func test2018day01() {
        let part1 = Puzzle_2018_01().solvePart1()
        XCTAssertEqual(part1, 472)
        let part2 = Puzzle_2018_01().solvePart2()
        XCTAssertEqual(part2, 66_932)
    }

    func test2018day02() {
        let part1 = Puzzle_2018_02().solvePart1()
        XCTAssertEqual(part1, 6_696)
        let part2 = Puzzle_2018_02().solvePart2()
        XCTAssertEqual(part2, "bvnfawcnyoeyudzrpgslimtkj")
    }

    func test2018day03() {
        let results = Puzzle_2018_03().solveBothParts()
        XCTAssertEqual(results.0, 116_920)
        XCTAssertEqual(results.1, 382)
    }

    func test2018day04() {
        let part1 = Puzzle_2018_04().solvePart1()
        XCTAssertEqual(part1, 72_925)
        let part2 = Puzzle_2018_04().solvePart2()
        XCTAssertEqual(part2, 49_137)
    }

    func test2018day05() {
        let part1 = Puzzle_2018_05().solvePart1()
        XCTAssertEqual(part1, 9_386)
        let part2 = Puzzle_2018_05().solvePart2()
        XCTAssertEqual(part2, 4_876)
    }

    func test2018day06() {
        let part1 = Puzzle_2018_06().solvePart1()
        XCTAssertEqual(part1, 3_290)
        let part2 = Puzzle_2018_06().solvePart2()
        XCTAssertEqual(part2, 45_602)
    }

    func test2018day07() {
        let part1 = Puzzle_2018_07().solvePart1()
        XCTAssertEqual(part1, "BFKEGNOVATIHXYZRMCJDLSUPWQ")
        let part2 = Puzzle_2018_07().solvePart2()
        XCTAssertEqual(part2, 1_020)
    }

    func test2018day08() {
        let (part1, part2) = Puzzle_2018_08().solveBothParts()
        XCTAssertEqual(part1, 49_426)
        XCTAssertEqual(part2, 40_688)
    }

    func test2018day09() {
        let part1 = Puzzle_2018_09().solvePart1()
        XCTAssertEqual(part1, 367_634)
        let part2 = Puzzle_2018_09().solvePart2()
        XCTAssertEqual(part2, 3_020_072_891)
    }

    func test2018day10() {
        let results = Puzzle_2018_10().solveBothParts()
        XCTAssertEqual(results.0, "#....#..#####...#....#..######..######..#....#...####......###\n##...#..#....#..#....#..#............#..#....#..#....#......#.\n##...#..#....#..#....#..#............#..#....#..#...........#.\n#.#..#..#....#..#....#..#...........#...#....#..#...........#.\n#.#..#..#####...######..#####......#....######..#...........#.\n#..#.#..#....#..#....#..#.........#.....#....#..#...........#.\n#..#.#..#....#..#....#..#........#......#....#..#...........#.\n#...##..#....#..#....#..#.......#.......#....#..#.......#...#.\n#...##..#....#..#....#..#.......#.......#....#..#....#..#...#.\n#....#..#####...#....#..######..######..#....#...####....###..\n")
        XCTAssertEqual(results.1, 10_558)
    }

    func test2018day11() {
        let part1 = Puzzle_2018_11().solvePart1()
        XCTAssertEqual(part1.0, 243)
        XCTAssertEqual(part1.1, 49)
        let part2 = Puzzle_2018_11().solvePart2()
        XCTAssertEqual(part2.0, 285)
        XCTAssertEqual(part2.1, 169)
        XCTAssertEqual(part2.2, 15)
    }

    func test2018day12() {
        let part1 = Puzzle_2018_12().solvePart1()
        XCTAssertEqual(part1, 3_494)
        let part2 = Puzzle_2018_12().solvePart2()
        XCTAssertEqual(part2, 2_850_000_002_454)
    }

    func test2018day13() {
        let (part1, part2) = Puzzle_2018_13().solveBothParts()
        XCTAssertEqual(part1.0, 32)
        XCTAssertEqual(part1.1, 8)
        XCTAssertEqual(part2.0, 38)
        XCTAssertEqual(part2.1, 38)
    }

    func test2018day14() {
        let (part1, part2) = Puzzle_2018_14().solveBothParts()
        XCTAssertEqual(part1, "1191216109")
        XCTAssertEqual(part2, 20_268_576)
    }

    func test2018day15() {
        // no tests for day 15 as I ripped off someone else's code to get the solution
        XCTAssertTrue(true)
    }

    func test2018day16() {
        let (part1, part2) = Puzzle_2018_16().solveBothParts()
        XCTAssertEqual(part1, 588)
        XCTAssertEqual(part2, 627)
    }

    func test2018day17() {
        // no tests for day 17 as I ripped off someone else's code to get the solution
        XCTAssertTrue(true)
    }

    func test2018day18() {
        let (part1, part2) = Puzzle_2018_18().solveBothParts()
        XCTAssertEqual(part1, 483_840)
        XCTAssertEqual(part2, 219_919)
    }

    func test2018day19() {
        let part1 = Puzzle_2018_19().solvePart1()
        XCTAssertEqual(part1, 978)
        let part2 = Puzzle_2018_19().solvePart2()
        XCTAssertEqual(part2, 10_996_992)
    }

    func test2018day20() {
        let (part1, part2) = Puzzle_2018_20().solveBothParts()
        XCTAssertEqual(part1, 3_699)
        XCTAssertEqual(part2, 8_517)
    }

    func test2018day21() {
        let part1 = Puzzle_2018_21().solvePart1()
        XCTAssertEqual(part1, 8_797_248)
        // do not test part 2, it takes way too long to run
    }

    func test2018day22() {
        let part1 = Puzzle_2018_22().solvePart1()
        XCTAssertEqual(part1, 11_972)
        // do not test part 2, I borrowed someone else's solution
    }

    func test2018day23() {
        let part1 = Puzzle_2018_23().solvePart1()
        XCTAssertEqual(part1, 580)
        // do not test part 2, I borrowed someone else's solution
    }

    func test2018day24() {
        // no tests for day 24 as I ripped off someone else's code to get the solution
        XCTAssertTrue(true)
    }

    func test2018day25() {
        let part1 = Puzzle_2018_25().solvePart1()
        XCTAssertEqual(part1, 430)
    }
}
