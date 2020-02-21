//
//  Puzzle_2015_11.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/21/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2015_11 : PuzzleBaseClass {

    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }
    
    func solveBothParts() -> (String, String) {
        let asciiA = "a".asciiValue
        let asciiI = "i".asciiValue
        let asciiO = "o".asciiValue
        let asciiL = "l".asciiValue

        func nextPassword(_ oldPassword: String) -> String {
            var characterArray = oldPassword.map({ String($0).asciiValue - asciiA })
            var idx = 7
            while idx >= 0 {
                characterArray[idx] = characterArray[idx] + 1
                
                if characterArray[idx] == asciiI || characterArray[idx] == asciiO || characterArray[idx] == asciiL {
                    characterArray[idx] = characterArray[idx] + 1
                }
                
                if characterArray[idx] > 25 {
                    characterArray[idx] = 0
                    idx = idx - 1
                } else {
                    idx = -1
                }
            }
            
            var newPassword = ""
            for i in characterArray {
                newPassword += String(UnicodeScalar(i + asciiA)!)
            }
            
            return newPassword
        }

        func isPasswordValid(_ password: String) -> Bool {
            if password.contains("i") || password.contains("o") || password.contains("l") {
                return false
            }
            
            let characterArray = password.map({ String($0).asciiValue - asciiA })
            var increasingSequenceFound = false
            for i in 0...5 {
                let c0 = Int(characterArray[i])
                let c1 = Int(characterArray[i + 1])
                let c2 = Int(characterArray[i + 2])
                if (c0 + 1) == c1  && (c1 + 1) == c2 {
                    increasingSequenceFound = true
                }
            }
            
            if !increasingSequenceFound {
                return false
            }
            
            var duplicatePositionArray: [Int] = []
            for i in 0...6 {
                let c0 = characterArray[i]
                let c1 = characterArray[i + 1]
                if c0 == c1 {
                    duplicatePositionArray.append(i)
                }
            }
            
            if duplicatePositionArray.count < 2 {
                return false
            }
            
            let firstEntry = duplicatePositionArray.first!
            let lastEntry = duplicatePositionArray.last!
            if lastEntry - firstEntry == 1 {
                return false
            }
            
            return true
        }

        func getNextValidPassword(_ oldPassword: String) -> String {
            var pw = oldPassword
            repeat {
                pw = nextPassword(pw)
            } while !isPasswordValid(pw)
            
            return pw
        }

        let part1Password = getNextValidPassword(PuzzleInput.final)
        let part2Password = getNextValidPassword(part1Password)
        return (part1Password, part2Password)
    }
    
}

fileprivate class PuzzleInput: NSObject {

    static let final = "hepxcrrq"

}

