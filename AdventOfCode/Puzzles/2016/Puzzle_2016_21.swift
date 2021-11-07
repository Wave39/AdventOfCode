//
//  Puzzle_2016_21.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/14/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2016_21: PuzzleBaseClass {
    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    func solveBothParts() -> (String, String) {
        let passwordToScramble = "abcdefgh"

        let puzzleInputLineArray = PuzzleInput.final.parseIntoStringArray()

        func replace(myString: String, _ index: Int, _ newChar: Character) -> String {
            var chars = Array(myString)     // gets an array of characters
            chars[index] = newChar
            let modifiedString = String(chars)
            return modifiedString
        }

        var thePassword = passwordToScramble

        func processArray(arr: [String]) {
            for line in arr {
                let lineArr = line.components(separatedBy: " ")
                if lineArr[0] == "swap" {
                    if lineArr[1] == "position" {
                        let p1 = lineArr[2].int
                        let p2 = lineArr[5].int
                        let c1 = Character(String(thePassword[p1]))
                        let c2 = Character(String(thePassword[p2]))
                        thePassword = thePassword.replace(index: p1, newChar: c2)
                        thePassword = thePassword.replace(index: p2, newChar: c1)
                    } else if lineArr[1] == "letter" {
                        let c1 = Character(lineArr[2])
                        let c2 = Character(lineArr[5])
                        let p1 = thePassword.indexOf(char: c1) ?? 0
                        let p2 = thePassword.indexOf(char: c2) ?? 0
                        thePassword = thePassword.replace(index: p1, newChar: c2)
                        thePassword = thePassword.replace(index: p2, newChar: c1)
                    } else {
                        print("Invalid swap command: \(lineArr[1])")
                    }
                } else if lineArr[0] == "reverse" {
                    let idx1 = lineArr[2].int
                    let idx2 = lineArr[4].int
                    let stringToReverse = thePassword[Range(idx1...idx2)]
                    var reversedString = String(stringToReverse.reversed())
                    reversedString = thePassword.substring(from: 0, to: idx1) + reversedString
                    reversedString += thePassword.substring(from: idx2 + 1)
                    thePassword = reversedString
                } else if lineArr[0] == "rotate" {
                    if lineArr[1] == "left" {
                        let ctr = lineArr[2].int
                        if ctr > 0 {
                            thePassword.rotate(amount: ctr, left: true)
                        }
                    } else if lineArr[1] == "right" {
                        let ctr = lineArr[2].int
                        if ctr > 0 {
                            thePassword.rotate(amount: ctr, left: false)
                        }
                    } else if lineArr[1] == "based" {
                        let c = lineArr[6]
                        let idx = thePassword.indexOf(char: Character(c)) ?? 0
                        var amount = 1 + idx
                        if idx >= 4 {
                            amount += 1
                        }

                        thePassword.rotate(amount: amount, left: false)
                    } else {
                        print("Invalid rotate command: \(lineArr[1])")
                    }
                } else if lineArr[0] == "move" {
                    let idx1 = lineArr[2].int
                    let idx2 = lineArr[5].int
                    let c = thePassword[idx1]
                    let s0 = thePassword.substring(from: 0, to: idx1) + thePassword.substring(from: idx1 + 1)
                    let s1: String
                    if idx2 == 0 {
                        s1 = String(c) + s0
                    } else {
                        s1 = s0.substring(from: 0, to: idx2) + String(c) + s0.substring(from: idx2)
                    }
                    thePassword = s1
                } else {
                    print("Invalid command: \(lineArr[0])")
                }
            }
        }

        processArray(arr: puzzleInputLineArray)

        let part1 = thePassword

        func processArrayReverse(arr: [String]) {
            var lineCtr = 1
            for line in arr {
                let lineArr = line.components(separatedBy: " ")
                if lineArr[0] == "swap" {
                    if lineArr[1] == "position" {
                        let p1 = lineArr[5].int
                        let p2 = lineArr[2].int
                        let c1 = Character(String(thePassword[p1]))
                        let c2 = Character(String(thePassword[p2]))
                        thePassword = thePassword.replace(index: p1, newChar: c2)
                        thePassword = thePassword.replace(index: p2, newChar: c1)
                    } else if lineArr[1] == "letter" {
                        let c1 = Character(lineArr[5])
                        let c2 = Character(lineArr[2])
                        let p1 = thePassword.indexOf(char: c1) ?? 0
                        let p2 = thePassword.indexOf(char: c2) ?? 0
                        thePassword = thePassword.replace(index: p1, newChar: c2)
                        thePassword = thePassword.replace(index: p2, newChar: c1)
                    } else {
                        print("Invalid swap command: \(lineArr[1])")
                    }
                } else if lineArr[0] == "reverse" {
                    let idx1 = lineArr[2].int
                    let idx2 = lineArr[4].int
                    let stringToReverse = thePassword[Range(idx1...idx2)]
                    var reversedString = String(stringToReverse.reversed())
                    reversedString = thePassword.substring(from: 0, to: idx1) + reversedString
                    reversedString += thePassword.substring(from: idx2 + 1)
                    thePassword = reversedString
                } else if lineArr[0] == "rotate" {
                    if lineArr[1] == "left" {
                        let ctr = lineArr[2].int
                        if ctr > 0 {
                            thePassword.rotate(amount: ctr, left: false)
                        }
                    } else if lineArr[1] == "right" {
                        let ctr = lineArr[2].int
                        if ctr > 0 {
                            thePassword.rotate(amount: ctr, left: true)
                        }
                    } else if lineArr[1] == "based" {
                        let c = lineArr[6]
                        let idx = thePassword.indexOf(char: Character(c)) ?? 0
                        var amount = 1 + idx
                        if idx >= 4 {
                            amount += 1
                        }

                        if amount == 1 {
                            amount = 1
                        } else if amount == 2 {
                            amount = 1
                        } else if amount == 3 {
                            amount = 6
                        } else if amount == 4 {
                            amount = 2
                        } else if amount == 6 {
                            amount = 7
                        } else if amount == 8 {
                            amount = 0
                        } else if amount == 9 {
                            amount = 4
                        }

                        if amount > 0 {
                            thePassword.rotate(amount: amount, left: true)
                        }
                    } else {
                        print("Invalid rotate command: \(lineArr[1])")
                    }
                } else if lineArr[0] == "move" {
                    let idx1 = lineArr[5].int
                    let idx2 = lineArr[2].int
                    let c = thePassword[idx1]
                    let s0 = thePassword.substring(from: 0, to: idx1) + thePassword.substring(from: idx1 + 1)
                    let s1: String
                    if idx2 == 0 {
                        s1 = String(c) + s0
                    } else {
                        s1 = s0.substring(from: 0, to: idx2) + String(c) + s0.substring(from: idx2)
                    }
                    thePassword = s1
                } else {
                    print("Invalid command: \(lineArr[0])")
                }

                lineCtr += 1
            }
        }

        thePassword = "fbgdceah"
        let arrReversed = Array(puzzleInputLineArray.reversed())
        processArrayReverse(arr: arrReversed)

        let part2 = thePassword

        return (part1, part2)
    }
}

