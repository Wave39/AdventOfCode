//
//  Puzzle_2020_15.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/15/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2020_15: PuzzleBaseClass {
    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1() -> Int {
        solvePart1(str: Puzzle_Input.puzzleInput)
    }

    public func solvePart2() -> Int {
        solvePart2(str: Puzzle_Input.puzzleInput)
    }

    private func solve(str: String, turns: Int) -> Int {
        let arr = str.parseIntoIntArray(separator: ",")
        var dict: Dictionary<Int, [Int]> = [:]
        for idx in 0..<arr.count {
            dict[arr[idx]] = [ idx + 1 ]
        }

        var lastNumber = arr.last ?? 0
        var lastNumberNew = true
        var turnNumber = arr.count + 1
        while turnNumber <= turns {
            let numberSpoken: Int
            if lastNumberNew {
                numberSpoken = 0
            } else {
                let x = dict[lastNumber] ?? []
                let count = x.count
                numberSpoken = x[count - 1] - x[count - 2]
            }

            if dict[numberSpoken] == nil {
                lastNumberNew = true
                dict[numberSpoken] = []
            } else {
                lastNumberNew = false
            }

            dict[numberSpoken]?.append(turnNumber)
            lastNumber = numberSpoken
            turnNumber += 1
        }

        return lastNumber
    }

    private func solvePart1(str: String) -> Int {
        solve(str: str, turns: 2_020)
    }

    private func solvePart2(str: String) -> Int {
        solve(str: str, turns: 30_000_000)
    }
}

private class Puzzle_Input: NSObject {
    static let puzzleInput_test = """
0,3,6
"""

    static let puzzleInput = """
0,20,7,16,1,18,15
"""
}
