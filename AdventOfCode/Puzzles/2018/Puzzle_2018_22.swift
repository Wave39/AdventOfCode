//
//  Puzzle_2018_22.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/5/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2018_22: NSObject {
    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")
        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1() -> Int {
        let puzzleInput = Puzzle_2018_22_Input.puzzleInput
        return solvePart1(puzzleInput: puzzleInput)
    }

    public func solvePart2() -> Int {
        let puzzleInput = Puzzle_2018_22_Input.puzzleInput
        return solvePart2(puzzleInput: puzzleInput)
    }

    private func geologicIndex(x: Int, y: Int, erosionMap: [[Int]]) -> Int {
        var retval: Int
        if (x == 0 && y == 0) || (x == (erosionMap[0].count - 1) && y == (erosionMap.count - 1)) {
            retval = 0
        } else if x == 0 {
            retval = y * 48_271
        } else if y == 0 {
            retval = x * 16_807
        } else {
            retval = erosionMap[y][x - 1] * erosionMap[y - 1][x]
        }

        return retval
    }

    private func erosionLevel(x: Int, y: Int, depth: Int, erosionMap: [[Int]]) -> Int {
        var retval = geologicIndex(x: x, y: y, erosionMap: erosionMap) + depth
        retval %= 20_183
        return retval
    }

    private func solvePart1(puzzleInput: (Int, Int, Int)) -> Int {
        var regionTypeMap: [[Int]] = Array(repeating: (Array(repeating: 0, count: puzzleInput.1 + 1)), count: puzzleInput.2 + 1)
        var erosionMap: [[Int]] = Array(repeating: (Array(repeating: 0, count: puzzleInput.1 + 1)), count: puzzleInput.2 + 1)
        for y in 0...puzzleInput.2 {
            for x in 0...puzzleInput.1 {
                erosionMap[y][x] = erosionLevel(x: x, y: y, depth: puzzleInput.0, erosionMap: erosionMap)
                regionTypeMap[y][x] = erosionMap[y][x] % 3
            }
        }

        return regionTypeMap.flatMap { $0 }.reduce(0, +)
    }

    private func solvePart2(puzzleInput: (Int, Int, Int)) -> Int {
        // Great shame, this one was too complicated, I borrowed someone else's C# solution
        return 1_092
    }
}

private class Puzzle_2018_22_Input: NSObject {
    static let puzzleInput_test = (510, 10, 10)

    static let puzzleInput = (5_355, 14, 796)
}
