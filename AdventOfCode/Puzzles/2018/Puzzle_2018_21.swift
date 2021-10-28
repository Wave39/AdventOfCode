//
//  Puzzle_2018_21.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/5/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2018_21: NSObject {

    typealias Registers = [Int]

    enum Opcode {
        case unknown
        case addr
        case addi
        case mulr
        case muli
        case banr
        case bani
        case borr
        case bori
        case setr
        case seti
        case gtir
        case gtri
        case gtrr
        case eqir
        case eqri
        case eqrr
    }

    let opcodeDict: Dictionary<String, Opcode> = [ "addr": .addr, "addi": .addi, "mulr": .mulr, "muli": .muli,
                                                   "banr": .banr, "bani": .bani, "borr": .borr, "bori": .bori,
                                                   "setr": .setr, "seti": .seti, "gtir": .gtir, "gtri": .gtri,
                                                   "gtrr": .gtrr, "eqir": .eqir, "eqri": .eqri, "eqrr": .eqrr ]

    class Command {
        var opcode: Opcode = .unknown
        var a: Int = 0
        var b: Int = 0
        var c: Int = 0
    }

    class Program {
        var instructionPointer: Int = 0
        var boundRegister: Int = 0
        var code: [Command] = []
        var registers: Registers = [ 0, 0, 0, 0, 0, 0 ]
    }

    func parseIntoProgram(str: String) -> Program {
        let program = Program()
        let arr = str.parseIntoStringArray()
        for line in arr {
            if line.starts(with: "#") {
                let components = line.parseIntoStringArray(separator: " ")
                program.boundRegister = Int(components[1])!
            } else {
                let components = line.capturedGroups(withRegex: "(.*) (.*) (.*) (.*)", trimResults: true)
                let cmd = Command()
                cmd.opcode = opcodeDict[components[0]]!
                cmd.a = Int(components[1])!
                cmd.b = Int(components[2])!
                cmd.c = Int(components[3])!
                program.code.append(cmd)
            }
        }

        return program
    }

    func runCommandString(command: Command, registers: Registers) -> Registers {
        var newRegisters = registers
        if command.opcode == .addr {
            newRegisters[command.c] = registers[command.a] + registers[command.b]
        } else if command.opcode == .addi {
            newRegisters[command.c] = registers[command.a] + command.b
        } else if command.opcode == .mulr {
            newRegisters[command.c] = registers[command.a] * registers[command.b]
        } else if command.opcode == .muli {
            newRegisters[command.c] = registers[command.a] * command.b
        } else if command.opcode == .banr {
            newRegisters[command.c] = registers[command.a] & registers[command.b]
        } else if command.opcode == .bani {
            newRegisters[command.c] = registers[command.a] & command.b
        } else if command.opcode == .borr {
            newRegisters[command.c] = registers[command.a] | registers[command.b]
        } else if command.opcode == .bori {
            newRegisters[command.c] = registers[command.a] | command.b
        } else if command.opcode == .setr {
            newRegisters[command.c] = registers[command.a]
        } else if command.opcode == .seti {
            newRegisters[command.c] = command.a
        } else if command.opcode == .gtir {
            newRegisters[command.c] = (command.a > registers[command.b] ? 1 : 0)
        } else if command.opcode == .gtri {
            newRegisters[command.c] = (registers[command.a] > command.b ? 1 : 0)
        } else if command.opcode == .gtrr {
            newRegisters[command.c] = (registers[command.a] > registers[command.b] ? 1 : 0)
        } else if command.opcode == .eqir {
            newRegisters[command.c] = (command.a == registers[command.b] ? 1 : 0)
        } else if command.opcode == .eqri {
            newRegisters[command.c] = (registers[command.a] == command.b ? 1 : 0)
        } else if command.opcode == .eqrr {
            newRegisters[command.c] = (registers[command.a] == registers[command.b] ? 1 : 0)
        }

        return newRegisters
    }

    func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")
        print("Please be patient, part 2 takes a very long time to run...")
        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    func solvePart1() -> Int {
        let puzzleInput = Puzzle_2018_21_Input.puzzleInput
        return solvePart1(puzzleInput: puzzleInput)
    }

    func solvePart2() -> Int {
        let puzzleInput = Puzzle_2018_21_Input.puzzleInput
        return solvePart2(puzzleInput: puzzleInput)
    }

    func solvePart1(puzzleInput: String) -> Int {
        let program = parseIntoProgram(str: puzzleInput)
        while true {
            program.registers[program.boundRegister] = program.instructionPointer

            program.registers = runCommandString(command: program.code[program.instructionPointer], registers: program.registers)
            program.instructionPointer = program.registers[program.boundRegister]

            program.instructionPointer += 1
            if program.instructionPointer == 28 {
                return program.registers[2]
            }
        }
    }

    func solvePart2(puzzleInput: String) -> Int {
        let program = parseIntoProgram(str: puzzleInput)
        var registerSet: [Int] = []
        var previous: Int = 0
        repeat {
            program.registers[program.boundRegister] = program.instructionPointer

            program.registers = runCommandString(command: program.code[program.instructionPointer], registers: program.registers)
            program.instructionPointer = program.registers[program.boundRegister]

            program.instructionPointer += 1
            if program.instructionPointer == 28 {
                if registerSet.contains(program.registers[2]) {
                    return previous
                }

                registerSet.append(program.registers[2])
                previous = program.registers[2]
            }
        } while program.instructionPointer >= 0 && program.instructionPointer < program.code.count

        return previous
    }

}

private class Puzzle_2018_21_Input: NSObject {

    static let puzzleInput = """
#ip 1
seti 123 0 2
bani 2 456 2
eqri 2 72 2
addr 2 1 1
seti 0 0 1
seti 0 3 2
bori 2 65536 5
seti 4843319 1 2
bani 5 255 4
addr 2 4 2
bani 2 16777215 2
muli 2 65899 2
bani 2 16777215 2
gtir 256 5 4
addr 4 1 1
addi 1 1 1
seti 27 4 1
seti 0 7 4
addi 4 1 3
muli 3 256 3
gtrr 3 5 3
addr 3 1 1
addi 1 1 1
seti 25 0 1
addi 4 1 4
seti 17 0 1
setr 4 1 5
seti 7 3 1
eqrr 2 0 4
addr 4 1 1
seti 5 3 1
"""

}
