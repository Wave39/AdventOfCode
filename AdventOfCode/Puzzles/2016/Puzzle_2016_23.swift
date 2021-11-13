//
//  Puzzle_2016_23.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/14/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2016_23: PuzzleBaseClass {
    public func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    public func solveBothParts() -> (Int, Int) {
        enum Opcode {
            case cpy
            case inc
            case dec
            case jnz
            case tgl
            case mul
        }

        struct Param {
            var numericValue: Int?
            var registerIndex: Int?
        }

        struct Instruction {
            var opcode: Opcode
            var param1: Param
            var param2: Param?
            var param3: Param?
        }

        func getParamValue(p: Param, registers: [Int]) -> Int {
            if let v = p.numericValue {
                return v
            }

            if let idx = p.registerIndex {
                return registers[idx]
            }

            return 0
        }

        func processInstructionsFaster(instructionArray: [Instruction], registerToRetrieve: Int, registers: [Int]) -> Int {
            var instructionArray = instructionArray
            var registers = registers
            var programCounter = 0
            while programCounter < instructionArray.count {
                let instruction = instructionArray[programCounter]
                if instruction.opcode == .cpy {
                    let p1 = instruction.param1
                    if let p2 = instruction.param2 {
                        if p2.registerIndex != nil {
                            let value = getParamValue(p: p1, registers: registers)
                            registers[p2.registerIndex ?? 0] = value
                        }
                    }

                    programCounter += 1
                } else if instruction.opcode == .inc {
                    let p1 = instruction.param1
                    let registerValue = registers[p1.registerIndex ?? 0]
                     registers[p1.registerIndex ?? 0] = registerValue + 1
                    programCounter += 1
                } else if instruction.opcode == .dec {
                    let p1 = instruction.param1
                    let registerValue = registers[p1.registerIndex ?? 0]
                    registers[p1.registerIndex ?? 0] = registerValue - 1
                    programCounter += 1
                } else if instruction.opcode == .jnz {
                    let p1 = instruction.param1
                    let p1Value = getParamValue(p: p1, registers: registers)
                    if p1Value != 0 {
                        let p2 = instruction.param2 ?? Param()
                        let p2Value = getParamValue(p: p2, registers: registers)
                        programCounter += p2Value
                    } else {
                        programCounter += 1
                    }
                } else if instruction.opcode == .tgl {
                    let p1 = instruction.param1
                    let p1Value = getParamValue(p: p1, registers: registers)
                    let programCounterToModify = programCounter + p1Value
                    if programCounterToModify >= 0 && programCounterToModify < instructionArray.count {
                        var instructionToModify = instructionArray[programCounterToModify]
                        if instructionToModify.param2 == nil {
                            if instructionToModify.opcode == .inc {
                                instructionToModify.opcode = .dec
                            } else {
                                instructionToModify.opcode = .inc
                            }
                        } else {
                            if instructionToModify.opcode == .jnz {
                                instructionToModify.opcode = .cpy
                            } else {
                                instructionToModify.opcode = .jnz
                            }
                        }

                        instructionArray[programCounterToModify] = instructionToModify
                    }

                    programCounter += 1
                } else if instruction.opcode == .mul {
                    if let p2 = instruction.param2, let p3 = instruction.param3, let p3RegisterIndex = p3.registerIndex {
                        let p1 = instruction.param1
                        let p1Value = getParamValue(p: p1, registers: registers)
                        let p2Value = getParamValue(p: p2, registers: registers)
                        registers[p3RegisterIndex] = p1Value * p2Value
                    }

                    programCounter += 1
                } else {
                    print("Unknown instruction: \(instruction)")
                    programCounter += 1
                }
            }

            return registers[registerToRetrieve]
        }

        func buildParam(inputString: String) -> Param {
            var p: Param
            if inputString.isStringNumeric() {
                p = Param(numericValue: inputString.int, registerIndex: nil)
            } else {
                let idx: Int
                if inputString == "a" {
                    idx = 0
                } else if inputString == "b" {
                    idx = 1
                } else if inputString == "c" {
                    idx = 2
                } else {
                    idx = 3
                }

                p = Param(numericValue: nil, registerIndex: idx)
            }

            return p
        }

        func buildInstructionSet(lineArray: [String]) -> [Instruction] {
            var instructionSet: [Instruction] = []

            for line in lineArray {
                let c = line.components(separatedBy: " ")
                var op: Opcode = .tgl
                var p2: Param?
                var p3: Param?
                if c[0] == "cpy" {
                    op = .cpy
                } else if c[0] == "inc" {
                    op = .inc
                } else if c[0] == "dec" {
                    op = .dec
                } else if c[0] == "jnz" {
                    op = .jnz
                } else if c[0] == "mul" {
                    op = .mul
                }

                let p1 = buildParam(inputString: c[1])

                if c.count >= 3 {
                    p2 = buildParam(inputString: c[2])
                }

                if c.count >= 4 {
                    p3 = buildParam(inputString: c[3])
                }

                let newInstruction = Instruction(opcode: op, param1: p1, param2: p2, param3: p3)
                instructionSet.append(newInstruction)
            }

            return instructionSet
        }

        let part1 = PuzzleInput.finalOptimized.components(separatedBy: "~").filter { !$0.isEmpty }
        let part1InstructionSet = buildInstructionSet(lineArray: part1)
        let part1RegisterArray = [ 7, 0, 0, 0 ]
        let part1Solution = processInstructionsFaster(instructionArray: part1InstructionSet, registerToRetrieve: 0, registers: part1RegisterArray)

        let part2 = PuzzleInput.finalOptimized.components(separatedBy: "~").filter { !$0.isEmpty }
        let part2InstructionSet = buildInstructionSet(lineArray: part2)
        let part2RegisterArray = [ 12, 0, 0, 0 ]
        let part2Solution = processInstructionsFaster(instructionArray: part2InstructionSet, registerToRetrieve: 0, registers: part2RegisterArray)

        return (part1Solution, part2Solution)
    }
}

private class PuzzleInput: NSObject {
    static let final = "cpy a b~dec b~cpy a d~cpy 0 a~cpy b c~inc a~dec c~jnz c -2~dec d~jnz d -5~dec b~cpy b c~cpy c d~dec d~inc c~jnz d -2~tgl c~cpy -16 c~jnz 1 c~cpy 98 c~jnz 91 d~inc a~inc d~jnz d -2~inc c~jnz c -5"

    static let finalOptimized = "cpy a b~dec b~cpy a d~cpy 0 a~mul b d a~cpy 0 c~cpy 0 d~jnz 0 0~jnz 0 0~jnz 0 0~dec b~cpy b c~cpy c d~dec d~inc c~jnz d -2~tgl c~cpy -16 c~jnz 1 c~cpy 98 c~jnz 91 d~inc a~inc d~jnz d -2~inc c~jnz c -5"
}
