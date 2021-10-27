//
//  Puzzle_2019_07.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/7/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2019_07 : PuzzleBaseClass {
    
    func solve() {
        let part1 = solvePart1()
        print ("Part 1 solution: \(part1)")
        
        let part2 = solvePart2()
        print ("Part 2 solution: \(part2)")
    }
    
    func solvePart1() -> Int {
        return solvePart1(str: Puzzle_2019_07_Input.puzzleInput, inputSignal: 0)
    }
    
    func solvePart2() -> Int {
        return solvePart2(str: Puzzle_2019_07_Input.puzzleInput, inputSignal: 0)
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
    
    func ProcessProgramPart2(program: inout [Int], inputArray: inout [Int], programCounter: inout Int) -> (Int, Bool) {
        func GetValue(_ immediate: Bool, _ value: Int) -> Int {
            return (immediate ? value : program[value])
        }

        var retval = 0
        while program[programCounter] != 99 {
            let opcode = program[programCounter] % 100
            let immediateC = (program[programCounter] / 100 % 10 > 0)
            let immediateB = (program[programCounter] / 1000 % 10 > 0)
            let p1 = program[programCounter + 1]
            let p2 = program[programCounter + 2]
            let p3 = (programCounter + 3 < program.count ? program[programCounter + 3] : 0)
            if opcode == 1 {
                program[p3] = GetValue(immediateC, p1) + GetValue(immediateB, p2)
                programCounter += 4
            } else if opcode == 2 {
                program[p3] = GetValue(immediateC, p1) * GetValue(immediateB, p2)
                programCounter += 4
            } else if opcode == 3 {
                program[p1] = inputArray.first!
                inputArray.removeFirst()
                programCounter += 2
            } else if opcode == 4 {
                retval = GetValue(immediateC, p1)
                //print (retval)
                programCounter += 2
                return (retval, false)
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
                program[p3] = (GetValue(immediateC, p1) < GetValue(immediateB, p2) ? 1 : 0)
                programCounter += 4
            } else if opcode == 8 {
                program[p3] = (GetValue(immediateC, p1) == GetValue(immediateB, p2) ? 1 : 0)
                programCounter += 4
            } else {
                print ("Unknown opcode \(opcode) at program counter \(programCounter)")
            }
        }
        
        return (retval, true)
    }
    
    func solvePart1(str: String, inputSignal: Int) -> Int {
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

    func solvePart2(str: String, inputSignal: Int) -> Int {
        let arr = str.parseIntoIntArray(separator: ",")
        let phaseCombinations = [9, 8, 7, 6, 5].generatePermutations()
        var largestOutput = 0
        
        for phase in phaseCombinations {
            var aProgram: [Int] = [], bProgram: [Int] = [], cProgram: [Int] = [], dProgram: [Int] = [], eProgram: [Int] = []
            var aProgramCounter = 0, bProgramCounter = 0, cProgramCounter = 0, dProgramCounter = 0, eProgramCounter = 0
            var aInputValues: [Int] = [], bInputValues: [Int] = [], cInputValues: [Int] = [], dInputValues: [Int] = [], eInputValues: [Int] = []
            
            var leaveLoop = false
            var eOutput = 0
            while !leaveLoop {
                if aProgram.count == 0 {
                    aProgram = arr
                    aProgramCounter = 0
                    aInputValues = [ phase[0], inputSignal ]
                } else {
                    aInputValues = [ eOutput ]
                }
                
                let aResults = ProcessProgramPart2(program: &aProgram, inputArray: &aInputValues, programCounter: &aProgramCounter)
                
                if bProgram.count == 0 {
                    bProgram = arr
                    bProgramCounter = 0
                    bInputValues = [ phase[1], aResults.0 ]
                } else {
                    bInputValues = [ aResults.0 ]
                }
                
                let bResults = ProcessProgramPart2(program: &bProgram, inputArray: &bInputValues, programCounter: &bProgramCounter)
                
                if cProgram.count == 0 {
                    cProgram = arr
                    cProgramCounter = 0
                    cInputValues = [ phase[2], bResults.0 ]
                } else {
                    cInputValues = [ bResults.0 ]
                }
                    
                let cResults = ProcessProgramPart2(program: &cProgram, inputArray: &cInputValues, programCounter: &cProgramCounter)
                
                if dProgram.count == 0 {
                    dProgram = arr
                    dProgramCounter = 0
                    dInputValues = [ phase[3], cResults.0 ]
                } else {
                    dInputValues = [ cResults.0 ]
                }
                
                let dResults = ProcessProgramPart2(program: &dProgram, inputArray: &dInputValues, programCounter: &dProgramCounter)
                
                if eProgram.count == 0 {
                    eProgram = arr
                    eProgramCounter = 0
                    eInputValues = [ phase[4], dResults.0 ]
                } else {
                    eInputValues = [ dResults.0 ]
                }
                
                let eResults = ProcessProgramPart2(program: &eProgram, inputArray: &eInputValues, programCounter: &eProgramCounter)
                
                if eResults.1 {
                    leaveLoop = true
                    if eOutput > largestOutput {
                        largestOutput = eOutput
                    }
                } else {
                    eOutput = eResults.0
                }
            }
        }
        
        return largestOutput
    }
}

private class Puzzle_2019_07_Input: NSObject {

    static let puzzleInput_test1 = """
3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0
"""
    
    static let puzzleInput_test2 = """
3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0
"""
    
    static let puzzleInput_test3 = """
3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0
"""
    
    static let puzzleInput_test4 = """
3,26,1001,26,-4,26,3,27,1002,27,2,27,1,27,26,27,4,27,1001,28,-1,28,1005,28,6,99,0,0,5
"""
    
    static let puzzleInput_test5 = """
3,52,1001,52,-5,52,3,53,1,52,56,54,1007,54,5,55,1005,55,26,1001,54,-5,54,1105,1,12,1,53,54,53,1008,54,0,55,1001,55,1,55,2,53,55,53,4,53,1001,56,-1,56,1005,56,6,99,0,0,0,0,10
"""
    
    static let puzzleInput = """
3,8,1001,8,10,8,105,1,0,0,21,46,63,76,97,118,199,280,361,442,99999,3,9,102,4,9,9,101,2,9,9,1002,9,5,9,101,4,9,9,102,2,9,9,4,9,99,3,9,101,5,9,9,102,3,9,9,101,3,9,9,4,9,99,3,9,1001,9,2,9,102,3,9,9,4,9,99,3,9,1002,9,5,9,101,4,9,9,1002,9,3,9,101,2,9,9,4,9,99,3,9,1002,9,5,9,101,3,9,9,1002,9,5,9,1001,9,5,9,4,9,99,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,102,2,9,9,4,9,99,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,99,3,9,101,1,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,99
"""

}
