//
//  Puzzle_2020_01.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 11/24/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2020_01 : PuzzleBaseClass {

    func solve() {
        let part1 = solvePart1()
        print ("Part 1 solution: \(part1)")
        
        let part2 = solvePart2()
        print ("Part 2 solution: \(part2)")
    }

    func solvePart1() -> Int {
        return solvePart1(str: Puzzle_2020_01_Input.puzzleInput)
    }
    
    func solvePart2() -> Int {
        return solvePart2(str: Puzzle_2020_01_Input.puzzleInput)
    }
    
    func solvePart1(str: String) -> Int {
        let arr = str.parseIntoStringArray()
        return arr.count
    }
    
    func solvePart2(str: String) -> Int {
        let arr = str.parseIntoStringArray()
        return arr.count
    }
    
}

fileprivate class Puzzle_2020_01_Input: NSObject {

    static let puzzleInput = """
Line 1
Line 2
"""

}
