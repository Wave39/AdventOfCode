//
//  Puzzle_2018_14.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/4/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2018_14: NSObject {

    func solve() {
        let solution = solveBothParts()
        print("Part 1 solution: \(solution.0)")
        print("Part 2 solution: \(solution.1)")
    }

    func solveBothParts() -> (String, Int) {
        let puzzleInput = Puzzle_2018_14_Input.puzzleInput
        return solveBothParts(puzzleInput: puzzleInput)
    }

    func solveBothParts(puzzleInput: Int) -> (String, Int) {
        var scoreboard = [3, 7]
        var elf1 = 0
        var elf2 = 1
        let numberOfScoreboardEntries = 21_000_000  // yeah, ok, this took some experimentation to figure out

        repeat {
            let newRecipe = scoreboard[elf1] + scoreboard[elf2]
            if newRecipe < 10 {
                scoreboard.append(newRecipe)
            } else {
                scoreboard.append(1)
                scoreboard.append(newRecipe % 10)
            }

            elf1 = (elf1 + scoreboard[elf1] + 1) % scoreboard.count
            elf2 = (elf2 + scoreboard[elf2] + 1) % scoreboard.count
        } while scoreboard.count < numberOfScoreboardEntries

        let arr = Array(scoreboard[puzzleInput..<(puzzleInput + 10)])
        let part1 = arr.map(String.init).joined()

        var part2 = -1
        for idx in 0..<scoreboard.count {
            if scoreboard[idx] == 1 && scoreboard[idx + 1] == 9 && scoreboard[idx + 2] == 0 && scoreboard[idx + 3] == 2 && scoreboard[idx + 4] == 2 && scoreboard[idx + 5] == 1 {
                part2 = idx
                break
            }
        }

        return (part1, part2)
    }

}

private class Puzzle_2018_14_Input: NSObject {

    static let puzzleInput_test = 5

    static let puzzleInput = 190_221

}
