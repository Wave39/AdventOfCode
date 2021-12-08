//
//  Puzzle_2016_12.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/12/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

// https://adventofcode.com/2016/day/12

import Foundation

public class Puzzle_2016_12: PuzzleBaseClass {
    private enum InstructionType {
        case unknown
        case cpy
        case inc
        case dec
        case jnz
    }

    private struct Instruction {
        var instructionType: InstructionType = .unknown
        var parameter1Int: Int?
        var parameter1String: String?
        var parameter2Int: Int?
        var parameter2String: String?
    }

    private func processInstructions(lines: [String], registerToRetrieve: String, registers: Dictionary<String, Int>) -> Int {
        var program: [Instruction] = []
        for line in lines {
            var instruction = Instruction()
            let components = line.components(separatedBy: " ")
            if components[0] == "cpy" {
                instruction.instructionType = .cpy
            } else if components[0] == "inc" {
                instruction.instructionType = .inc
            } else if components[0] == "dec" {
                instruction.instructionType = .dec
            } else if components[0] == "jnz" {
                instruction.instructionType = .jnz
            }

            if components[1].isStringNumeric() {
                instruction.parameter1Int = components[1].int
            } else {
                instruction.parameter1String = components[1]
            }

            if components.count > 2 {
                if components[2].isStringNumeric() {
                    instruction.parameter2Int = components[2].int
                } else {
                    instruction.parameter2String = components[2]
                }
            }

            program.append(instruction)
        }

        var registers = registers
        var programCounter = 0
        while programCounter < program.count {
            let instruction = program[programCounter]
            if instruction.instructionType == .cpy {
                let reg = instruction.parameter2String ?? ""
                var registerValue: Int
                if instruction.parameter1Int != nil {
                    registerValue = instruction.parameter1Int ?? 0
                } else {
                    registerValue = registers[instruction.parameter1String ?? ""] ?? 0
                }

                registers[reg] = registerValue
                programCounter += 1
            } else if instruction.instructionType == .inc {
                let reg = instruction.parameter1String ?? ""
                let registerValue = registers[reg] ?? 0
                registers[reg] = registerValue + 1
                programCounter += 1
            } else if instruction.instructionType == .dec {
                let reg = instruction.parameter1String ?? ""
                let registerValue = registers[reg] ?? 0
                registers[reg] = registerValue - 1
                programCounter += 1
            } else if instruction.instructionType == .jnz {
                var registerValue: Int
                if instruction.parameter1Int != nil {
                    registerValue = instruction.parameter1Int ?? 0
                } else {
                    registerValue = registers[instruction.parameter1String ?? ""] ?? 0
                }

                if registerValue != 0 {
                    programCounter += instruction.parameter2Int ?? 0
                } else {
                    programCounter += 1
                }
            } else {
                print("Unknown command: \(instruction)")
            }
        }

        return registers[registerToRetrieve] ?? 0
    }

    public func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    public func solveBothParts() -> (Int, Int) {
        let part1 = PuzzleInput.final.parseIntoStringArray()
        let part1Registers = [ "a": 0, "b": 0, "c": 0, "d": 0 ]
        let part1Solution = processInstructions(lines: part1, registerToRetrieve: "a", registers: part1Registers)

        let part2 = PuzzleInput.final.parseIntoStringArray()
        let part2Registers = [ "a": 0, "b": 0, "c": 1, "d": 0 ]
        let part2Solution = processInstructions(lines: part2, registerToRetrieve: "a", registers: part2Registers)
        return (part1Solution, part2Solution)
    }
}

private class PuzzleInput: NSObject {
    static let final = """
cpy 1 a
cpy 1 b
cpy 26 d
jnz c 2
jnz 1 5
cpy 7 c
inc d
dec c
jnz c -2
cpy a c
inc a
dec b
jnz b -2
cpy c b
dec d
jnz d -6
cpy 19 c
cpy 14 d
inc a
dec d
jnz d -2
dec c
jnz c -5
"""
}
