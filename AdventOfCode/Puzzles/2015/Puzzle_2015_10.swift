//
//  Puzzle_2015_10.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/21/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2015_10: PuzzleBaseClass {
    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    func solveBothParts() -> (Int, Int) {
        let numberOfIterations = 50

        func lookAndSay(_ originalString: String) -> String {
            var newStr = ""
            var currentCharacter: Character = originalString[0]
            var currentCount = 0
            for c in originalString {
                if c == currentCharacter {
                    currentCount = currentCount + 1
                } else {
                    newStr += "\(currentCount)\(currentCharacter)"
                    currentCharacter = c
                    currentCount = 1
                }
            }

            newStr += "\(currentCount)\(currentCharacter)"
            return newStr
        }

        var part1 = 0
        var part2 = 0
        var currentSequence = PuzzleInput.final
        for idx in 1...numberOfIterations {
            currentSequence = lookAndSay(currentSequence)
            if idx == 40 {
                part1 = currentSequence.count
            }
            if idx == 50 {
                part2 = currentSequence.count
            }
        }

        return (part1, part2)
    }
}

private class PuzzleInput: NSObject {
    static let final = "1321131112"
}