private class PuzzleInput: NSObject {
    static let final = """
reverse positions 1 through 6
rotate based on position of letter a
swap position 4 with position 1
reverse positions 1 through 5
move position 5 to position 7
swap position 4 with position 0
swap position 4 with position 6
rotate based on position of letter a
swap position 0 with position 2
move position 5 to position 2
move position 7 to position 1
swap letter d with letter c
swap position 5 with position 3
reverse positions 3 through 7
rotate based on position of letter d
swap position 7 with position 5
rotate based on position of letter f
swap position 4 with position 1
swap position 3 with position 6
reverse positions 4 through 7
rotate based on position of letter c
move position 0 to position 5
swap position 7 with position 4
rotate based on position of letter f
reverse positions 1 through 3
move position 5 to position 3
rotate based on position of letter g
reverse positions 2 through 5
rotate right 0 steps
rotate left 0 steps
swap letter f with letter b
rotate based on position of letter h
move position 1 to position 3
reverse positions 3 through 6
rotate based on position of letter h
swap position 4 with position 3
swap letter b with letter h
swap letter a with letter h
reverse positions 1 through 6
swap position 3 with position 6
swap letter e with letter d
swap letter e with letter h
swap position 1 with position 5
rotate based on position of letter a
reverse positions 4 through 5
swap position 0 with position 4
reverse positions 0 through 3
move position 7 to position 2
swap letter e with letter c
swap position 3 with position 4
rotate left 3 steps
rotate left 7 steps
rotate based on position of letter e
reverse positions 5 through 6
move position 1 to position 5
move position 1 to position 2
rotate left 1 step
move position 7 to position 6
rotate left 0 steps
reverse positions 5 through 6
reverse positions 3 through 7
swap letter d with letter e
rotate right 3 steps
swap position 2 with position 1
swap position 5 with position 7
swap letter h with letter d
swap letter c with letter d
rotate based on position of letter d
swap letter d with letter g
reverse positions 0 through 1
rotate right 0 steps
swap position 2 with position 3
rotate left 4 steps
rotate left 5 steps
move position 7 to position 0
rotate right 1 step
swap letter g with letter f
rotate based on position of letter a
rotate based on position of letter b
swap letter g with letter e
rotate right 4 steps
rotate based on position of letter h
reverse positions 3 through 5
swap letter h with letter e
swap letter g with letter a
rotate based on position of letter c
reverse positions 0 through 4
rotate based on position of letter e
reverse positions 4 through 7
rotate left 4 steps
swap position 0 with position 6
reverse positions 1 through 6
rotate left 2 steps
swap position 5 with position 3
swap letter b with letter d
swap letter b with letter d
rotate based on position of letter d
rotate based on position of letter c
rotate based on position of letter h
move position 4 to position 7
"""
}
