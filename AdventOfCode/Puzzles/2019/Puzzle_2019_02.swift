//
//  Puzzle_2019_02.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/4/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2019_02 : PuzzleBaseClass {
    
    func solve() {
        let part1 = solvePart1()
        print ("Part 1 solution: \(part1)")
        
        let part2 = solvePart2()
        print ("Part 2 solution: \(part2)")
    }
    
    func solvePart1() -> Int {
        return solvePart1(str: Puzzle_2019_02_Input.puzzleInput)
    }
    
    func solvePart2() -> Int {
        return solvePart2(str: Puzzle_2019_02_Input.puzzleInput)
    }
    
    func ProcessProgram(program: [Int]) -> Int {
        var arr = program
        var programCounter = 0
        while arr[programCounter] != 99 {
            let v1 = arr[arr[programCounter + 1]]
            let v2 = arr[arr[programCounter + 2]]
            let v: Int
            if arr[programCounter] == 1 {
                v = v1 + v2
            } else {
                v = v1 * v2
            }
            
            arr[arr[programCounter + 3]] = v
            programCounter += 4
        }
        
        return arr[0]
    }
    
    func solvePart1(str: String) -> Int {
        var arr = str.parseIntoIntArray(separator: ",")
        arr[1] = 12
        arr[2] = 2
        return ProcessProgram(program: arr)
    }

    func solvePart2(str: String) -> Int {
        let originalArray = str.parseIntoIntArray(separator: ",")
        for noun in 0...99 {
            for verb in 0...99 {
                var arr = originalArray
                arr[1] = noun
                arr[2] = verb
                if ProcessProgram(program: arr) == 19690720 {
                    return noun * 100 + verb
                }
            }
        }
        
        return -1
    }
}

private class Puzzle_2019_02_Input: NSObject {

    static let puzzleInput = """
1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,9,19,1,19,5,23,2,23,13,27,1,10,27,31,2,31,6,35,1,5,35,39,1,39,10,43,2,9,43,47,1,47,5,51,2,51,9,55,1,13,55,59,1,13,59,63,1,6,63,67,2,13,67,71,1,10,71,75,2,13,75,79,1,5,79,83,2,83,9,87,2,87,13,91,1,91,5,95,2,9,95,99,1,99,5,103,1,2,103,107,1,10,107,0,99,2,14,0,0
"""

}
