//
//  Puzzle_2019_05.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/5/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2019_05: PuzzleBaseClass {
    func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    func solvePart1() -> Int {
        solvePart1(str: Puzzle_2019_05_Input.puzzleInput)
    }

    func solvePart2() -> Int {
        solvePart2(str: Puzzle_2019_05_Input.puzzleInput)
    }

    func ProcessProgram(program: [Int], input: Int) -> Int {
        var arr = program

        func GetValue(_ immediate: Bool, _ value: Int) -> Int {
            (immediate ? value : arr[value])
        }

        var retval = 0
        var programCounter = 0
        while arr[programCounter] != 99 {
            let opcode = arr[programCounter] % 100
            let immediateC = (arr[programCounter] / 100 % 10 > 0)
            let immediateB = (arr[programCounter] / 1_000 % 10 > 0)
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
                arr[p1] = input
                programCounter += 2
            } else if opcode == 4 {
                retval = GetValue(immediateC, p1)
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
                print("Unknown opcode \(opcode) at program counter \(programCounter)")
            }
        }

        return retval
    }

    func solvePart1(str: String) -> Int {
        let arr = str.parseIntoIntArray(separator: ",")
        return ProcessProgram(program: arr, input: 1)
    }

    func solvePart2(str: String) -> Int {
        let arr = str.parseIntoIntArray(separator: ",")
        return ProcessProgram(program: arr, input: 5)
    }
}

private class Puzzle_2019_05_Input: NSObject {
    static let puzzleInput = """
3,225,1,225,6,6,1100,1,238,225,104,0,101,20,183,224,101,-63,224,224,4,224,1002,223,8,223,101,6,224,224,1,223,224,223,1101,48,40,225,1101,15,74,225,2,191,40,224,1001,224,-5624,224,4,224,1002,223,8,223,1001,224,2,224,1,223,224,223,1101,62,60,225,1102,92,15,225,102,59,70,224,101,-885,224,224,4,224,1002,223,8,223,101,7,224,224,1,224,223,223,1,35,188,224,1001,224,-84,224,4,224,102,8,223,223,1001,224,2,224,1,223,224,223,1001,66,5,224,1001,224,-65,224,4,224,102,8,223,223,1001,224,3,224,1,223,224,223,1002,218,74,224,101,-2960,224,224,4,224,1002,223,8,223,1001,224,2,224,1,224,223,223,1101,49,55,224,1001,224,-104,224,4,224,102,8,223,223,1001,224,6,224,1,224,223,223,1102,43,46,225,1102,7,36,225,1102,76,30,225,1102,24,75,224,101,-1800,224,224,4,224,102,8,223,223,101,2,224,224,1,224,223,223,1101,43,40,225,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,1008,226,226,224,1002,223,2,223,1005,224,329,1001,223,1,223,8,226,677,224,102,2,223,223,1006,224,344,1001,223,1,223,1007,226,677,224,1002,223,2,223,1005,224,359,101,1,223,223,1008,677,226,224,102,2,223,223,1006,224,374,1001,223,1,223,1107,226,677,224,1002,223,2,223,1006,224,389,1001,223,1,223,107,677,677,224,1002,223,2,223,1006,224,404,101,1,223,223,1007,226,226,224,1002,223,2,223,1006,224,419,101,1,223,223,7,677,226,224,1002,223,2,223,1005,224,434,1001,223,1,223,1007,677,677,224,1002,223,2,223,1006,224,449,101,1,223,223,107,226,226,224,1002,223,2,223,1006,224,464,1001,223,1,223,1108,677,677,224,1002,223,2,223,1005,224,479,101,1,223,223,8,677,226,224,1002,223,2,223,1006,224,494,101,1,223,223,7,226,677,224,102,2,223,223,1005,224,509,1001,223,1,223,1107,677,226,224,102,2,223,223,1005,224,524,1001,223,1,223,1108,677,226,224,1002,223,2,223,1005,224,539,1001,223,1,223,1108,226,677,224,102,2,223,223,1006,224,554,101,1,223,223,108,226,677,224,102,2,223,223,1005,224,569,1001,223,1,223,8,677,677,224,1002,223,2,223,1005,224,584,101,1,223,223,108,677,677,224,1002,223,2,223,1005,224,599,1001,223,1,223,108,226,226,224,102,2,223,223,1006,224,614,101,1,223,223,1008,677,677,224,102,2,223,223,1006,224,629,1001,223,1,223,107,226,677,224,102,2,223,223,1006,224,644,101,1,223,223,1107,677,677,224,1002,223,2,223,1005,224,659,1001,223,1,223,7,226,226,224,1002,223,2,223,1005,224,674,101,1,223,223,4,223,99,226
"""
}
