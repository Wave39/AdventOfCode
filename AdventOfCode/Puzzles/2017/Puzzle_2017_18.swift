//
//  Puzzle_2017_18.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/18/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2017_18: PuzzleBaseClass {

    enum InstructionType {
        case Undefined
        case SoundOrSend
        case Set
        case Add
        case Multiply
        case Modulo
        case RecoverOrReceive
        case Jump
        case Receive
    }

    struct Instruction {
        var instructionType: InstructionType = .Undefined
        var parameter1Int: Int?
        var parameter1String: String?
        var parameter2Int: Int?
        var parameter2String: String?
    }

    var instructionArray: [Instruction] = []
    var registerSet: Set<String> = Set()

    func solve() {
        let part1Solution = solvePart1()
        print("Part 1 solution: \(part1Solution)")

        let part2Solution = solvePart2()
        print("Part 2 solution: \(part2Solution)")
    }

    func solvePart1() -> Int {
        parsePuzzleInput(str: PuzzleInput.final)
        return processPart1()
    }

    func solvePart2() -> Int {
        parsePuzzleInput(str: PuzzleInput.final)
        return processPart2()
    }

    func parsePuzzleInput(str: String) {
        instructionArray = []
        registerSet = Set()
        let matrix = str.parseIntoMatrix()
        for line in matrix {
            var newInstruction: Instruction = Instruction()
            if line[0] == "snd" {
                newInstruction.instructionType = .SoundOrSend
            } else if line[0] == "set" {
                newInstruction.instructionType = .Set
            } else if line[0] == "add" {
                newInstruction.instructionType = .Add
            } else if line[0] == "mul" {
                newInstruction.instructionType = .Multiply
            } else if line[0] == "mod" {
                newInstruction.instructionType = .Modulo
            } else if line[0] == "rcv" {
                newInstruction.instructionType = .RecoverOrReceive
            } else if line[0] == "jgz" {
                newInstruction.instructionType = .Jump
            }

            if line[1].isStringNumeric() {
                newInstruction.parameter1Int = Int(line[1])
            } else {
                newInstruction.parameter1String = line[1]
                registerSet.insert(line[1])
            }

            if line.count == 3 {
                if line[2].isStringNumeric() {
                    newInstruction.parameter2Int = Int(line[2])
                } else {
                    newInstruction.parameter2String = line[2]
                }
            }

            instructionArray.append(newInstruction)
        }
    }

    func processPart1() -> Int {
        var lastSoundPlayed = 0
        var programCounter = 0
        var registers: Dictionary<String, Int> = [:]
        for reg in registerSet {
            registers[reg] = 0
        }

        var firstReceive = false
        while !firstReceive && programCounter >= 0 && programCounter < instructionArray.count {
            let currentInstruction = instructionArray[programCounter]
            let parameter1: Int?
            if currentInstruction.parameter1Int != nil {
                parameter1 = currentInstruction.parameter1Int
            } else if currentInstruction.parameter1String != nil {
                parameter1 = registers[currentInstruction.parameter1String!]
            } else {
                parameter1 = nil
            }

            let parameter2: Int?
            if currentInstruction.parameter2Int != nil {
                parameter2 = currentInstruction.parameter2Int
            } else if currentInstruction.parameter2String != nil {
                parameter2 = registers[currentInstruction.parameter2String!]
            } else {
                parameter2 = nil
            }

            if currentInstruction.instructionType == .SoundOrSend {
                lastSoundPlayed = parameter1!
            } else if currentInstruction.instructionType == .Set {
                registers[currentInstruction.parameter1String!] = parameter2
            } else if currentInstruction.instructionType == .Add {
                let previousValue = registers[currentInstruction.parameter1String!]
                registers[currentInstruction.parameter1String!] = previousValue! + parameter2!
            } else if currentInstruction.instructionType == .Multiply {
                let previousValue = registers[currentInstruction.parameter1String!]
                registers[currentInstruction.parameter1String!] = previousValue! * parameter2!
            } else if currentInstruction.instructionType == .Modulo {
                let previousValue = registers[currentInstruction.parameter1String!]
                registers[currentInstruction.parameter1String!] = previousValue! % parameter2!
            } else if currentInstruction.instructionType == .RecoverOrReceive {
                firstReceive = true
            } else if currentInstruction.instructionType == .Jump {
                if parameter1! > 0 {
                    programCounter += (parameter2! - 1)
                }
            }

            programCounter += 1
        }

        return lastSoundPlayed
    }

    func processPart2() -> Int {
        var program1Sends = 0
        var programCounter = [ 0, 0 ]
        var registers: [Dictionary<String, Int>] = []
        registers.append([:])
        registers.append([:])
        for reg in registerSet {
            registers[0][reg] = 0
            registers[1][reg] = 0
        }

        var inputQueue: [[Int]] = [[], []]
        registers[1]["p"] = 1
        var waitingForInput: [Bool] = [ false, false ]

        var terminateProgram = false
        while !terminateProgram {
            for pid in 0...1 {
                if programCounter[pid] >= 0 && programCounter[pid] < instructionArray.count {
                    let currentInstruction = instructionArray[programCounter[pid]]
                    let parameter1: Int?
                    if currentInstruction.parameter1Int != nil {
                        parameter1 = currentInstruction.parameter1Int
                    } else if currentInstruction.parameter1String != nil {
                        parameter1 = registers[pid][currentInstruction.parameter1String!]
                    } else {
                        parameter1 = nil
                    }

                    let parameter2: Int?
                    if currentInstruction.parameter2Int != nil {
                        parameter2 = currentInstruction.parameter2Int
                    } else if currentInstruction.parameter2String != nil {
                        parameter2 = registers[pid][currentInstruction.parameter2String!]
                    } else {
                        parameter2 = nil
                    }

                    if currentInstruction.instructionType == .Set {
                        registers[pid][currentInstruction.parameter1String!] = parameter2
                    } else if currentInstruction.instructionType == .Add {
                        let previousValue = registers[pid][currentInstruction.parameter1String!]
                        registers[pid][currentInstruction.parameter1String!] = previousValue! + parameter2!
                    } else if currentInstruction.instructionType == .Multiply {
                        let previousValue = registers[pid][currentInstruction.parameter1String!]
                        registers[pid][currentInstruction.parameter1String!] = previousValue! * parameter2!
                    } else if currentInstruction.instructionType == .Modulo {
                        let previousValue = registers[pid][currentInstruction.parameter1String!]
                        registers[pid][currentInstruction.parameter1String!] = previousValue! % parameter2!
                    } else if currentInstruction.instructionType == .Jump {
                        if parameter1! > 0 {
                            programCounter[pid] += (parameter2! - 1)
                        }
                    } else if currentInstruction.instructionType == .SoundOrSend {
                        inputQueue[1 - pid].append(parameter1!)
                        if pid == 1 {
                            program1Sends += 1
                        }
                    } else if currentInstruction.instructionType == .RecoverOrReceive {
                        if inputQueue[pid].count == 0 {
                            programCounter[pid] -= 1
                            waitingForInput[pid] = true
                        } else {
                            registers[pid][currentInstruction.parameter1String!] = inputQueue[pid].first!
                            inputQueue[pid].removeFirst()
                            waitingForInput[pid] = false
                        }

                        if waitingForInput[0] && waitingForInput[1] {
                            terminateProgram = true
                        }
                    }

                    programCounter[pid] += 1
                } else {
                    if pid == 1 {
                        return program1Sends
                    }
                }
            }
        }

        return program1Sends
    }

}

private class PuzzleInput: NSObject {

    static let test1 =

"""
set a 1
add a 2
mul a a
mod a 5
snd a
set a 0
rcv a
jgz a -1
set a 1
jgz a -2
"""

    static let final =

"""
set i 31
set a 1
mul p 17
jgz p p
mul a 2
add i -1
jgz i -2
add a -1
set i 127
set p 952
mul p 8505
mod p a
mul p 129749
add p 12345
mod p a
set b p
mod b 10000
snd b
add i -1
jgz i -9
jgz a 3
rcv b
jgz b -1
set f 0
set i 126
rcv a
rcv b
set p a
mul p -1
add p b
jgz p 4
snd a
set a b
jgz 1 3
snd b
set f 1
add i -1
jgz i -11
snd a
jgz f -16
jgz a -19
"""

}
