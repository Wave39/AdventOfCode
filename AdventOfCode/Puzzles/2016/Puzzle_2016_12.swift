//
//  Puzzle_2016_12.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/12/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2016_12: PuzzleBaseClass {
    private func processInstructions(arr: [String], registerToRetrieve: String, registers: Dictionary<String, Int>) -> Int {
        var registers = registers
        var programCounter = 0
        while programCounter < arr.count {
            let line = arr[programCounter]
            let arr = line.components(separatedBy: " ")
            if arr[0] == "cpy" {
                let reg = arr[2]
                var registerValue: Int
                if arr[1].isStringNumeric() {
                    registerValue = arr[1].int
                } else {
                    registerValue = registers[arr[1]] ?? 0
                }

                registers[reg] = registerValue
                programCounter += 1
            } else if arr[0] == "inc" {
                let reg = arr[1]
                let registerValue = registers[reg] ?? 0
                registers[reg] = registerValue + 1
                programCounter += 1
            } else if arr[0] == "dec" {
                let reg = arr[1]
                let registerValue = registers[reg] ?? 0
                registers[reg] = registerValue - 1
                programCounter += 1
            } else if arr[0] == "jnz" {
                let reg = arr[1]
                var registerValue: Int
                if reg.isStringNumeric() {
                    registerValue = reg.int
                } else {
                    registerValue = registers[reg] ?? 0
                }

                if registerValue != 0 {
                    programCounter += arr[2].int
                } else {
                    programCounter += 1
                }
            } else {
                print("Unknown command: \(arr[0])")
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
        let part1Solution = processInstructions(arr: part1, registerToRetrieve: "a", registers: part1Registers)

        let part2 = PuzzleInput.final.parseIntoStringArray()
        let part2Registers = [ "a": 0, "b": 0, "c": 1, "d": 0 ]
        let part2Solution = processInstructions(arr: part2, registerToRetrieve: "a", registers: part2Registers)
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
