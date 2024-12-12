//
//  Puzzle_2024_11.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/12/24.
//  Copyright © 2024 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2024_11: PuzzleBaseClass {
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

    private func solve(str: String, blinkCount: Int) -> Int {
        let stones = str.parseIntoIntArray(separator: " ")
        var stoneDictionary = [Int: Int]()
        for stone in stones {
            stoneDictionary[stone] = (stoneDictionary[stone] ?? 0) + 1
        }

        for _ in 1...blinkCount {
            var newStoneDictionary = [Int: Int]()
            for (stone, count) in stoneDictionary {
                if stone == 0 {
                    newStoneDictionary[1, default: 0] += count
                } else {
                    let stoneString = String(stone)
                    let stoneStringCount = stoneString.count
                    if stoneStringCount % 2 == 0 {
                        let leftSide = Int(stoneString[0..<(stoneStringCount / 2)])!
                        newStoneDictionary[leftSide, default: 0] += count
                        let rightSide = Int(stoneString[(stoneStringCount / 2)...])!
                        newStoneDictionary[rightSide, default: 0] += count
                    } else {
                        newStoneDictionary[stone * 2024, default: 0] += count
                    }
                }
            }

            stoneDictionary = newStoneDictionary
        }

        return stoneDictionary.values.reduce(0, +)
    }

    private func solvePart1(str: String) -> Int {
        return solve(str: str, blinkCount: 25)
    }

    private func solvePart2(str: String) -> Int {
        return solve(str: str, blinkCount: 75)
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
125 17
"""

    static let final = """
17639 47 3858 0 470624 9467423 5 188
"""
}
