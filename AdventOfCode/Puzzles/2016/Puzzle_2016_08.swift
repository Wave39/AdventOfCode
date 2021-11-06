//
//  Puzzle_2016_08.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/9/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2016_08: PuzzleBaseClass {
    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution:\n\(part2)")
    }

    func solveBothParts() -> (Int, String) {
        class Display {
            var rows: Int
            var columns: Int
            private var lightArray: [[String]]

            init(r: Int, c: Int) {
                rows = r
                columns = c
                lightArray = [[String]]()
                for _ in 0..<r {
                    var rowArray = [String]()
                    for _ in 0..<c {
                        rowArray.append(".")
                    }
                    lightArray.append(rowArray)
                }
            }

            func displayString() -> String {
                var retVal = ""
                for r in 0..<rows {
                    var rowString = ""
                    for c in 0..<columns {
                        rowString += lightArray[r][c]
                    }

                    retVal += rowString + "\n"
                }

                return retVal
            }

            func rect(w: Int, h: Int) {
                for r in 0..<h {
                    for c in 0..<w {
                        lightArray[r][c] = "#"
                    }
                }
            }

            func rotate(isRow: Bool, rcIndex: Int, rcAmount: Int) {
                for _ in 1...rcAmount {
                    if isRow {
                        let save = lightArray[rcIndex][columns - 1]
                        for idx in (1...columns - 1).reversed() {
                            lightArray[rcIndex][idx] = lightArray[rcIndex][idx - 1]
                        }

                        lightArray[rcIndex][0] = save
                    } else {
                        let save = lightArray[rows - 1][rcIndex]
                        for idx in (1...rows - 1).reversed() {
                            lightArray[idx][rcIndex] = lightArray[idx - 1][rcIndex]
                        }

                        lightArray[0][rcIndex] = save
                    }
                }
            }

            func lightCounter() -> Int {
                var ctr = 0
                for r in 0..<rows {
                    for c in 0..<columns {
                        if lightArray[r][c] == "#" {
                            ctr += 1
                        }
                    }
                }

                return ctr
            }
        }

        let puzzleInputLineArray = PuzzleInput.final.parseIntoStringArray()

        let part1Display = Display(r: 6, c: 50)
        for line in puzzleInputLineArray {
            let arr = line.components(separatedBy: " ")
            if !arr.isEmpty {
                if arr[0] == "rect" {
                    let rectArr = arr[1].components(separatedBy: "x")
                    let rectWidth = rectArr[0].int
                    let rectHeight = rectArr[1].int
                    part1Display.rect(w: rectWidth, h: rectHeight)
                } else if arr[0] == "rotate" {
                    let rotateRow = (arr[1] == "row")
                    let index = arr[2].replacingOccurrences(of: "x=", with: "").replacingOccurrences(of: "y=", with: "").int
                    let amount = arr[4].int
                    part1Display.rotate(isRow: rotateRow, rcIndex: index, rcAmount: amount)
                }
            }
        }

        return (part1Display.lightCounter(), part1Display.displayString())
    }
}

