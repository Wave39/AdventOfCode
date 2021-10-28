//
//  Puzzle_2019_11.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/11/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2019_11: PuzzleBaseClass {

    enum PaintColor {
        case Black
        case White
    }
    
    func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")
        
        let part2 = solvePart2()
        print("Part 2 solution:")
        var lineString = ""
        for c in part2.0 {
            lineString = lineString + String(c)
            if lineString.count == part2.1.x {
                print(lineString)
                lineString = ""
            }
        }
    }

    func solvePart1() -> Int {
        return solvePart1(str: Puzzle_2019_11_Input.puzzleInput)
    }
    
    func solvePart2() -> (String, Point2D) {
        return solvePart2(str: Puzzle_2019_11_Input.puzzleInput)
    }
    
    func ProcessProgram(program: inout [Int], inputSignal: Int, programCounter: inout Int, relativeBase: inout Int) -> ([Int], Bool) {
        enum ParameterMode {
            case position
            case immediate
            case relative
        }
        
        func CheckArraySize(_ newSize: Int) {
            if newSize > program.count {
                while program.count <= newSize + 1 {
                    program.append(0)
                }
            }
        }

        func GetValue(_ parameterMode: ParameterMode, _ value: Int, _ writeParameter: Bool) -> Int {
            if parameterMode == .relative {
                CheckArraySize(value + relativeBase)
                return writeParameter ? value + relativeBase : program[value + relativeBase]
            } else if parameterMode == .position {
                CheckArraySize(value)
                return writeParameter ? value : program[value]
            } else {
                CheckArraySize(value)
                return value
            }
        }
        
        var outputArray: [Int] = []
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
                program[p3] = p1 + p2
                programCounter += 4
            } else if opcode == 2 {
                SetParameterValues(3, 3)
                program[p3] = p1 * p2
                programCounter += 4
            } else if opcode == 3 {
                SetParameterValues(1, 1)
                program[p1] = inputSignal
                programCounter += 2
            } else if opcode == 4 {
                SetParameterValues(1, 0)
                outputArray.append(p1)
                //print(retval)
                programCounter += 2
                if outputArray.count == 2 {
                    return (outputArray, false)
                }
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
                program[p3] = (p1 < p2 ? 1 : 0)
                programCounter += 4
            } else if opcode == 8 {
                SetParameterValues(3, 3)
                program[p3] = (p1 == p2 ? 1 : 0)
                programCounter += 4
            } else if opcode == 9 {
                SetParameterValues(1, 0)
                relativeBase += p1
                programCounter += 2
            } else {
                print("Unknown opcode \(opcode) at program counter \(programCounter)")
                return ([], true)
            }
        }
        
        return (outputArray, true)
    }

    func ProcessProgramPart2(program: inout [Int], inputSignal: Int, programCounter: inout Int, relativeBase: inout Int, expandedMemory: inout Dictionary<Int, Int>) -> ([Int], Bool) {
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
                
                return expandedMemory[pointer]!
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
        
        var outputArray: [Int] = []
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
                SetParameterValues(1, 1)
                SetMemory(p1, inputSignal)
                programCounter += 2
            } else if opcode == 4 {
                SetParameterValues(1, 0)
                outputArray.append(p1)
                //print(retval)
                programCounter += 2
                if outputArray.count == 2 {
                    return (outputArray, false)
                }
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
                return ([], true)
            }
        }
        
        return (outputArray, true)
    }

    func solvePart1(str: String) -> Int {
        var arr = str.parseIntoIntArray(separator: ",")
        var inputSignal = 0
        var programCounter = 0
        var relativeBase = 0
        var robotPosition = Point2D(x: 0, y: 0)
        var robotDirection = CompassDirection.North
        var leaveLoop = false
        var paintDict: Dictionary<Point2D, PaintColor> = [:]
        while !leaveLoop {
            if paintDict[robotPosition] == nil {
                inputSignal = 0
            } else {
                inputSignal = paintDict[robotPosition] == .Black ? 0 : 1
            }
            
            let results = ProcessProgram(program: &arr, inputSignal: inputSignal, programCounter: &programCounter, relativeBase: &relativeBase)
            if results.1 {
                leaveLoop = true
            } else {
                paintDict[robotPosition] = results.0[0] == 0 ? .Black : .White
                if results.0[1] == 0 {
                    robotDirection = robotDirection.TurnLeft()
                } else {
                    robotDirection = robotDirection.TurnRight()
                }
                
                robotPosition = robotPosition.moveForward(direction: robotDirection)
            }
        }
        
        return paintDict.keys.count
    }
    
    func solvePart2(str: String) -> (String, Point2D) {
        var arr = str.parseIntoIntArray(separator: ",")
        var programCounter = 0
        var relativeBase = 0
        var robotPosition = Point2D(x: 0, y: 0)
        var robotDirection = CompassDirection.North
        var leaveLoop = false
        var paintDict: Dictionary<Point2D, PaintColor> = [:]
        var expandedMemory: Dictionary<Int, Int> = [:]
        while !leaveLoop {
            let inputSignal: Int
            if paintDict.keys.count == 0 {
                inputSignal = 1
            } else {
                if paintDict[robotPosition] == nil {
                    inputSignal = 0
                } else {
                    inputSignal = paintDict[robotPosition] == .Black ? 0 : 1
                }
            }
            
            let results = ProcessProgramPart2(program: &arr, inputSignal: inputSignal, programCounter: &programCounter, relativeBase: &relativeBase, expandedMemory: &expandedMemory)
            if results.1 {
                leaveLoop = true
            } else {
                paintDict[robotPosition] = results.0[0] == 0 ? .Black : .White
                if results.0[1] == 0 {
                    robotDirection = robotDirection.TurnLeft()
                } else {
                    robotDirection = robotDirection.TurnRight()
                }
                
                robotPosition = robotPosition.moveForward(direction: robotDirection)
            }
        }
 
        var whitePixels: Set<Point2D> = Set()
        for k in paintDict.keys {
            if paintDict[k] == .White {
                whitePixels.insert(k)
            }
        }

        var adjustedWhitePixels: Set<Point2D> = Set()
        let minX = whitePixels.map { $0.x }.min()!
        let minY = whitePixels.map { $0.y }.min()!
        for w in whitePixels {
            adjustedWhitePixels.insert(Point2D(x: w.x - minX, y: w.y - minY))
        }
        
        let width = adjustedWhitePixels.map { $0.x }.max()! + 1
        let height = adjustedWhitePixels.map { $0.y }.max()! + 1
        var retval = ""
        for y in stride(from: height - 1, through: 0, by: -1) {
            for x in 0..<width {
                if adjustedWhitePixels.contains(Point2D(x: x, y: y)) {
                    retval += "#"
                } else {
                    retval += "."
                }
            }
        }
        
        return (retval, Point2D(x: width, y: height))
    }
    
}

