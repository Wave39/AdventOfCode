//
//  Puzzle_2019_19.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/21/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2019_19: PuzzleBaseClass {

    func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    func solvePart1() -> Int {
        solvePart1(str: Puzzle_2019_19_Input.puzzleInput)
    }

    func solvePart2() -> Int {
        solvePart2(str: Puzzle_2019_19_Input.puzzleInput)
    }

    var originalProgram: [Int] = []

    func getXCoordinates(y: Int) -> [Int] {
        var retval: [Int] = []
        for x in 0..<(y + 10) {
            var arr = originalProgram
            var programCounter = 0
            var relativeBase = 0
            var expandedMemory: [ Int: Int ] = [:]
            var inputSignal = [x, y]
            let results = ProcessProgram19(program: &arr, inputSignal: &inputSignal, programCounter: &programCounter, relativeBase: &relativeBase, expandedMemory: &expandedMemory)
            if results.0 == 1 {
                retval.append(x)
            }
        }

        return retval
    }

    func solvePart1(str: String) -> Int {
        originalProgram = str.parseIntoIntArray(separator: ",")
        var retval = 0
        for y in 0..<50 {
            let xCoordinates = getXCoordinates(y: y)
            retval += xCoordinates.count
        }

        return retval
    }

    func solvePart2(str: String) -> Int {
        originalProgram = str.parseIntoIntArray(separator: ",")
        // I arrived at the starting y value below through some rough trial and error
        for y in 1240...1500 {
            let xCoordinates = getXCoordinates(y: y)
            let xRight = xCoordinates.max() ?? 0
            let x2Coordinates = getXCoordinates(y: y + 99)
            if x2Coordinates.contains(xRight - 99) {
                return (xRight - 99) * 10000 + y
            }
        }

        return -1
    }

    func ProcessProgram19(program: inout [Int], inputSignal: inout [Int], programCounter: inout Int, relativeBase: inout Int, expandedMemory: inout Dictionary<Int, Int>) -> (Int, Bool) {
        enum ParameterMode {
            case position
            case immediate
            case relative
        }

        func GetMemory(_ pointer: Int) -> Int {
            if pointer < program.count {
                return program[pointer]
            } else {
                if expandedMemory[pointer] == nil {
                    expandedMemory[pointer] = 0
                }

                return expandedMemory[pointer] ?? 0
            }
        }

        func SetMemory(_ pointer: Int, _ value: Int) {
            if pointer < program.count {
                program[pointer] = value
            } else {
                expandedMemory[pointer] = value
            }
        }

        func GetValue(_ parameterMode: ParameterMode, _ value: Int, _ writeParameter: Bool) -> Int {
            if parameterMode == .relative {
                return writeParameter ? value + relativeBase : GetMemory(value + relativeBase)
            } else if parameterMode == .position {
                return writeParameter ? value : GetMemory(value)
            } else {
                return value
            }
        }

        while program[programCounter] != 99 {
            let opcode = program[programCounter] % 100
            var cParameterMode: ParameterMode
            if program[programCounter] / 100 % 10 == 1 {
                cParameterMode = .immediate
            } else if program[programCounter] / 100 % 10 == 2 {
                cParameterMode = .relative
            } else {
                cParameterMode = .position
            }

            var bParameterMode: ParameterMode
            if program[programCounter] / 1000 % 10 == 1 {
                bParameterMode = .immediate
            } else if program[programCounter] / 1000 % 10 == 2 {
                bParameterMode = .relative
            } else {
                bParameterMode = .position
            }

            var aParameterMode: ParameterMode
            if program[programCounter] / 10000 % 10 == 1 {
                aParameterMode = .immediate
            } else if program[programCounter] / 10000 % 10 == 2 {
                aParameterMode = .relative
            } else {
                aParameterMode = .position
            }

            var p1 = 0, p2 = 0, p3 = 0

            func SetParameterValues(_ numberOfParameters: Int, _ writeParameter: Int) {
                if numberOfParameters >= 1 {
                    p1 = GetValue(cParameterMode, program[programCounter + 1], writeParameter == 1)
                }

                if numberOfParameters >= 2 {
                    p2 = GetValue(bParameterMode, program[programCounter + 2], writeParameter == 2)
                }

                if numberOfParameters >= 3 {
                    p3 = GetValue(aParameterMode, program[programCounter + 3], writeParameter == 3)
                }
            }

            if opcode == 1 {
                SetParameterValues(3, 3)
                SetMemory(p3, p1 + p2)
                programCounter += 4
            } else if opcode == 2 {
                SetParameterValues(3, 3)
                SetMemory(p3, p1 * p2)
                programCounter += 4
            } else if opcode == 3 {
                if inputSignal.isEmpty {
                    print("Ran out of input")
                    return (-1, false)
                }

                SetParameterValues(1, 1)
                SetMemory(p1, inputSignal.first ?? 0)
                inputSignal.remove(at: 0)
                programCounter += 2
            } else if opcode == 4 {
                SetParameterValues(1, 0)
                // print(p1)
                programCounter += 2
                return (p1, true)
            } else if opcode == 5 {
                SetParameterValues(2, 0)
                if p1 != 0 {
                    programCounter = p2
                } else {
                    programCounter += 3
                }
            } else if opcode == 6 {
                SetParameterValues(2, 0)
                if p1 == 0 {
                    programCounter = p2
                } else {
                    programCounter += 3
                }
            } else if opcode == 7 {
                SetParameterValues(3, 3)
                SetMemory(p3, (p1 < p2 ? 1 : 0))
                programCounter += 4
            } else if opcode == 8 {
                SetParameterValues(3, 3)
                SetMemory(p3, (p1 == p2 ? 1 : 0))
                programCounter += 4
            } else if opcode == 9 {
                SetParameterValues(1, 0)
                relativeBase += p1
                programCounter += 2
            } else {
                print("Unknown opcode \(opcode) at program counter \(programCounter)")
                return (-1, false)
            }
        }

        return (-1, false)
    }

}

