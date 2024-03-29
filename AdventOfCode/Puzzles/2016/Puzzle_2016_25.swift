//
//  Puzzle_2016_25.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/14/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2016_25: PuzzleBaseClass {
    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")
    }

    public func solvePart1() -> Int {
        enum Opcode {
            case cpy
            case inc
            case dec
            case jnz
            case out
        }

        struct Param {
            var numericValue: Int?
            var registerIndex: Int?
        }

        struct Instruction {
            var opcode: Opcode
            var param1: Param
            var param2: Param?
        }

        func isStringNumeric(theString: String) -> Bool {
            if !theString.isEmpty {
                var numberCharacters = NSCharacterSet.decimalDigits.inverted
                numberCharacters.remove(charactersIn: "-")
                return !theString.isEmpty && theString.rangeOfCharacter(from: numberCharacters) == nil
            }

            return false
        }

        func getParamValue(p: Param, registers: [Int]) -> Int {
            var v: Int
            if let pNumericValue = p.numericValue {
                v = pNumericValue
            } else if let pRegisterIndex = p.registerIndex {
                v = registers[pRegisterIndex]
            } else {
                v = 0
            }

            return v
        }

        func processInstructionsFaster(instructionArray: [Instruction], registerToRetrieve: Int, registers: [Int]) -> [Int] {
            let instructionArray = instructionArray
            var registers = registers
            var programCounter = 0
            var leaveLoop = false
            var outputArray: [Int] = []

            while programCounter < instructionArray.count && leaveLoop == false {
                let instruction = instructionArray[programCounter]
                if instruction.opcode == .cpy {
                    let p1 = instruction.param1
                    if let p2 = instruction.param2 {
                        if let p2RegisterIndex = p2.registerIndex {
                            let value = getParamValue(p: p1, registers: registers)
                            registers[p2RegisterIndex] = value
                        }
                    }

                    programCounter += 1
                } else if instruction.opcode == .inc {
                    let p1 = instruction.param1
                    if let p1RegisterIndex = p1.registerIndex {
                        let registerValue = registers[p1RegisterIndex]
                        registers[p1RegisterIndex] = registerValue + 1
                    }

                    programCounter += 1
                } else if instruction.opcode == .dec {
                    let p1 = instruction.param1
                    if let p1RegisterIndex = p1.registerIndex {
                        let registerValue = registers[p1RegisterIndex]
                        registers[p1RegisterIndex] = registerValue - 1
                    }

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
                } else if instruction.opcode == .out {
                    let p1 = instruction.param1
                    let p1Value = getParamValue(p: p1, registers: registers)
                    outputArray.append(p1Value)
                    if outputArray.count >= 100 {
                        leaveLoop = true
                    }

                    programCounter += 1
                } else {
                    print("Unknown instruction: \(instruction)")
                    programCounter += 1
                }
            }

            return outputArray
        }

        func buildParam(inputString: String) -> Param {
            var p: Param
            if isStringNumeric(theString: inputString) {
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
                var op: Opcode = .out
                var p2: Param?
                if c[0] == "cpy" {
                    op = .cpy
                } else if c[0] == "inc" {
                    op = .inc
                } else if c[0] == "dec" {
                    op = .dec
                } else if c[0] == "jnz" {
                    op = .jnz
                }

                let p1 = buildParam(inputString: c[1])

                if c.count >= 3 {
                    p2 = buildParam(inputString: c[2])
                }

                let newInstruction = Instruction(opcode: op, param1: p1, param2: p2)
                instructionSet.append(newInstruction)
            }

            return instructionSet
        }

        let part1 = PuzzleInput.final.components(separatedBy: "~").filter { !$0.isEmpty }
        let part1InstructionSet = buildInstructionSet(lineArray: part1)
        var counter = 0
        var part1Solution = -1
        while part1Solution == -1 {
            let registerArray = [ counter, 0, 0, 0 ]
            let output = processInstructionsFaster(instructionArray: part1InstructionSet, registerToRetrieve: 0, registers: registerArray)
            let n0 = output[0]
            let n1 = output[1]
            if n0 != n1 {
                var ok = true
                for idx in stride(from: 0, through: (output.count - 1), by: 2) {
                    if output[idx] != n0 || output[idx + 1] != n1 {
                        ok = false
                    }
                }

                if ok {
                    part1Solution = counter
                }
            }

            counter += 1
        }

        return part1Solution
    }
}

private class PuzzleInput: NSObject {
    static let final = "cpy a d~cpy 9 c~cpy 282 b~inc d~dec b~jnz b -2~dec c~jnz c -5~cpy d a~jnz 0 0~cpy a b~cpy 0 a~cpy 2 c~jnz b 2~jnz 1 6~dec b~dec c~jnz c -4~inc a~jnz 1 -7~cpy 2 b~jnz c 2~jnz 1 4~dec b~dec c~jnz 1 -4~jnz 0 0~out b~jnz a -19~jnz 1 -21"
}
