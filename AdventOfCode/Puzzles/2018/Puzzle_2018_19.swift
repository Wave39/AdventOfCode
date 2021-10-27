//
//  Puzzle_2018_19.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/5/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2018_19: NSObject {

    typealias Registers = [Int]
    
    class Command {
        var opcode: String = ""
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
                cmd.opcode = components[0]
                cmd.a = Int(components[1])!
                cmd.b = Int(components[2])!
                cmd.c = Int(components[3])!
                program.code.append(cmd)
            }
        }
        
        return program
    }
    
    func solve() {
        let part1 = solvePart1()
        print ("Part 1 solution: \(part1)")
        let part2 = solvePart2()
        print ("Part 2 solution: \(part2)")
    }
    
    func solvePart1() -> Int {
        let puzzleInput = Puzzle_2018_19_Input.puzzleInput
        return solvePart1(puzzleInput: puzzleInput)
    }
    
    func solvePart2() -> Int {
        let puzzleInput = Puzzle_2018_19_Input.puzzleInput
        return solvePart2(puzzleInput: puzzleInput)
    }
    
    func solvePart1(puzzleInput: String) -> Int {
        let program = parseIntoProgram(str: puzzleInput)
        
        repeat {
            program.registers[program.boundRegister] = program.instructionPointer
            
            program.registers = runCommandString(command: program.code[program.instructionPointer], registers: program.registers)
            program.instructionPointer = program.registers[program.boundRegister]
            
            program.instructionPointer += 1
        } while program.instructionPointer >= 0 && program.instructionPointer < program.code.count
        
        return program.registers[0]
    }
    
    func solvePart2(puzzleInput: String) -> Int {
        let program = parseIntoProgram(str: puzzleInput)
        program.registers[0] = 1
        var searchValue = -1
        
        repeat {
            program.registers[program.boundRegister] = program.instructionPointer
            
            program.registers = runCommandString(command: program.code[program.instructionPointer], registers: program.registers)
            program.instructionPointer = program.registers[program.boundRegister]
            
            program.instructionPointer += 1
            
            if program.instructionPointer == 1 {
                // the inner loop beginning at IP 1 is a loop that just adds up factors of register 2
                searchValue = program.registers[2]
            }
        } while searchValue == -1
        
        var total = 0
        for i in 1...Int(Double(searchValue).squareRoot()) {
            if searchValue % i == 0 {
                total += i
                if searchValue / i != i {
                    total += searchValue/i
                }
            }
        }
        
        return total
    }
    
    func runCommandString(command: Command, registers: Registers) -> Registers {
        var newRegisters = registers
        if command.opcode == "addr" {
            newRegisters[command.c] = registers[command.a] + registers[command.b]
        } else if command.opcode == "addi" {
            newRegisters[command.c] = registers[command.a] + command.b
        } else if command.opcode == "mulr" {
            newRegisters[command.c] = registers[command.a] * registers[command.b]
        } else if command.opcode == "muli" {
            newRegisters[command.c] = registers[command.a] * command.b
        } else if command.opcode == "banr" {
            newRegisters[command.c] = registers[command.a] & registers[command.b]
        } else if command.opcode == "bani" {
            newRegisters[command.c] = registers[command.a] & command.b
        } else if command.opcode == "borr" {
            newRegisters[command.c] = registers[command.a] | registers[command.b]
        } else if command.opcode == "bori" {
            newRegisters[command.c] = registers[command.a] | command.b
        } else if command.opcode == "setr" {
            newRegisters[command.c] = registers[command.a]
        } else if command.opcode == "seti" {
            newRegisters[command.c] = command.a
        } else if command.opcode == "gtir" {
            newRegisters[command.c] = (command.a > registers[command.b] ? 1 : 0)
        } else if command.opcode == "gtri" {
            newRegisters[command.c] = (registers[command.a] > command.b ? 1 : 0)
        } else if command.opcode == "gtrr" {
            newRegisters[command.c] = (registers[command.a] > registers[command.b] ? 1 : 0)
        } else if command.opcode == "eqir" {
            newRegisters[command.c] = (command.a == registers[command.b] ? 1 : 0)
        } else if command.opcode == "eqri" {
            newRegisters[command.c] = (registers[command.a] == command.b ? 1 : 0)
        } else if command.opcode == "eqrr" {
            newRegisters[command.c] = (registers[command.a] == registers[command.b] ? 1 : 0)
        }
        
        return newRegisters
    }

}

private class Puzzle_2018_19_Input: NSObject {

    static let puzzleInput_test =
    """
#ip 0
seti 5 0 1
seti 6 0 2
addi 0 1 0
addr 1 2 3
setr 1 0 0
seti 8 0 4
seti 9 0 5
"""
    
    static let puzzleInput =
"""
#ip 5
addi 5 16 5
seti 1 0 4
seti 1 8 1
mulr 4 1 3
eqrr 3 2 3
addr 3 5 5
addi 5 1 5
addr 4 0 0
addi 1 1 1
gtrr 1 2 3
addr 5 3 5
seti 2 4 5
addi 4 1 4
gtrr 4 2 3
addr 3 5 5
seti 1 7 5
mulr 5 5 5
addi 2 2 2
mulr 2 2 2
mulr 5 2 2
muli 2 11 2
addi 3 6 3
mulr 3 5 3
addi 3 9 3
addr 2 3 2
addr 5 0 5
seti 0 5 5
setr 5 9 3
mulr 3 5 3
addr 5 3 3
mulr 5 3 3
muli 3 14 3
mulr 3 5 3
addr 2 3 2
seti 0 1 0
seti 0 0 5
"""
    
}