private class Puzzle_2019_19_Input: NSObject {

    static let puzzleInput = """
109,424,203,1,21101,11,0,0,1105,1,282,21102,1,18,0,1105,1,259,2102,1,1,221,203,1,21102,1,31,0,1106,0,282,21101,38,0,0,1105,1,259,20102,1,23,2,21202,1,1,3,21102,1,1,1,21102,57,1,0,1105,1,303,2102,1,1,222,21002,221,1,3,21002,221,1,2,21102,1,259,1,21102,1,80,0,1105,1,225,21102,145,1,2,21102,91,1,0,1106,0,303,1201,1,0,223,20102,1,222,4,21102,259,1,3,21101,225,0,2,21102,1,225,1,21101,0,118,0,1105,1,225,21001,222,0,3,21101,91,0,2,21102,1,133,0,1106,0,303,21202,1,-1,1,22001,223,1,1,21102,148,1,0,1105,1,259,1201,1,0,223,21001,221,0,4,20101,0,222,3,21101,20,0,2,1001,132,-2,224,1002,224,2,224,1001,224,3,224,1002,132,-1,132,1,224,132,224,21001,224,1,1,21102,195,1,0,105,1,109,20207,1,223,2,20101,0,23,1,21102,-1,1,3,21101,0,214,0,1105,1,303,22101,1,1,1,204,1,99,0,0,0,0,109,5,1202,-4,1,249,22101,0,-3,1,22102,1,-2,2,21202,-1,1,3,21102,1,250,0,1106,0,225,21201,1,0,-4,109,-5,2105,1,0,109,3,22107,0,-2,-1,21202,-1,2,-1,21201,-1,-1,-1,22202,-1,-2,-2,109,-3,2106,0,0,109,3,21207,-2,0,-1,1206,-1,294,104,0,99,21201,-2,0,-2,109,-3,2105,1,0,109,5,22207,-3,-4,-1,1206,-1,346,22201,-4,-3,-4,21202,-3,-1,-1,22201,-4,-1,2,21202,2,-1,-1,22201,-4,-1,1,21201,-2,0,3,21102,343,1,0,1106,0,303,1105,1,415,22207,-2,-3,-1,1206,-1,387,22201,-3,-2,-3,21202,-2,-1,-1,22201,-3,-1,3,21202,3,-1,-1,22201,-3,-1,2,22101,0,-4,1,21101,384,0,0,1105,1,303,1105,1,415,21202,-4,-1,-4,22201,-4,-3,-4,22202,-3,-2,-2,22202,-2,-4,-4,22202,-3,-2,-3,21202,-4,-1,-2,22201,-3,-2,1,21202,1,1,-4,109,-5,2105,1,0
"""

}
