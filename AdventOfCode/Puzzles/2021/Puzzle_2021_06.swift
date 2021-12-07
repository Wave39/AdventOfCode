//
//  Puzzle_2021_06.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/6/21.
//  Copyright © 2021 Wave 39 LLC. All rights reserved.
//

// https://adventofcode.com/2021/day/6

import Foundation

public class Puzzle_2021_06: PuzzleBaseClass {
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

    private func processFishes(str: String, numberOfDays: Int) -> Int {
        let arr = str.parseIntoIntArray(separator: ",")
        var fishes = [Int](repeating: 0, count: 9)
        for item in arr {
            fishes[item] += 1
        }

        for _ in 1...numberOfDays {
            let newFishes = fishes[0]
            var newFishesArray = [Int](repeating: 0, count: 9)
            for idx in 1...8 {
                newFishesArray[idx - 1] = fishes[idx]
            }

            newFishesArray[8] = newFishes
            newFishesArray[6] += newFishes
            fishes = newFishesArray
        }

        return fishes.reduce(0, +)
    }

    private func solvePart1(str: String) -> Int {
        processFishes(str: str, numberOfDays: 80)
    }

    private func solvePart2(str: String) -> Int {
        processFishes(str: str, numberOfDays: 256)
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
3,4,3,1,2
"""

    static let final = """
1,3,4,1,1,1,1,1,1,1,1,2,2,1,4,2,4,1,1,1,1,1,5,4,1,1,2,1,1,1,1,4,1,1,1,4,4,1,1,1,1,1,1,1,2,4,1,3,1,1,2,1,2,1,1,4,1,1,1,4,3,1,3,1,5,1,1,3,4,1,1,1,3,1,1,1,1,1,1,1,1,1,1,1,1,1,5,2,5,5,3,2,1,5,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,5,1,1,1,1,5,1,1,1,1,1,4,1,1,1,1,1,3,1,1,1,1,1,1,1,1,1,1,1,3,1,2,4,1,5,5,1,1,5,3,4,4,4,1,1,1,2,1,1,1,1,1,1,2,1,1,1,1,1,1,5,3,1,4,1,1,2,2,1,2,2,5,1,1,1,2,1,1,1,1,3,4,5,1,2,1,1,1,1,1,5,2,1,1,1,1,1,1,5,1,1,1,1,1,1,1,5,1,4,1,5,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,5,4,5,1,1,1,1,1,1,1,5,1,1,3,1,1,1,3,1,4,2,1,5,1,3,5,5,2,1,3,1,1,1,1,1,3,1,3,1,1,2,4,3,1,4,2,2,1,1,1,1,1,1,1,5,2,1,1,1,2
"""
}
