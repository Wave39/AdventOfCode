//
//  Puzzle_2019_21.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/25/19.
//  Copyright © 2019 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2019_21: PuzzleBaseClass {
    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1() -> Int {
        solvePart1(str: Puzzle_2019_21_Input.puzzleInput)
    }

    public func solvePart2() -> Int {
        solvePart2(str: Puzzle_2019_21_Input.puzzleInput)
    }

    private func ProcessProgram(program: inout [Int], inputSignal: inout [Int], programCounter: inout Int, relativeBase: inout Int, expandedMemory: inout Dictionary<Int, Int>) -> ([Int], Bool) {
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
            if program[programCounter] / 1_000 % 10 == 1 {
                bParameterMode = .immediate
            } else if program[programCounter] / 1_000 % 10 == 2 {
                bParameterMode = .relative
            } else {
                bParameterMode = .position
            }

            var aParameterMode: ParameterMode
            if program[programCounter] / 10_000 % 10 == 1 {
                aParameterMode = .immediate
            } else if program[programCounter] / 10_000 % 10 == 2 {
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
                    return ([], false)
                }

                SetParameterValues(1, 1)
                SetMemory(p1, inputSignal.first ?? 0)
                inputSignal.remove(at: 0)
                programCounter += 2
            } else if opcode == 4 {
                SetParameterValues(1, 0)
                // print(p1)
                outputArray.append(p1)
                programCounter += 2
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
                return ([], false)
            }
        }

        return (outputArray, true)
    }

    private func getAsciiArray(_ str: String) -> [Int] {
        Array(str + "\n").map { Int(String($0).asciiValue) }
    }

    private func getStringFromAsciiArray(_ arr: [Int]) -> String {
        let arr2 = arr.filter { $0 < 256 }
        return String(arr2.map { Character(UnicodeScalar($0) ?? Unicode.Scalar(0)) })
    }

    private func solvePart1(str: String) -> Int {
        solveWithCommands(str: str, commands: Puzzle_2019_21_Input.part1Commands.parseIntoStringArray())
    }

    private func solvePart2(str: String) -> Int {
        solveWithCommands(str: str, commands: Puzzle_2019_21_Input.part2Commands.parseIntoStringArray())
    }

    private func solveWithCommands(str: String, commands: [String]) -> Int {
        var arr = str.parseIntoIntArray(separator: ",")
        var programCounter = 0
        var relativeBase = 0
        var expandedMemory: [ Int: Int ] = [:]

        var inputSignal: [Int] = []
        for c in commands {
            inputSignal.append(contentsOf: getAsciiArray(c))
        }

        let results = ProcessProgram(program: &arr, inputSignal: &inputSignal, programCounter: &programCounter, relativeBase: &relativeBase, expandedMemory: &expandedMemory)

        return results.0.last ?? 0
    }
}

private class Puzzle_2019_21_Input: NSObject {
    static let part1Commands = """
NOT A J
NOT B T
AND T J
NOT C T
AND T J
AND D T
NOT A J
OR T J
WALK
"""

    // part 2 command list determined courtesy of https://github.com/gernb/AdventOfCode2019/tree/master/Day%2021%20Alternative

    static let part2Commands = """
NOT B J
NOT C T
OR T J
AND H J
NOT A T
OR T J
AND D J
RUN
"""

