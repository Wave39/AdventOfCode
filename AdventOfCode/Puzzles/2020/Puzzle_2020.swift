//
//  Puzzle_2020.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 11/24/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2020 {
    
    func solve(puzzleNumber: Int) {
        
        if puzzleNumber == 1 {
            Puzzle_2020_01().solve()
        } else if puzzleNumber == 2 {
            Puzzle_2020_02().solve()
        } else if puzzleNumber == 3 {
             Puzzle_2020_03().solve()
        } else if puzzleNumber == 4 {
            Puzzle_2020_04().solve()
        } else if puzzleNumber == 5 {
            Puzzle_2020_05().solve()
        } else if puzzleNumber == 6 {
            Puzzle_2020_06().solve()
        } else if puzzleNumber == 7 {
            Puzzle_2020_07().solve()
        } else if puzzleNumber == 8 {
            Puzzle_2020_08().solve()
        } else if puzzleNumber == 9 {
            Puzzle_2020_09().solve()
        } else if puzzleNumber == 10 {
            Puzzle_2020_10().solve()
        } else if puzzleNumber == 11 {
            Puzzle_2020_11().solve()
        } else if puzzleNumber == 12 {
            Puzzle_2020_12().solve()
        } else if puzzleNumber == 13 {
            Puzzle_2020_13().solve()
        } else if puzzleNumber == 14 {
            Puzzle_2020_14().solve()
        } else if puzzleNumber == 15 {
            Puzzle_2020_15().solve()
        } else if puzzleNumber == 16 {
            Puzzle_2020_16().solve()
        } else if puzzleNumber == 17 {
            Puzzle_2020_17().solve()
        } else if puzzleNumber == 18 {
            Puzzle_2020_18().solve()
        } else if puzzleNumber == 19 {
            Puzzle_2020_19().solve()
        } else if puzzleNumber == 20 {
            Puzzle_2020_20().solve()
        } else if puzzleNumber == 21 {
            Puzzle_2020_21().solve()
        } else if puzzleNumber == 22 {
            Puzzle_2020_22().solve()
        } else if puzzleNumber == 23 {
            Puzzle_2020_23().solve()
        } else if puzzleNumber == 24 {
            Puzzle_2020_24().solve()
        } else if puzzleNumber == 25 {
            Puzzle_2020_25().solve()
        } else {
            print ("The puzzle number \(puzzleNumber) was not found.")
        }
        
    }
    
}

// template for new puzzle classes

class Puzzle_2020_XX : PuzzleBaseClass {

    func solve() {
        let part1 = solvePart1()
        print ("Part 1 solution: \(part1)")
        
        let part2 = solvePart2()
        print ("Part 2 solution: \(part2)")
    }

    func solvePart1() -> Int {
        return solvePart1(str: Puzzle_Input.puzzleInput)
    }
    
    func solvePart2() -> Int {
        return solvePart2(str: Puzzle_Input.puzzleInput)
    }
    
    func solvePart1(str: String) -> Int {
        let lines = str.parseIntoStringArray()
        return lines.count
    }
    
    func solvePart2(str: String) -> Int {
        let lines = str.parseIntoStringArray()
        return lines.count
    }
    
}

private class Puzzle_Input: NSObject {

    static let puzzleInput_test = """
Line 1
Line 2
"""

    static let puzzleInput = """
Line 1
Line 2
"""

}
