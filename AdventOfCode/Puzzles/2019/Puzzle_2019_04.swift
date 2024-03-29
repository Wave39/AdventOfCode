//
//  Puzzle_2019_04.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/4/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2019_04: PuzzleBaseClass {
    public func solve() {
        let startingValue = 134_564
        let endingValue = 585_159

        let part1 = solvePart1(from: startingValue, to: endingValue)
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2(from: startingValue, to: endingValue)
        print("Part 2 solution: \(part2)")
    }

    private func IsValidPassword(password: Int, isPart2: Bool) -> Bool {
        let passwordAsString = "\(password)"
        var arr: [Int] = []
        for idx in 0...5 {
            arr.append(String(passwordAsString[idx]).int)
        }

        var ascendingCharacters = false
        if arr[1] >= arr[0] && arr[2] >= arr[1] && arr[3] >= arr[2] && arr[4] >= arr[3] && arr[5] >= arr[4] {
            ascendingCharacters = true
        }

        if !ascendingCharacters {
            return false
        }

        var adjacentCharacters = false
        if isPart2 {
            var letterDictionary: Dictionary<Int, Int> = [:]
            for idx in 0...5 {
                if letterDictionary[arr[idx]] == nil {
                    letterDictionary[arr[idx]] = 0
                }

                letterDictionary[arr[idx]]? += 1
            }

            for k in letterDictionary.keys {
                if letterDictionary[k] == 2 {
                    adjacentCharacters = true
                }
            }
        } else {
            if arr[0] == arr[1] || arr[1] == arr[2] || arr[2] == arr[3] || arr[3] == arr[4] || arr[4] == arr[5] {
                adjacentCharacters = true
            }
        }

        return adjacentCharacters && ascendingCharacters
    }

    public func solvePart1(from: Int, to: Int) -> Int {
        var retval = 0
        for i in from...to {
            if IsValidPassword(password: i, isPart2: false) {
                retval += 1
            }
        }

        return retval
    }

    public func solvePart2(from: Int, to: Int) -> Int {
        var retval = 0
        for i in from...to {
            if IsValidPassword(password: i, isPart2: true) {
                retval += 1
            }
        }

        return retval
    }
}
