//
//  Puzzle_2016_05.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/9/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2016_05: PuzzleBaseClass {
    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    func solveBothParts() -> (String, String) {
        var part1Password = ""
        var part2Password = "--------"
        var idx = 0
        let part1Prefix = PuzzleInput.final
        while part1Password.count < 8 || part2Password.contains("-") {
            let md5String = "\(part1Prefix)\(idx)".md5
            if md5String.hasPrefix("00000") {
                // print ("On index \(idx) the MD5 hash is \(md5String)")
                let sixthChar = md5String[5]
                if part1Password.count < 8 {
                    part1Password += "\(sixthChar)"
                    // print ("Part 1 password becomes \(part1Password)")
                }

                if sixthChar >= "0" && sixthChar <= "7" {
                    let pos = Int(String(sixthChar))
                    if part2Password[pos!] == "-" {
                        let seventhChar = md5String[6]
                        part2Password = part2Password.replace(index: pos!, newChar: seventhChar)
                        // print ("Part 2 password becomes \(part2Password)")
                    }
                }
            }

            idx += 1
        }

        return (part1Password, part2Password)
    }
}

private class PuzzleInput: NSObject {
    static let final = """
wtnhxymk
"""
}