private class PuzzleInput: NSObject {
    static let final = """
rect 1x1
rotate row y=0 by 20
rect 1x1
rotate row y=0 by 2
rect 1x1
rotate row y=0 by 3
rect 2x1
rotate row y=0 by 2
rect 1x1
rotate row y=0 by 3
rect 2x1
rotate row y=0 by 2
rect 1x1
rotate row y=0 by 4
rect 2x1
rotate row y=0 by 2
rect 1x1
rotate row y=0 by 2
rect 1x1
rotate row y=0 by 2
rect 1x1
rotate row y=0 by 3
rect 2x1
rotate row y=0 by 2
rect 1x1
rotate row y=0 by 5
rect 1x1
rotate row y=0 by 2
rect 1x1
rotate row y=0 by 6
rect 5x1
rotate row y=0 by 2
rect 1x3
rotate row y=2 by 8
rotate row y=0 by 8
rotate column x=0 by 1
rect 7x1
rotate row y=2 by 24
rotate row y=0 by 20
rotate column x=5 by 1
rotate column x=4 by 2
rotate column x=2 by 2
rotate column x=0 by 1
rect 7x1
rotate column x=34 by 2
rotate column x=22 by 1
rotate column x=15 by 1
rotate row y=2 by 18
rotate row y=0 by 12
rotate column x=8 by 2
rotate column x=7 by 1
rotate column x=5 by 2
rotate column x=2 by 1
rotate column x=0 by 1
rect 9x1
rotate row y=3 by 28
rotate row y=1 by 28
rotate row y=0 by 20
rotate column x=18 by 1
rotate column x=15 by 1
rotate column x=14 by 1
rotate column x=13 by 1
rotate column x=12 by 2
rotate column x=10 by 3
rotate column x=8 by 1
rotate column x=7 by 2
rotate column x=6 by 1
rotate column x=5 by 1
rotate column x=3 by 1
rotate column x=2 by 2
rotate column x=0 by 1
rect 19x1
rotate column x=34 by 2
rotate column x=24 by 1
rotate column x=23 by 1
rotate column x=14 by 1
rotate column x=9 by 2
rotate column x=4 by 2
rotate row y=3 by 5
rotate row y=2 by 3
rotate row y=1 by 7
rotate row y=0 by 5
rotate column x=0 by 2
rect 3x2
rotate column x=16 by 2
rotate row y=3 by 27
rotate row y=2 by 5
rotate row y=0 by 20
rotate column x=8 by 2
rotate column x=7 by 1
rotate column x=5 by 1
rotate column x=3 by 3
rotate column x=2 by 1
rotate column x=1 by 2
rotate column x=0 by 1
rect 9x1
rotate row y=4 by 42
rotate row y=3 by 40
rotate row y=1 by 30
rotate row y=0 by 40
rotate column x=37 by 2
rotate column x=36 by 3
rotate column x=35 by 1
rotate column x=33 by 1
rotate column x=32 by 1
rotate column x=31 by 3
rotate column x=30 by 1
rotate column x=28 by 1
rotate column x=27 by 1
rotate column x=25 by 1
rotate column x=23 by 3
rotate column x=22 by 1
rotate column x=21 by 1
rotate column x=20 by 1
rotate column x=18 by 1
rotate column x=17 by 1
rotate column x=16 by 3
rotate column x=15 by 1
rotate column x=13 by 1
rotate column x=12 by 1
rotate column x=11 by 2
rotate column x=10 by 1
rotate column x=8 by 1
rotate column x=7 by 2
rotate column x=5 by 1
rotate column x=3 by 3
rotate column x=2 by 1
rotate column x=1 by 1
rotate column x=0 by 1
rect 39x1
rotate column x=44 by 2
rotate column x=42 by 2
rotate column x=35 by 5
rotate column x=34 by 2
rotate column x=32 by 2
rotate column x=29 by 2
rotate column x=25 by 5
rotate column x=24 by 2
rotate column x=19 by 2
rotate column x=15 by 4
rotate column x=14 by 2
rotate column x=12 by 3
rotate column x=9 by 2
rotate column x=5 by 5
rotate column x=4 by 2
rotate row y=5 by 5
rotate row y=4 by 38
rotate row y=3 by 10
rotate row y=2 by 46
rotate row y=1 by 10
rotate column x=48 by 4
rotate column x=47 by 3
rotate column x=46 by 3
rotate column x=45 by 1
rotate column x=43 by 1
rotate column x=37 by 5
rotate column x=36 by 5
rotate column x=35 by 4
rotate column x=33 by 1
rotate column x=32 by 5
rotate column x=31 by 5
rotate column x=28 by 5
rotate column x=27 by 5
rotate column x=26 by 3
rotate column x=25 by 4
rotate column x=23 by 1
rotate column x=17 by 5
rotate column x=16 by 5
rotate column x=13 by 1
rotate column x=12 by 5
rotate column x=11 by 5
rotate column x=3 by 1
rotate column x=0 by 1
"""
}