private class Puzzle_2019_11_Input: NSObject {

    static let puzzleInput = """
3,8,1005,8,361,1106,0,11,0,0,0,104,1,104,0,3,8,102,-1,8,10,101,1,10,10,4,10,108,0,8,10,4,10,1001,8,0,28,2,1104,18,10,1006,0,65,3,8,102,-1,8,10,1001,10,1,10,4,10,108,1,8,10,4,10,1001,8,0,57,1,1101,5,10,2,108,15,10,2,102,12,10,3,8,1002,8,-1,10,101,1,10,10,4,10,108,0,8,10,4,10,102,1,8,91,2,1005,4,10,2,1107,10,10,1006,0,16,2,109,19,10,3,8,1002,8,-1,10,1001,10,1,10,4,10,1008,8,1,10,4,10,101,0,8,129,1,104,3,10,1,1008,9,10,1006,0,65,1,104,5,10,3,8,1002,8,-1,10,101,1,10,10,4,10,108,1,8,10,4,10,102,1,8,165,1,1106,11,10,1,1106,18,10,1,8,11,10,1,4,11,10,3,8,1002,8,-1,10,101,1,10,10,4,10,108,1,8,10,4,10,1001,8,0,203,2,1003,11,10,1,1105,13,10,1,101,13,10,3,8,102,-1,8,10,101,1,10,10,4,10,108,0,8,10,4,10,101,0,8,237,2,7,4,10,1006,0,73,1,1003,7,10,1006,0,44,3,8,102,-1,8,10,1001,10,1,10,4,10,108,1,8,10,4,10,101,0,8,273,2,108,14,10,3,8,102,-1,8,10,101,1,10,10,4,10,108,0,8,10,4,10,102,1,8,299,1,1107,6,10,1006,0,85,1,1107,20,10,1,1008,18,10,3,8,1002,8,-1,10,1001,10,1,10,4,10,1008,8,0,10,4,10,1001,8,0,337,2,107,18,10,101,1,9,9,1007,9,951,10,1005,10,15,99,109,683,104,0,104,1,21102,1,825594852248,1,21101,378,0,0,1105,1,482,21101,0,387240006552,1,21101,0,389,0,1106,0,482,3,10,104,0,104,1,3,10,104,0,104,0,3,10,104,0,104,1,3,10,104,0,104,1,3,10,104,0,104,0,3,10,104,0,104,1,21101,0,29032025091,1,21101,436,0,0,1106,0,482,21101,29033143299,0,1,21102,1,447,0,1105,1,482,3,10,104,0,104,0,3,10,104,0,104,0,21101,988669698916,0,1,21101,0,470,0,1106,0,482,21101,0,709052072804,1,21102,1,481,0,1106,0,482,99,109,2,21202,-1,1,1,21101,0,40,2,21101,0,513,3,21101,503,0,0,1106,0,546,109,-2,2105,1,0,0,1,0,0,1,109,2,3,10,204,-1,1001,508,509,524,4,0,1001,508,1,508,108,4,508,10,1006,10,540,1101,0,0,508,109,-2,2105,1,0,0,109,4,1202,-1,1,545,1207,-3,0,10,1006,10,563,21102,0,1,-3,21202,-3,1,1,22101,0,-2,2,21102,1,1,3,21101,582,0,0,1105,1,587,109,-4,2106,0,0,109,5,1207,-3,1,10,1006,10,610,2207,-4,-2,10,1006,10,610,21202,-4,1,-4,1106,0,678,22102,1,-4,1,21201,-3,-1,2,21202,-2,2,3,21102,629,1,0,1106,0,587,22102,1,1,-4,21101,0,1,-1,2207,-4,-2,10,1006,10,648,21102,0,1,-1,22202,-2,-1,-2,2107,0,-3,10,1006,10,670,21202,-1,1,1,21101,670,0,0,105,1,545,21202,-2,-1,-2,22201,-4,-2,-4,109,-5,2106,0,0
"""

}
