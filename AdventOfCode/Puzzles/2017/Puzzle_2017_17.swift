//
//  Puzzle_2017_17.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/18/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2017_17 : PuzzleBaseClass {

    func solve() {
        let part1Solution = solvePart1()
        print ("Part 1 solution: \(part1Solution)")
        
        let part2Solution = solvePart2()
        print ("Part 2 solution: \(part2Solution)")
    }
    
    func solvePart1() -> Int {
        return solvePart1(puzzleInput: Puzzle_2017_17_Input.puzzleInput_part1)
    }
    
    func solvePart2() -> Int {
        return solvePart2(puzzleInput: Puzzle_2017_17_Input.puzzleInput_part2)
    }
    
    func createBuffer(step: Int, maxValue: Int) -> [Int] {
        var currentIndex = 0
        var buffer: [Int] = [ 0 ]
        for idx in 1...maxValue {
            currentIndex = (currentIndex + step) % idx + 1
            buffer.insert(idx, at: currentIndex)
        }
        
        return buffer
    }
    
    func solvePart1(puzzleInput: (Int, Int, Int)) -> Int {
        let step = puzzleInput.0
        let maxValue = puzzleInput.1
        let searchValue = puzzleInput.2
        let buffer = createBuffer(step: step, maxValue: maxValue)
        let idx = buffer.firstIndex(of: searchValue)
        return buffer[idx! + 1]
    }
    
    func solvePart2(puzzleInput: (Int, Int, Int)) -> Int {
        let step = puzzleInput.0
        let maxValue = puzzleInput.1
        var retval = 0
        var nextIndex = 0
        for idx in 1...maxValue {
            nextIndex = (nextIndex + step) % idx + 1
            if nextIndex == 1 {
                retval = idx
            }
        }
        
        return retval
    }

}

private class Puzzle_2017_17_Input: NSObject {

    static let puzzleInput_test1 = ( 3, 2017, 2017 )

    static let puzzleInput_part1 = ( 324, 2017, 2017 )
    static let puzzleInput_part2 = ( 324, 50000000, 0 )

}
