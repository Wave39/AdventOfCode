//
//  Puzzle_2016_01.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/8/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2016_01: PuzzleBaseClass {

    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    func solveBothParts() -> (Int, Int) {
        let puzzleInputLineArray = PuzzleInput.final.components(separatedBy: ",")

        func parseStep(step: String) -> (String, Int?) {
            let trimString = step.trimmingCharacters(in: .whitespaces).replacingOccurrences(of: "\n", with: "")
            let direction = trimString.substring(from: 0, to: 1)
            let amount = trimString.substring(from: 1)
            let amountInt = Int(amount)
            return (direction, amountInt)
        }

        enum Direction: Int {
            case North = 0
            case East = 1
            case South = 2
            case West = 3

            func nextHeading(turnTo: String) -> Direction {
                var newDirection: Int
                if turnTo == "R" {
                    newDirection = self.rawValue + 1
                    if newDirection > Direction.West.rawValue {
                        newDirection = Direction.North.rawValue
                    }
                } else {
                    newDirection = self.rawValue - 1
                    if newDirection < Direction.North.rawValue {
                        newDirection = Direction.West.rawValue
                    }
                }

                return Direction(rawValue: newDirection) ?? .North
            }
        }

        var currentHeading = Direction.North
        var currentNSPosition = 0
        var currentWEPosition = 0
        var locationsVisited = Set<(String)>()
        var part2NSPosition = 0
        var part2WEPosition = 0
        var part2HeadquartersFound = false

        for oneStep in puzzleInputLineArray {
            let s = parseStep(step: oneStep)
            currentHeading = currentHeading.nextHeading(turnTo: s.0)
            let travelAmount: Int = s.1!
            let inc = (currentHeading == .South || currentHeading == .West) ? -1 : 1

            for _ in 0..<travelAmount {
                if currentHeading == .North || currentHeading == .South {
                    currentNSPosition += inc
                } else {
                    currentWEPosition += inc
                }

                let currentLocationString = "\(currentNSPosition),\(currentWEPosition)"
                if locationsVisited.contains(currentLocationString) && !part2HeadquartersFound {
                    part2HeadquartersFound = true
                    part2NSPosition = currentNSPosition
                    part2WEPosition = currentWEPosition
                } else {
                    locationsVisited.insert(currentLocationString)
                }
            }
        }

        let part1Answer = Swift.abs(currentNSPosition) + Swift.abs(currentWEPosition)
        let part2Answer = Swift.abs(part2NSPosition) + Swift.abs(part2WEPosition)
        return (part1Answer, part2Answer)
    }

}

private class PuzzleInput: NSObject {
    static let final = """
R5, L2, L1, R1, R3, R3, L3, R3, R4, L2, R4, L4, R4, R3, L2, L1, L1, R2, R4, R4, L4, R3, L2, R1, L4, R1, R3, L5, L4, L5, R3, L3, L1, L1, R4, R2, R2, L1, L4, R191, R5, L2, R46, R3, L1, R74, L2, R2, R187, R3, R4, R1, L4, L4, L2, R4, L5, R4, R3, L2, L1, R3, R3, R3, R1, R1, L4, R4, R1, R5, R2, R1, R3, L4, L2, L2, R1, L3, R1, R3, L5, L3, R5, R3, R4, L1, R3, R2, R1, R2, L4, L1, L1, R3, L3, R4, L2, L4, L5, L5, L4, R2, R5, L4, R4, L2, R3, L4, L3, L5, R5, L4, L2, R3, R5, R5, L1, L4, R3, L1, R2, L5, L1, R4, L1, R5, R1, L4, L4, L4, R4, R3, L5, R1, L3, R4, R3, L2, L1, R1, R2, R2, R2, L1, L1, L2, L5, L3, L1
"""
}
