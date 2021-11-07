//
//  Puzzle_2015_20.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/29/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2015_20: PuzzleBaseClass {

    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    func solveBothParts() -> (Int, Int) {
        // thanks to Mark Heath for pointing out this algorithm
        // https://markheath.net/post/advent-of-code-day20

        let presentMinimum = PuzzleInput.final

        var houses = Array(repeating: 0, count: presentMinimum / 10 + 1)
        for elf in 1..<houses.count {
            for house in stride(from: elf, to: houses.count, by: elf) {
                houses[house] += elf * 10
            }
        }

        var part1Number = 0
        for house in 1..<houses.count {
            if houses[house] > presentMinimum {
                part1Number = house
                break
            }
        }

        houses = Array(repeating: 0, count: presentMinimum / 10 + 1)
        for elf in 1..<houses.count {
            var ctr = 0
            for house in stride(from: elf, to: houses.count, by: elf) {
                ctr += 1
                if ctr <= 50 {
                    houses[house] += elf * 11
                }
            }
        }

        var part2Number = 0
        for house in 1..<houses.count {
            if houses[house] > presentMinimum {
                part2Number = house
                break
            }
        }

        return (part1Number, part2Number)
    }

}

private class PuzzleInput: NSObject {

    static let final = 33_100_000

}
