//
//  Puzzle_2020_25.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/25/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2020_25: PuzzleBaseClass {

    func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")
    }

    func solvePart1() -> Int {
        solvePart1(str: Puzzle_Input.puzzleInput)
    }

    func calculateTransform(key: Int, loopSize: Int) -> Int {
        var retval = 1
        for _ in 1...loopSize {
            retval = (retval * key) % 20201227
        }

        return retval
    }

    func solvePart1(str: String) -> Int {
        let lines = str.parseIntoStringArray()

        let cardPublicKey = lines[0].int

        // I unrolled the calculateTransform above because it was taking to long to chug through all the loops
        var cardLoopSize = 1
        var x = 7
        while x != cardPublicKey {
            cardLoopSize += 1
            x = (x * 7) % 20201227
        }

        let doorPublicKey = lines[1].int

        return calculateTransform(key: doorPublicKey, loopSize: cardLoopSize)
    }

}

private class Puzzle_Input: NSObject {

    static let puzzleInput_test = """
5764801
17807724
"""

    static let puzzleInput = """
15628416
11161639
"""

}
