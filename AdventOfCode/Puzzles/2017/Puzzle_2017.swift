//
//  Puzzle_2017.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/5/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2017 {
    
    func solve(puzzleNumber: Int) {
        
        if puzzleNumber == 1 {
            Puzzle_2017_01().solve()
        } else if puzzleNumber == 2 {
            Puzzle_2017_02().solve()
        } else if puzzleNumber == 3 {
            Puzzle_2017_03().solve()
        } else if puzzleNumber == 4 {
            Puzzle_2017_04().solve()
        } else if puzzleNumber == 5 {
            Puzzle_2017_05().solve()
        } else if puzzleNumber == 6 {
            Puzzle_2017_06().solve()
        } else if puzzleNumber == 7 {
            Puzzle_2017_07().solve()
        } else if puzzleNumber == 8 {
            Puzzle_2017_08().solve()
        } else if puzzleNumber == 9 {
            Puzzle_2017_09().solve()
        } else if puzzleNumber == 10 {
            Puzzle_2017_10().solve()
        } else if puzzleNumber == 11 {
            Puzzle_2017_11().solve()
        } else if puzzleNumber == 12 {
            Puzzle_2017_12().solve()
        } else if puzzleNumber == 13 {
            //Puzzle_2017_13().solve()
        } else if puzzleNumber == 14 {
            //Puzzle_2017_14().solve()
        } else if puzzleNumber == 15 {
            //Puzzle_2017_15().solve()
        } else if puzzleNumber == 16 {
            //Puzzle_2017_16().solve()
        } else if puzzleNumber == 17 {
            //Puzzle_2017_17().solve()
        } else if puzzleNumber == 18 {
            //Puzzle_2017_18().solve()
        } else if puzzleNumber == 19 {
            //Puzzle_2017_19().solve()
        } else if puzzleNumber == 20 {
            //Puzzle_2017_20().solve()
        } else if puzzleNumber == 21 {
            //Puzzle_2017_21().solve()
        } else if puzzleNumber == 22 {
            //Puzzle_2017_22().solve()
        } else if puzzleNumber == 23 {
            //Puzzle_2017_23().solve()
        } else if puzzleNumber == 24 {
            //Puzzle_2017_24().solve()
        } else if puzzleNumber == 25 {
            //Puzzle_2017_25().solve()
        } else {
            print ("The puzzle number \(puzzleNumber) was not found.")
        }
        
    }
    
}

// template for new puzzle classes

class Puzzle_2017_XX : PuzzleBaseClass {

    func solve() {
        let part1 = solvePart1()
        print ("Part 1 solution: \(part1)")
        
        let part2 = solvePart2()
        print ("Part 2 solution: \(part2)")
    }

    func solvePart1() -> Int {
        return solvePart1(str: Puzzle_2017_XX_Input.puzzleInput)
    }
    
    func solvePart2() -> Int {
        return solvePart2(str: Puzzle_2017_XX_Input.puzzleInput)
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

fileprivate class Puzzle_2017_XX_Input: NSObject {

    static let puzzleInput = """
Line 1
Line 2
"""

}
