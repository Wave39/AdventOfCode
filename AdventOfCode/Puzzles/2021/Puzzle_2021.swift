//
//  Puzzle_2021.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 11/13/21.
//  Copyright © 2021 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2021 {
    public func solve(puzzleNumber: Int) {
        if puzzleNumber == 1 {
            Puzzle_2021_01().solve()
        } else if puzzleNumber == 2 {
            Puzzle_2021_02().solve()
        } else if puzzleNumber == 3 {
            Puzzle_2021_03().solve()
        } else if puzzleNumber == 4 {
            Puzzle_2021_04().solve()
        } else if puzzleNumber == 5 {
            Puzzle_2021_05().solve()
        } else if puzzleNumber == 6 {
            Puzzle_2021_06().solve()
        } else if puzzleNumber == 7 {
            Puzzle_2021_07().solve()
        } else if puzzleNumber == 8 {
            Puzzle_2021_08().solve()
        } else if puzzleNumber == 9 {
            Puzzle_2021_09().solve()
        } else if puzzleNumber == 10 {
            Puzzle_2021_10().solve()
        } else if puzzleNumber == 11 {
            Puzzle_2021_11().solve()
        } else if puzzleNumber == 12 {
            Puzzle_2021_12().solve()
        } else if puzzleNumber == 13 {
            Puzzle_2021_13().solve()
        } else if puzzleNumber == 14 {
            Puzzle_2021_14().solve()
        } else if puzzleNumber == 15 {
            Puzzle_2021_15().solve()
        } else if puzzleNumber == 16 {
            Puzzle_2021_16().solve()
        } else if puzzleNumber == 17 {
            Puzzle_2021_17().solve()
        } else if puzzleNumber == 18 {
            Puzzle_2021_18().solve()
        } else if puzzleNumber == 19 {
            Puzzle_2021_19().solve()
        } else if puzzleNumber == 20 {
            Puzzle_2021_20().solve()
        } else if puzzleNumber == 21 {
            Puzzle_2021_21().solve()
        } else if puzzleNumber == 22 {
            Puzzle_2021_22().solve()
        } else if puzzleNumber == 23 {
            Puzzle_2021_23().solve()
        } else if puzzleNumber == 24 {
            Puzzle_2021_24().solve()
        } else if puzzleNumber == 25 {
            Puzzle_2021_25().solve()
        } else {
            print("The puzzle number \(puzzleNumber) was not found.")
        }
    }
}

// template for new puzzle classes

public class Puzzle_2021_XX: PuzzleBaseClass {
    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1() -> Int {
        solvePart1(str: Puzzle_Input.test)
    }

    public func solvePart2() -> Int {
        solvePart2(str: Puzzle_Input.test)
    }

    private func solvePart1(str: String) -> Int {
        let arr = str.parseIntoIntArray()
        return arr.count
    }

    private func solvePart2(str: String) -> Int {
        let arr = str.parseIntoIntArray()
        return arr.count
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
Line 1
Line 2
"""

    static let final = """
Line 1
Line 2
"""
}
