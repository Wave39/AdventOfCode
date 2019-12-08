//
//  Puzzle_2019.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/4/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2019 {
    
    func solve(puzzleNumber: Int) {
        
        if puzzleNumber == 1 {
            Puzzle_2019_01().solve()
        } else if puzzleNumber == 2 {
            Puzzle_2019_02().solve()
        } else if puzzleNumber == 3 {
            Puzzle_2019_03().solve()
        } else if puzzleNumber == 4 {
            Puzzle_2019_04().solve()
        } else if puzzleNumber == 5 {
            Puzzle_2019_05().solve()
        } else if puzzleNumber == 6 {
            Puzzle_2019_06().solve()
        } else if puzzleNumber == 7 {
            Puzzle_2019_07().solve()
        } else if puzzleNumber == 8 {
            Puzzle_2019_08().solve()
        } else {
            print ("The puzzle number \(puzzleNumber) was not found.")
        }
        
    }
    
}

// template for new puzzle classes

public class Puzzle_2019_XX : PuzzleBaseClass {

    public func solve() {
        let part1 = solvePart1(str: Puzzle_2019_XX_Input.puzzleInput)
        print ("Part 1 solution: \(part1)")
        
        let part2 = solvePart2(str: Puzzle_2019_XX_Input.puzzleInput)
        print ("Part 2 solution: \(part2)")
    }

    public func solvePart1(str: String) -> Int {
        let arr = str.parseIntoStringArray()
        return arr.count
    }
    
    public func solvePart2(str: String) -> Int {
        let arr = str.parseIntoStringArray()
        return arr.count
    }
    
}

public class Puzzle_2019_XX_Input: NSObject {

    static let puzzleInput = """
Line 1
Line 2
"""

}
