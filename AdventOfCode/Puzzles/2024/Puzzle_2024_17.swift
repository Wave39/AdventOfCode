//
//  Puzzle_2024_17.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/1/25.
//  Copyright © 2025 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2024_17: PuzzleBaseClass {
    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1() -> String {
        solvePart1(str: Puzzle_Input.final)
    }

    public func solvePart2() -> Int {
        solvePart2(str: Puzzle_Input.final)
    }

    private func runProgram(a: Int, b: Int, c: Int, program: [Int]) -> [Int] {
        var registerA = a
        var registerB = b
        var registerC = c

        func getOperandValue(_ v: Int) -> Int {
            if v == 4 {
                return registerA
            } else if v == 5 {
                return registerB
            } else if v == 6 {
                return registerC
            } else {
                return v
            }
        }

        var output: [Int] = []
        var programCounter = 0
        while programCounter < program.count {
            let opcode = program[programCounter]
            let literalOperand = program[programCounter + 1]
            let comboOperand = getOperandValue(literalOperand)
            if opcode == 0 {
                registerA = registerA / Int(pow(2.0, Double(comboOperand)))
            } else if opcode == 1 {
                registerB = registerB ^ literalOperand
            } else if opcode == 2 {
                registerB = comboOperand % 8
            } else if opcode == 3 {
                if registerA != 0 {
                    programCounter = literalOperand
                    continue
                }
            } else if opcode == 4 {
                registerB ^= registerC
            } else if opcode == 5 {
                output.append(comboOperand % 8)
            } else if opcode == 6 {
                registerB = registerA / Int(pow(2.0, Double(comboOperand)))
            } else if opcode == 7 {
                registerC = registerA / Int(pow(2.0, Double(comboOperand)))
            } else {
                fatalError( "Unknown opcode: \(opcode)")
            }

            programCounter += 2
        }

        return output
    }

    private func solvePart1(str: String) -> String {
        let lines = str.parseIntoStringArray()
        let registerA = lines[0].parseIntoStringArray(separator: ":")[1].int
        let registerB = lines[1].parseIntoStringArray(separator: ":")[1].int
        let registerC = lines[2].parseIntoStringArray(separator: ":")[1].int
        let program = lines[3].parseIntoStringArray(separator: ":")[1].trim().parseIntoIntArray(separator: ",")

        let output = runProgram(a: registerA, b: registerB, c: registerC, program: program)
        return output.map { String($0) }.joined(separator: ",")
    }

    // inspiration courtesy of https://github.com/rbruinier/AdventOfCode/blob/main/Sources/Solutions/2024/Days/Day17.swift

    func findAForOutput(for a: Int, currentDigitID: Int, program: [Int], expectedOutput: [Int]) -> Int? {
        var results: [Int] = []

        for newA in a ..< a + 8 {
            let output = runProgram(a: newA, b: 0, c: 0, program: program)
            if Array(expectedOutput[(expectedOutput.count - currentDigitID - 1)...]) == output {
                if currentDigitID == 15 {
                    results.append(newA)
                } else if let result = findAForOutput(for: newA << 3, currentDigitID: currentDigitID + 1, program: program, expectedOutput: expectedOutput) {
                    results.append(result)
                }
            }
        }

        return results.min()
    }

    private func solvePart2(str: String) -> Int {
        let lines = str.parseIntoStringArray()
        let program = lines[3].parseIntoStringArray(separator: ":")[1].trim().parseIntoIntArray(separator: ",")

        return findAForOutput(for: 0, currentDigitID: 0, program: program, expectedOutput: program)!
    }
}

private class Puzzle_Input: NSObject {
    static let test = """
Register A: 729
Register B: 0
Register C: 0

Program: 0,1,5,4,3,0
"""

    static let final = """
Register A: 52042868
Register B: 0
Register C: 0

Program: 2,4,1,7,7,5,0,3,4,4,1,7,5,5,3,0
"""
}
