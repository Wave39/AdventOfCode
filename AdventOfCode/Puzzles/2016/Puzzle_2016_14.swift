//
//  Puzzle_2016_14.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/14/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2016_14: PuzzleBaseClass {

    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    func solveBothParts() -> (Int, Int) {
        let puzzleInput = "qzyelonm"

        func MD5ForIndex(inputString: String, index: Int, stretch: Bool) -> String {
            let key = "\(inputString)\(index)"
            var md5 = key.md5
            if stretch {
                for _ in 1...2_016 {
                    md5 = md5.md5
                }
            }

            return md5
        }

        func getTripleCharacter(string: String) -> String {
            for i in 0..<string.count - 2 {
                if string[i] == string[i + 1] && string[i] == string[i + 2] {
                    return String(string[i])
                }
            }

            return "?"
        }

        func findMatches(inputString: String, stretch: Bool) -> [ Int ] {
            var hashFound = false
            var index = 0
            var hashDictionary: Dictionary<Int, String> = [ : ]
            var validKeys: [ Int ] = []

            func getIndexValue(index: Int) -> String {
                if hashDictionary[index] == nil {
                    hashDictionary[index] = MD5ForIndex(inputString: inputString, index: index, stretch: stretch)
                }

                return hashDictionary[index] ?? ""
            }

            while !hashFound {
                let hashValue = getIndexValue(index: index)
                let matchedCharacter = getTripleCharacter(string: hashValue)
                if matchedCharacter != "?" {
                    let searchFor = String(repeating: matchedCharacter, count: 5)
                    for nextIndex in (index + 1)...(index + 1_000) {
                        let nextHashValue = getIndexValue(index: nextIndex)
                        if nextHashValue.contains(searchFor) {
                            validKeys.append(index)
                            break
                        }
                    }
                }

                index += 1
                if validKeys.count == 64 {
                    hashFound = true
                }
            }

            return validKeys
        }

        let part1Solution = findMatches(inputString: puzzleInput, stretch: false).last ?? 0
        let part2Solution = findMatches(inputString: puzzleInput, stretch: true).last ?? 0
        return (part1Solution, part2Solution)
    }
}
