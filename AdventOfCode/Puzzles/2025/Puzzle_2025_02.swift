//
//  Puzzle_2025_02.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 11/28/25.
//  Copyright © 2025 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2025_02: PuzzleBaseClass {
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
        let arr = str.parseIntoStringArray(separator: ",")
        var retval = 0
        for str in arr {
            let values = str.parseIntoIntArray(separator: "-")
            let lower = values[0]
            let lowerCount = "\(lower)".count
            let lowerEven = lowerCount.isMultiple(of: 2)
            let upper = values[1]
            let upperCount = "\(upper)".count
            let upperEven = upperCount.isMultiple(of: 2)
            if lowerEven || upperEven {
                let startIndex: Int, endIndex: Int
                if lowerEven && upperEven {
                    startIndex = "\(lower)"[..<(lowerCount / 2)].int
                    endIndex = "\(upper)"[..<(upperCount / 2)].int
                } else if lowerEven {
                    startIndex = "\(lower)"[..<(lowerCount / 2)].int
                    endIndex = String.init(repeating: "9", count: lowerCount / 2).int
                } else {
                    startIndex = ("1" + String.init(repeating: "0", count: (upperCount / 2) - 1)).int
                    endIndex = "\(upper)"[..<(upperCount / 2)].int
                }

                for idx in (startIndex...endIndex) {
                    let value = "\(idx)\(idx)".int
                    if value >= lower && value <= upper {
                        retval += value
                    }
                }
            }
        }

        return retval
    }

    private func solvePart2(str: String) -> Int {
        let arr = str.parseIntoStringArray(separator: ",")
        var invalidIdSet = Set<Int>()
        for str in arr {
            let values = str.parseIntoIntArray(separator: "-")
            let lower = values[0]
            let upper = values[1]
            let upperCount = "\(upper)".count
            let startDigitCount = 1
            let endDigitCount = upperCount / 2
            for digitCount in startDigitCount...endDigitCount {
                let d1 = ("1" + String.init(repeating: "0", count: digitCount - 1)).int
                let d2 = String.init(repeating: "9", count: digitCount).int
                for idx in d1...d2 {
                    var str = "\(idx)\(idx)"
                    while str.count <= upperCount {
                        if str.int >= lower && str.int <= upper {
                            invalidIdSet.insert(str.int)
                        }

                        str += "\(idx)"
                    }
                }
            }
        }

        return invalidIdSet.reduce(0, +)
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
"""

    static let final = """
12077-25471,4343258-4520548,53-81,43661-93348,6077-11830,2121124544-2121279534,631383-666113,5204516-5270916,411268-591930,783-1147,7575717634-7575795422,8613757494-8613800013,4-19,573518173-573624458,134794-312366,18345305-18402485,109442-132958,59361146-59451093,1171-2793,736409-927243,27424-41933,93-216,22119318-22282041,2854-4778,318142-398442,9477235089-9477417488,679497-734823,28-49,968753-1053291,267179606-267355722,326-780,1533294120-1533349219
"""
}