    static let puzzleInput = """
109,2050,21101,966,0,1,21102,13,1,0,1105,1,1378,21101,20,0,0,1106,0,1337,21102,27,1,0,1105,1,1279,1208,1,65,748,1005,748,73,1208,1,79,748,1005,748,110,1208,1,78,748,1005,748,132,1208,1,87,748,1005,748,169,1208,1,82,748,1005,748,239,21101,0,1041,1,21101,0,73,0,1105,1,1421,21102,78,1,1,21101,0,1041,2,21102,1,88,0,1106,0,1301,21101,68,0,1,21102,1041,1,2,21101,103,0,0,1106,0,1301,1102,1,1,750,1105,1,298,21102,1,82,1,21102,1,1041,2,21102,1,125,0,1105,1,1301,1101,0,2,750,1105,1,298,21101,79,0,1,21102,1,1041,2,21101,147,0,0,1105,1,1301,21102,84,1,1,21102,1041,1,2,21102,1,162,0,1105,1,1301,1101,0,3,750,1106,0,298,21102,1,65,1,21101,0,1041,2,21101,184,0,0,1106,0,1301,21101,76,0,1,21101,0,1041,2,21102,1,199,0,1106,0,1301,21102,75,1,1,21102,1041,1,2,21101,0,214,0,1106,0,1301,21102,1,221,0,1106,0,1337,21102,1,10,1,21101,0,1041,2,21101,236,0,0,1105,1,1301,1106,0,553,21102,1,85,1,21102,1,1041,2,21101,0,254,0,1106,0,1301,21101,0,78,1,21102,1,1041,2,21102,269,1,0,1105,1,1301,21101,276,0,0,1105,1,1337,21101,10,0,1,21101,1041,0,2,21101,291,0,0,1105,1,1301,1102,1,1,755,1106,0,553,21102,32,1,1,21101,0,1041,2,21102,313,1,0,1105,1,1301,21101,320,0,0,1105,1,1337,21101,327,0,0,1105,1,1279,2101,0,1,749,21102,65,1,2,21101,0,73,3,21101,0,346,0,1105,1,1889,1206,1,367,1007,749,69,748,1005,748,360,1101,1,0,756,1001,749,-64,751,1106,0,406,1008,749,74,748,1006,748,381,1102,1,-1,751,1105,1,406,1008,749,84,748,1006,748,395,1101,-2,0,751,1105,1,406,21102,1,1100,1,21102,1,406,0,1106,0,1421,21101,32,0,1,21102,1100,1,2,21101,0,421,0,1106,0,1301,21101,428,0,0,1106,0,1337,21101,0,435,0,1105,1,1279,2102,1,1,749,1008,749,74,748,1006,748,453,1101,0,-1,752,1105,1,478,1008,749,84,748,1006,748,467,1101,0,-2,752,1106,0,478,21102,1168,1,1,21102,478,1,0,1105,1,1421,21102,1,485,0,1106,0,1337,21102,10,1,1,21101,1168,0,2,21102,1,500,0,1105,1,1301,1007,920,15,748,1005,748,518,21101,0,1209,1,21101,0,518,0,1105,1,1421,1002,920,3,529,1001,529,921,529,101,0,750,0,1001,529,1,537,101,0,751,0,1001,537,1,545,102,1,752,0,1001,920,1,920,1106,0,13,1005,755,577,1006,756,570,21102,1,1100,1,21101,570,0,0,1106,0,1421,21102,1,987,1,1106,0,581,21101,1001,0,1,21101,0,588,0,1105,1,1378,1101,0,758,594,102,1,0,753,1006,753,654,21002,753,1,1,21102,1,610,0,1105,1,667,21101,0,0,1,21102,621,1,0,1106,0,1463,1205,1,647,21101,0,1015,1,21102,635,1,0,1105,1,1378,21101,0,1,1,21101,646,0,0,1106,0,1463,99,1001,594,1,594,1105,1,592,1006,755,664,1101,0,0,755,1106,0,647,4,754,99,109,2,1101,726,0,757,21201,-1,0,1,21101,9,0,2,21102,1,697,3,21101,0,692,0,1105,1,1913,109,-2,2106,0,0,109,2,1001,757,0,706,1202,-1,1,0,1001,757,1,757,109,-2,2106,0,0,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0,0,255,63,223,95,127,191,159,0,162,121,141,62,189,227,116,182,153,247,157,124,254,50,138,77,140,39,170,71,214,111,98,173,166,228,187,172,216,230,218,174,252,243,238,253,229,204,155,94,47,200,119,102,167,60,186,117,38,76,201,177,126,199,249,55,106,53,43,163,107,232,125,86,205,190,220,251,215,237,239,46,42,219,34,178,115,139,78,114,156,203,113,51,212,188,118,61,100,87,202,152,242,56,69,136,101,248,143,168,92,35,221,85,154,198,185,57,206,110,120,58,137,59,158,241,234,196,184,123,233,171,70,183,108,93,197,84,181,235,79,109,179,222,236,68,245,244,213,49,142,103,99,217,250,226,54,207,169,231,246,175,122,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,20,73,110,112,117,116,32,105,110,115,116,114,117,99,116,105,111,110,115,58,10,13,10,87,97,108,107,105,110,103,46,46,46,10,10,13,10,82,117,110,110,105,110,103,46,46,46,10,10,25,10,68,105,100,110,39,116,32,109,97,107,101,32,105,116,32,97,99,114,111,115,115,58,10,10,58,73,110,118,97,108,105,100,32,111,112,101,114,97,116,105,111,110,59,32,101,120,112,101,99,116,101,100,32,115,111,109,101,116,104,105,110,103,32,108,105,107,101,32,65,78,68,44,32,79,82,44,32,111,114,32,78,79,84,67,73,110,118,97,108,105,100,32,102,105,114,115,116,32,97,114,103,117,109,101,110,116,59,32,101,120,112,101,99,116,101,100,32,115,111,109,101,116,104,105,110,103,32,108,105,107,101,32,65,44,32,66,44,32,67,44,32,68,44,32,74,44,32,111,114,32,84,40,73,110,118,97,108,105,100,32,115,101,99,111,110,100,32,97,114,103,117,109,101,110,116,59,32,101,120,112,101,99,116,101,100,32,74,32,111,114,32,84,52,79,117,116,32,111,102,32,109,101,109,111,114,121,59,32,97,116,32,109,111,115,116,32,49,53,32,105,110,115,116,114,117,99,116,105,111,110,115,32,99,97,110,32,98,101,32,115,116,111,114,101,100,0,109,1,1005,1262,1270,3,1262,21001,1262,0,0,109,-1,2106,0,0,109,1,21101,0,1288,0,1106,0,1263,21001,1262,0,0,1101,0,0,1262,109,-1,2106,0,0,109,5,21102,1310,1,0,1106,0,1279,21202,1,1,-2,22208,-2,-4,-1,1205,-1,1332,22102,1,-3,1,21101,0,1332,0,1106,0,1421,109,-5,2105,1,0,109,2,21101,1346,0,0,1105,1,1263,21208,1,32,-1,1205,-1,1363,21208,1,9,-1,1205,-1,1363,1106,0,1373,21102,1370,1,0,1105,1,1279,1105,1,1339,109,-2,2105,1,0,109,5,2101,0,-4,1385,21001,0,0,-2,22101,1,-4,-4,21101,0,0,-3,22208,-3,-2,-1,1205,-1,1416,2201,-4,-3,1408,4,0,21201,-3,1,-3,1105,1,1396,109,-5,2106,0,0,109,2,104,10,21201,-1,0,1,21102,1436,1,0,1106,0,1378,104,10,99,109,-2,2105,1,0,109,3,20002,594,753,-1,22202,-1,-2,-1,201,-1,754,754,109,-3,2106,0,0,109,10,21101,5,0,-5,21102,1,1,-4,21101,0,0,-3,1206,-9,1555,21102,3,1,-6,21101,0,5,-7,22208,-7,-5,-8,1206,-8,1507,22208,-6,-4,-8,1206,-8,1507,104,64,1105,1,1529,1205,-6,1527,1201,-7,716,1515,21002,0,-11,-8,21201,-8,46,-8,204,-8,1106,0,1529,104,46,21201,-7,1,-7,21207,-7,22,-8,1205,-8,1488,104,10,21201,-6,-1,-6,21207,-6,0,-8,1206,-8,1484,104,10,21207,-4,1,-8,1206,-8,1569,21101,0,0,-9,1106,0,1689,21208,-5,21,-8,1206,-8,1583,21101,1,0,-9,1105,1,1689,1201,-5,716,1589,20101,0,0,-2,21208,-4,1,-1,22202,-2,-1,-1,1205,-2,1613,21202,-5,1,1,21101,1613,0,0,1106,0,1444,1206,-1,1634,21202,-5,1,1,21102,1627,1,0,1106,0,1694,1206,1,1634,21102,1,2,-3,22107,1,-4,-8,22201,-1,-8,-8,1206,-8,1649,21201,-5,1,-5,1206,-3,1663,21201,-3,-1,-3,21201,-4,1,-4,1106,0,1667,21201,-4,-1,-4,21208,-4,0,-1,1201,-5,716,1676,22002,0,-1,-1,1206,-1,1686,21102,1,1,-4,1106,0,1477,109,-10,2105,1,0,109,11,21102,0,1,-6,21102,0,1,-8,21102,1,0,-7,20208,-6,920,-9,1205,-9,1880,21202,-6,3,-9,1201,-9,921,1724,21002,0,1,-5,1001,1724,1,1733,20101,0,0,-4,21201,-4,0,1,21101,0,1,2,21102,1,9,3,21102,1,1754,0,1106,0,1889,1206,1,1772,2201,-10,-4,1767,1001,1767,716,1767,20102,1,0,-3,1106,0,1790,21208,-4,-1,-9,1206,-9,1786,22102,1,-8,-3,1106,0,1790,22102,1,-7,-3,1001,1733,1,1796,20102,1,0,-2,21208,-2,-1,-9,1206,-9,1812,21201,-8,0,-1,1105,1,1816,21201,-7,0,-1,21208,-5,1,-9,1205,-9,1837,21208,-5,2,-9,1205,-9,1844,21208,-3,0,-1,1105,1,1855,22202,-3,-1,-1,1106,0,1855,22201,-3,-1,-1,22107,0,-1,-1,1106,0,1855,21208,-2,-1,-9,1206,-9,1869,22102,1,-1,-8,1105,1,1873,22102,1,-1,-7,21201,-6,1,-6,1105,1,1708,22101,0,-8,-10,109,-11,2105,1,0,109,7,22207,-6,-5,-3,22207,-4,-6,-2,22201,-3,-2,-1,21208,-1,0,-6,109,-7,2105,1,0,0,109,5,2102,1,-2,1912,21207,-4,0,-1,1206,-1,1930,21102,1,0,-4,22102,1,-4,1,21201,-3,0,2,21102,1,1,3,21102,1,1949,0,1105,1,1954,109,-5,2106,0,0,109,6,21207,-4,1,-1,1206,-1,1977,22207,-5,-3,-1,1206,-1,1977,22101,0,-5,-5,1106,0,2045,21202,-5,1,1,21201,-4,-1,2,21202,-3,2,3,21102,1996,1,0,1105,1,1954,22101,0,1,-5,21101,0,1,-2,22207,-5,-3,-1,1206,-1,2015,21101,0,0,-2,22202,-3,-2,-3,22107,0,-4,-1,1206,-1,2037,21201,-2,0,1,21101,2037,0,0,105,1,1912,21202,-3,-1,-3,22201,-5,-3,-5,109,-6,2105,1,0
"""
}
