//
//  Puzzle_2015_25.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 3/1/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2015_25: PuzzleBaseClass {
    func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")
    }

    func solvePart1() -> Int {
        func indexAtPosition(row: Int, column: Int) -> Int {
            if row == 1 && column == 1 {
                return 0
            }

            var idx = 0
            var r = 1
            var c = 1
            var maxR = 1
            while r != row || c != column {
                if r == 1 {
                    maxR += 1
                    r = maxR
                    c = 1
                } else {
                    r -= 1
                    c += 1
                }

                idx += 1
            }

            return idx
        }

        func valueAtPosition(row: Int, column: Int) -> Int {
            let idx = indexAtPosition(row: row, column: column)

            var v = 20_151_125
            if idx >= 1 {
                for _ in 1...idx {
                    v = ((v * 252_533) % 33_554_393)
                }
            }

            return v
        }

        let row = 2_981
        let column = 3_075
        return valueAtPosition(row: row, column: column)
    }
}
