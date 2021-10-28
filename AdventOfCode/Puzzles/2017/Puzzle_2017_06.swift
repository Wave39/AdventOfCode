//
//  Puzzle_2017_06.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/18/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2017_06: PuzzleBaseClass {
    func solve() {
        let solution = solveBothParts()
        print("Part 1 solution: \(solution.0)")
        print("Part 2 solution: \(solution.1)")
    }

    func solveBothParts() -> (Int, Int) {
        let puzzleInput = Puzzle_2017_06_Input.puzzleInput
        return solveInput(str: puzzleInput)
    }

    func parseInput(str: String) -> [Int] {
        var retval: [Int] = []
        let lineArray = str.split(separator: " ")
        for line in lineArray {
            retval.append(Int(line)!)
        }

        return retval
    }

    func findLargestIndex(arr: [Int]) -> Int {
        let sortedArray = arr.sorted()
        let largestValue = sortedArray.last
        for idx in 0..<arr.count {
            if arr[idx] == largestValue {
                return idx
            }
        }

        return NSNotFound
    }

    func arrayToString(arr: [Int]) -> String {
        var retval = ""
        for i in arr {
            retval += (String(i) + " ")
        }

        return retval
    }

    func processArray(arr: inout [Int]) {
        let largeIdx = findLargestIndex(arr: arr)
        let v = arr[largeIdx]
        arr[largeIdx] = 0
        for i in 1...v {
            let nextIdx = (largeIdx + i) % arr.count
            arr[nextIdx] = arr[nextIdx] + 1
        }
    }

    func solveInput(str: String) -> (Int, Int) {
        var processCounter = 0
        var loopCounter = 0
        var memoryBanks = parseInput(str: str)
        var dict: Dictionary<String, Int> = [ arrayToString(arr: memoryBanks): 0 ]
        var stayInLoop = true
        while stayInLoop {
            processArray(arr: &memoryBanks)
            processCounter += 1

            let memoryString = arrayToString(arr: memoryBanks)
            if dict[memoryString] == nil {
                dict[memoryString] = processCounter
            } else {
                stayInLoop = false
                loopCounter = processCounter - dict[memoryString]!
            }
        }

        return (processCounter, loopCounter)
    }
}

private class Puzzle_2017_06_Input: NSObject {
    static let puzzleInput_test = "0 2 7 0"

    static let puzzleInput = "14    0    15    12    11    11    3    5    1    6    8    4    9    1    8    4"
}
