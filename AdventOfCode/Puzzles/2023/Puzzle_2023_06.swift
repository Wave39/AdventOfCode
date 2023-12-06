//
//  Puzzle_2023_06.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/4/23.
//  Copyright © 2023 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2023_06: PuzzleBaseClass {
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

    private func travelDistance(hold: Int, time: Int) -> Int {
        hold * (time - hold)
    }

    private func solvePart1(str: String) -> Int {
        let arr = str.parseIntoStringArray()
        let timeArray = arr[0].replacingOccurrences(of: "Time:", with: "").parseIntoIntArray(separator: " ")
        let distanceArray = arr[1].replacingOccurrences(of: "Distance:", with: "").parseIntoIntArray(separator: " ")
        var winsArray = [Int]()
        for idx in 0..<timeArray.count {
            let time = timeArray[idx]
            let distance = distanceArray[idx]
            var wins = 0
            for hold in 1...(time - 1) {
                if travelDistance(hold: hold, time: time) > distance {
                    wins += 1
                }
            }

            winsArray.append(wins)
        }

        return winsArray.reduce(1, *)
    }

    private func solvePart2(str: String) -> Int {
        let arr = str.parseIntoStringArray()
        let time = arr[0].replacingOccurrences(of: "Time:", with: "").replacingOccurrences(of: " ", with: "").int
        let distance = arr[1].replacingOccurrences(of: "Distance:", with: "").replacingOccurrences(of: " ", with: "").int
        let multiplier = 1_000

        // find the lower boundary position
        var hold = 0
        while travelDistance(hold: hold, time: time) <= distance {
            hold += multiplier
        }

        hold -= multiplier
        while travelDistance(hold: hold, time: time) <= distance {
            hold += 1
        }

        let lowerBound = hold

        // find the upper boundary position
        hold = time
        while travelDistance(hold: hold, time: time) <= distance {
            hold -= multiplier
        }

        hold += multiplier
        while travelDistance(hold: hold, time: time) <= distance {
            hold -= 1
        }

        let upperBound = hold

        return (upperBound - lowerBound + 1)
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
Time:      7  15   30
Distance:  9  40  200
"""

    static let final = """
Time:        62     64     91     90
Distance:   553   1010   1473   1074
"""
}
