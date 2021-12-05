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
        solvePart1(str: Puzzle_Input.final)
    }

    public func solvePart2() -> Int {
        solvePart2(str: Puzzle_Input.final)
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
