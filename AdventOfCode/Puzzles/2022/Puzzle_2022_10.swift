//
//  Puzzle_2022_10.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/8/22.
//  Copyright © 2022 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2022_10: PuzzleBaseClass {
    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \n\(part2)")
    }

    public func solvePart1() -> Int {
        solvePart1(str: Puzzle_Input.final)
    }

    public func solvePart2() -> String {
        solvePart2(str: Puzzle_Input.final)
    }

    private func getCycleArray(str: String) -> [Int] {
        let lines = str.parseIntoStringArray()
        var cycleArray: [Int] = []
        var xRegister = 1
        for line in lines {
            let arr = line.parseIntoStringArray(separator: " ")
            if arr[0] == "addx" {
                cycleArray.append(xRegister)
                cycleArray.append(xRegister)
                xRegister += Int(arr[1]) ?? 0
            } else {
                cycleArray.append(xRegister)
            }
        }

        return cycleArray
    }

    private func solvePart1(str: String) -> Int {
        let cycleArray = getCycleArray(str: str)
        return 20 * cycleArray[19] + 60 * cycleArray[59] + 100 * cycleArray[99] + 140 * cycleArray[139] + 180 * cycleArray[179] + 220 * cycleArray[219]
    }

    private func solvePart2(str: String) -> String {
        let cycleArray = getCycleArray(str: str)
        var scanLines = Array(repeating: "", count: 6)
        for y in 0..<6 {
            for x in 0..<40 {
                let cycle = cycleArray[y * 40 + x]
                if x >= cycle - 1 && x <= cycle + 1 {
                    scanLines[y] += "#"
                } else {
                    scanLines[y] += "."
                }
            }
        }

        return scanLines.joined(separator: "\n")
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
noop
addx 3
addx -5
"""

    static let test2 = """
addx 15
addx -11
addx 6
addx -3
addx 5
addx -1
addx -8
addx 13
addx 4
noop
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx -35
addx 1
addx 24
addx -19
addx 1
addx 16
addx -11
noop
noop
addx 21
addx -15
noop
noop
addx -3
addx 9
addx 1
addx -3
addx 8
addx 1
addx 5
noop
noop
noop
noop
noop
addx -36
noop
addx 1
addx 7
noop
noop
noop
addx 2
addx 6
noop
noop
noop
noop
noop
addx 1
noop
noop
addx 7
addx 1
noop
addx -13
addx 13
addx 7
noop
addx 1
addx -33
noop
noop
noop
addx 2
noop
noop
noop
addx 8
noop
addx -1
addx 2
addx 1
noop
addx 17
addx -9
addx 1
addx 1
addx -3
addx 11
noop
noop
addx 1
noop
addx 1
noop
noop
addx -13
addx -19
addx 1
addx 3
addx 26
addx -30
addx 12
addx -1
addx 3
addx 1
noop
noop
noop
addx -9
addx 18
addx 1
addx 2
noop
noop
addx 9
noop
noop
noop
addx -1
addx 2
addx -37
addx 1
addx 3
noop
addx 15
addx -21
addx 22
addx -6
addx 1
noop
addx 2
addx 1
noop
addx -10
noop
noop
addx 20
addx 1
addx 2
addx 2
addx -6
addx -11
noop
noop
noop
"""

    static let final = """
noop
noop
addx 5
addx 31
addx -30
addx 2
addx 7
noop
noop
addx -4
addx 5
addx 6
noop
addx -1
addx 5
addx -1
addx 5
addx 1
noop
addx 5
noop
addx -1
addx -35
addx 3
noop
addx 2
addx 3
addx -2
addx 2
noop
addx 8
addx -3
addx 5
addx -17
addx 22
addx -2
addx 2
addx 5
addx -2
addx -26
addx 31
addx 2
addx 5
addx -40
addx 30
addx -27
addx 4
addx 2
addx 3
addx -3
addx 8
noop
noop
addx 2
addx 21
addx -15
addx -2
addx 2
noop
addx 15
addx -16
addx 8
noop
addx 3
addx 5
addx -38
noop
noop
noop
addx 5
addx -5
addx 6
addx 2
addx 7
noop
noop
addx 4
addx -3
noop
noop
addx 7
addx 2
addx 2
addx -1
noop
addx 3
addx 6
noop
addx 1
noop
noop
addx -38
noop
noop
addx 7
addx 3
noop
addx 2
addx -2
addx 7
addx -2
addx 5
addx 2
addx 5
addx -4
addx 2
addx 5
addx 2
addx -21
addx 9
addx 15
noop
addx 3
addx -38
addx 7
noop
noop
addx 18
addx -17
addx 4
noop
addx 1
addx 2
addx 5
addx 3
noop
noop
addx 14
addx -9
noop
noop
addx 4
addx 1
noop
addx 4
addx 3
noop
addx -8
noop
"""
}
