//
//  Puzzle_2017_23.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/8/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2017_23: PuzzleBaseClass {

    enum InstructionType {
        case Undefined
        case Set
        case Subtract
        case Multiply
        case JumpIfNotZero
    }

    struct Instruction {
        var instructionType: InstructionType = .Undefined
        var parameter1Int: Int?
        var parameter1String: String?
        var parameter2Int: Int?
        var parameter2String: String?
    }

    var instructionArray: [Instruction] = []

    func solve() {
        let part1Solution = solvePart1()
        print("Part 1 solution: \(part1Solution)")

        let part2Solution = solvePart2()
        print("Part 2 solution: \(part2Solution)")
    }

    func parsePuzzleInput(str: String) {
        instructionArray = []
        let matrix = str.parseIntoMatrix()
        for line in matrix {
            var newInstruction = Instruction()
            if line[0] == "set" {
                newInstruction.instructionType = .Set
            } else if line[0] == "sub" {
                newInstruction.instructionType = .Subtract
            } else if line[0] == "mul" {
                newInstruction.instructionType = .Multiply
            } else if line[0] == "jnz" {
                newInstruction.instructionType = .JumpIfNotZero
            }

            if line[1].isStringNumeric() {
                newInstruction.parameter1Int = line[1].int
            } else {
                newInstruction.parameter1String = line[1]
            }

            if line[2].isStringNumeric() {
                newInstruction.parameter2Int = line[2].int
            } else {
                newInstruction.parameter2String = line[2]
            }

            instructionArray.append(newInstruction)
        }
    }

    func solvePart1() -> Int {
        let puzzleInput = PuzzleInput.final
        parsePuzzleInput(str: puzzleInput)

        var registers: Dictionary<String, Int> = [ "a": 0, "b": 0, "c": 0, "d": 0, "e": 0, "f": 0, "g": 0, "h": 0 ]
        var programCounter = 0
        var multiplyCounter = 0
        while programCounter >= 0 && programCounter < instructionArray.count {
            let currentInstruction = instructionArray[programCounter]
            var parameter1 = 0
            let parameter1String = currentInstruction.parameter1String ?? ""
            let parameter2String = currentInstruction.parameter2String ?? ""

            if currentInstruction.parameter1Int != nil {
                parameter1 = currentInstruction.parameter1Int ?? 0
            } else if currentInstruction.parameter1String != nil {
                parameter1 = registers[parameter1String] ?? 0
            }

            var parameter2 = 0
            if currentInstruction.parameter2Int != nil {
                parameter2 = currentInstruction.parameter2Int ?? 0
            } else if currentInstruction.parameter2String != nil {
                parameter2 = registers[parameter2String] ?? 0
            }

            if currentInstruction.instructionType == .Set {
                registers[parameter1String] = parameter2
            } else if currentInstruction.instructionType == .Subtract {
                let previousValue = registers[parameter1String] ?? 0
                registers[parameter1String] = previousValue - parameter2
            } else if currentInstruction.instructionType == .Multiply {
                multiplyCounter += 1
                let previousValue = registers[parameter1String] ?? 0
                registers[parameter1String] = previousValue * parameter2
            } else if currentInstruction.instructionType == .JumpIfNotZero {
                if parameter1 != 0 {
                    programCounter += (parameter2 - 1)
                }
            }

            programCounter += 1
        }

        return multiplyCounter
    }

    // I found this function on Stack Overflow and liked it, as it seems concise and relatively fast.
    // https://stackoverflow.com/a/44413339/36984
    func isPrime(_ number: Int) -> Bool {
        let maxDivider = Int(sqrt(Double(number)))
        return number > 1 && !(2...maxDivider).contains { number % $0 == 0 }
    }

    func solvePart2() -> Int {
        // Trying to run part 2 brute force is designed to not work by the devious Advent Of Code people.
        // I figured that the code input needed to be optimized, but was too lazy to do so myself.
        // As a result, the solution to part 2 is stolen from the following site:
        // https://github.com/dp1/AoC17/blob/master/day23.5.txt

        let b = 109_300
        let c = 126_300
        var h = 0
        for idx in stride(from: b, to: (c + 1), by: 17) {
            if !isPrime(idx) {
                h += 1
            }
        }

        return h
    }

}

private class PuzzleInput: NSObject {

    static let final =

"""
set b 93
set c b
jnz a 2
jnz 1 5
mul b 100
sub b -100000
set c b
sub c -17000
set f 1
set d 2
set e 2
set g d
mul g e
sub g b
jnz g 2
set f 0
sub e -1
set g e
sub g b
jnz g -8
sub d -1
set g d
sub g b
jnz g -13
jnz f 2
sub h -1
set g b
sub g c
jnz g 2
jnz 1 3
sub b -17
jnz 1 -23
"""

}
