//
//  Puzzle_2019_07.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/7/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2019_07 : PuzzleBaseClass {
    
    public func solve() {
        let part1 = solvePart1(str: Puzzle_2019_07_Input.puzzleInput, inputSignal: 0)
        print ("Part 1 solution: \(part1)")
        
        //let part2 = solvePart2(str: Puzzle_2019_07_Input.puzzleInput)
        //print ("Part 2 solution: \(part2)")
    }
    
    func ProcessProgram(program: [Int], inputArray: [Int]) -> Int {
        var inputArr = inputArray
        var arr = program
        
        func GetValue(_ immediate: Bool, _ value: Int) -> Int {
            return (immediate ? value : arr[value])
        }

        var retval = 0
        var programCounter = 0
        while arr[programCounter] != 99 {
            let opcode = arr[programCounter] % 100
            let immediateC = (arr[programCounter] / 100 % 10 > 0)
            let immediateB = (arr[programCounter] / 1000 % 10 > 0)
            let p1 = arr[programCounter + 1]
            let p2 = arr[programCounter + 2]
            let p3 = arr[programCounter + 3]
            if opcode == 1 {
                arr[p3] = GetValue(immediateC, p1) + GetValue(immediateB, p2)
                programCounter += 4
            } else if opcode == 2 {
                arr[p3] = GetValue(immediateC, p1) * GetValue(immediateB, p2)
                programCounter += 4
            } else if opcode == 3 {
                arr[p1] = inputArr.first!
                inputArr.removeFirst()
                programCounter += 2
            } else if opcode == 4 {
                retval = GetValue(immediateC, p1)
                //print (retval)
                programCounter += 2
            } else if opcode == 5 {
                if GetValue(immediateC, p1) != 0 {
                    programCounter = GetValue(immediateB, p2)
                } else {
                    programCounter += 3
                }
            } else if opcode == 6 {
                if GetValue(immediateC, p1) == 0 {
                    programCounter = GetValue(immediateB, p2)
                } else {
                    programCounter += 3
                }
            } else if opcode == 7 {
                arr[p3] = (GetValue(immediateC, p1) < GetValue(immediateB, p2) ? 1 : 0)
                programCounter += 4
            } else if opcode == 8 {
                arr[p3] = (GetValue(immediateC, p1) == GetValue(immediateB, p2) ? 1 : 0)
                programCounter += 4
            } else {
                print ("Unknown opcode \(opcode) at program counter \(programCounter)")
            }
        }
        
        return retval
    }
    
    public func solvePart1(str: String, inputSignal: Int) -> Int {
        let arr = str.parseIntoIntArray(separator: ",")
        let phaseCombinations = [0, 1, 2, 3, 4].generatePermutations()
        var largestOutput = 0
        for phase in phaseCombinations {
            let outputA = ProcessProgram(program: arr, inputArray: [phase[0], inputSignal])
            let outputB = ProcessProgram(program: arr, inputArray: [phase[1], outputA])
            let outputC = ProcessProgram(program: arr, inputArray: [phase[2], outputB])
            let outputD = ProcessProgram(program: arr, inputArray: [phase[3], outputC])
            let outputE = ProcessProgram(program: arr, inputArray: [phase[4], outputD])
            if outputE > largestOutput {
                largestOutput = outputE
            }
        }
        
        return largestOutput
    }

    public func solvePart2(str: String) -> Int {
        let arr = str.parseIntoIntArray(separator: ",")
        return ProcessProgram(program: arr, inputArray: [5, 5])
    }
}

public class Puzzle_2019_07_Input: NSObject {

    static let puzzleInput_test1 = """
3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0
"""
    
    static let puzzleInput_test2 = """
3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0
"""
    
    static let puzzleInput_test3 = """
3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0
"""
    
    static let puzzleInput = """
3,8,1001,8,10,8,105,1,0,0,21,46,63,76,97,118,199,280,361,442,99999,3,9,102,4,9,9,101,2,9,9,1002,9,5,9,101,4,9,9,102,2,9,9,4,9,99,3,9,101,5,9,9,102,3,9,9,101,3,9,9,4,9,99,3,9,1001,9,2,9,102,3,9,9,4,9,99,3,9,1002,9,5,9,101,4,9,9,1002,9,3,9,101,2,9,9,4,9,99,3,9,1002,9,5,9,101,3,9,9,1002,9,5,9,1001,9,5,9,4,9,99,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,99,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,99,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,99
"""

}
