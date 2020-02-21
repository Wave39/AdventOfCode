//
//  Puzzle_2015_04.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/21/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2015_04 : PuzzleBaseClass {

    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }
    
    func solveBothParts() -> (Int, Int) {
        var counter = 1
        var fiveZeroCounter = 0
        var sixZeroCounter = 0

        while fiveZeroCounter == 0 || sixZeroCounter == 0 {
            let md5String = "\(PuzzleInput.final)\(counter)".md5
            if md5String.hasPrefix("00000") {
                if fiveZeroCounter == 0 {
                    fiveZeroCounter = counter
                }
                
                if md5String.hasPrefix("000000") {
                    if sixZeroCounter == 0 {
                        sixZeroCounter = counter
                    }
                }
            }
            
            counter = counter + 1
        }

        return (fiveZeroCounter, sixZeroCounter)
    }

}

fileprivate class PuzzleInput: NSObject {

    static let final = "ckczppom"

}

