//
//  Puzzle_2017_10.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/18/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2017_10: PuzzleBaseClass {
    private var elementArray: [Int] = []

    public func solve() {
        let (part1Solution, part2Solution) = solveBothParts()
        print("Part 1 solution: \(part1Solution)")
        print("Part 2 solution: \(part2Solution)")
    }

    public func solveBothParts() -> (Int, String) {
        let puzzleInput = Puzzle_2017_10_Input.puzzleInput
        let part1Solution = solvePart1(arr: puzzleInput)
        let part2Solution = solvePart2(arr: puzzleInput)
        return (part1Solution, part2Solution)
    }

    private func reverseElementArray(pos: Int, len: Int) {
        let halfLen = Int(len / 2)
        for idx in 0..<halfLen {
            let idx1 = (pos + idx) % elementArray.count
            let idx2 = (pos + (len - idx - 1)) % elementArray.count
            let t = elementArray[idx1]
            elementArray[idx1] = elementArray[idx2]
            elementArray[idx2] = t
        }
    }

    private func setUpElementArray(ctr: Int) {
        elementArray = []
        for idx in 0..<ctr {
            elementArray.append(idx)
        }
    }

    private func solvePart1(arr: Array<Any>) -> Int {
        setUpElementArray(ctr: arr[0] as! Int)
        var currentPosition = 0
        var skipSize = 0
        let inputLengthArray = (arr[1] as! String).split(separator: ",").map { $0.int }
        for inputLength in inputLengthArray {
            reverseElementArray(pos: currentPosition, len: inputLength)
            currentPosition += (inputLength + skipSize)
            skipSize += 1
        }

        return elementArray[0] * elementArray[1]
    }

    private func solvePart2(arr: Array<Any>) -> String {
        setUpElementArray(ctr: arr[0] as! Int)

        let str = arr[1] as! String
        var inputLengthArray = str.asciiArray.map { Int($0) }
        inputLengthArray.append(contentsOf: [ 17, 31, 73, 47, 23 ])

        var currentPosition = 0
        var skipSize = 0
        for _ in 0..<64 {
            for inputLength in inputLengthArray {
                reverseElementArray(pos: currentPosition, len: inputLength)
                currentPosition += (inputLength + skipSize)
                skipSize += 1
            }
        }

        var denseHash: [Int] = []
        for i in 0...15 {
            let idx = i * 16
            var v = elementArray[idx]
            for j in 1...15 {
                v = v ^ elementArray[idx + j]
            }

            denseHash.append(v)
        }

        var knotHash = ""
        for i in denseHash {
            knotHash += ((i <= 15 ? "0" : "") + i.hexadecimalString())
        }

        return knotHash
    }
}

private class Puzzle_2017_10_Input: NSObject {
    static let puzzleInput_test1 = [ 5, "3,4,1,5" ] as [Any]

    static let puzzleInput = [ 256, "212,254,178,237,2,0,1,54,167,92,117,125,255,61,159,164" ] as [Any]
}
