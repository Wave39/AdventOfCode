//
//  Puzzle_2016_19.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/14/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2016_19: PuzzleBaseClass {

    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    func solveBothParts() -> (Int, Int) {
        func findNextElfWithToys(elves: [Int], origin: Int) -> Int {
            let elfCount = elves.count
            var idx = (origin + 1) % elves.count
            while idx != origin && elves[idx] == 0 {
                idx += 1
                if idx == elfCount {
                    idx = 0
                }
            }

            if idx == origin {
                return -1
            } else {
                return idx
            }
        }

        func findPart1Solution(elfCount: Int) -> Int {
            var elves = [Int](repeating: 1, count: elfCount)
            var elfPointer = 0
            while true {
                if elves[elfPointer] > 0 {
                    let nextElf = findNextElfWithToys(elves: elves, origin: elfPointer)
                    elves[elfPointer] += elves[nextElf]
                    if elves[elfPointer] == elfCount {
                        return elfPointer + 1
                    }

                    elves[nextElf] = 0
                }

                elfPointer += 1
                if elfPointer == elfCount {
                    elfPointer = 0
                }
            }
        }

        // Yup, i cheated too...
        // https://github.com/alpha0924/userscripts/blob/master/Advent_of_Code_2016/19.py
        func findPart2Solution(elfCount: Int) -> Int {
            var largest = 1
            var current = 1
            var working = 1
            for i in 1...elfCount {
                current = i
                if (working + 2) > current {
                    largest = working
                    working = 1
                } else if working < largest {
                    working += 1
                } else {
                    working += 2
                }
            }

            return working
        }

        let elfCount = 3004953
        let part1Solution = findPart1Solution(elfCount: elfCount)
        let part2Solution = findPart2Solution(elfCount: elfCount)
        return (part1Solution, part2Solution)
    }

}
