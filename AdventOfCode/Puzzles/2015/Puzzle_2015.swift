//
//  Puzzle_2015.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/14/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2015 {
    
    func solve(puzzleNumber: Int) {
        
        if puzzleNumber == 1 {
            Puzzle_2015_01().solve()
        } else if puzzleNumber == 2 {
            Puzzle_2015_02().solve()
        } else if puzzleNumber == 3 {
            Puzzle_2015_03().solve()
        } else if puzzleNumber == 4 {
            Puzzle_2015_04().solve()
        } else if puzzleNumber == 5 {
            Puzzle_2015_05().solve()
        } else if puzzleNumber == 6 {
            Puzzle_2015_06().solve()
        } else if puzzleNumber == 7 {
            Puzzle_2015_07().solve()
        } else if puzzleNumber == 8 {
            Puzzle_2015_08().solve()
        } else if puzzleNumber == 9 {
            Puzzle_2015_09().solve()
        } else if puzzleNumber == 10 {
            Puzzle_2015_10().solve()
        } else if puzzleNumber == 11 {
            Puzzle_2015_11().solve()
        } else if puzzleNumber == 12 {
            Puzzle_2015_12().solve()
        } else if puzzleNumber == 13 {
            Puzzle_2015_13().solve()
        } else if puzzleNumber == 14 {
            Puzzle_2015_14().solve()
        } else if puzzleNumber == 15 {
            Puzzle_2015_15().solve()
        } else if puzzleNumber == 16 {
            Puzzle_2015_16().solve()
        } else if puzzleNumber == 17 {
            Puzzle_2015_17().solve()
        } else if puzzleNumber == 18 {
            Puzzle_2015_18().solve()
        } else if puzzleNumber == 19 {
            Puzzle_2015_19().solve()
        } else if puzzleNumber == 20 {
            Puzzle_2015_20().solve()
        } else if puzzleNumber == 21 {
            Puzzle_2015_21().solve()
        } else if puzzleNumber == 22 {
            Puzzle_2015_22().solve()
        } else if puzzleNumber == 23 {
            Puzzle_2015_23().solve()
        } else if puzzleNumber == 24 {
            Puzzle_2015_24().solve()
        } else if puzzleNumber == 25 {
            //Puzzle_2015_25().solve()
        } else {
            print ("The puzzle number \(puzzleNumber) was not found.")
        }
        
    }
    
}

// template for new puzzle classes

class Puzzle_2015_XX : PuzzleBaseClass {

    func solve() {
        let part1 = solvePart1()
        print ("Part 1 solution: \(part1)")
        
        let part2 = solvePart2()
        print ("Part 2 solution: \(part2)")
    }

    func solvePart1() -> Int {
        return solvePart1(str: PuzzleInput.final)
    }
    
    func solvePart2() -> Int {
        return solvePart2(str: PuzzleInput.final)
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

fileprivate class PuzzleInput: NSObject {

    static let final = """
Line 1
Line 2
"""

}

