//
//  Puzzle_2015_23.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 3/1/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2015_23 : PuzzleBaseClass {

    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    func solveBothParts() -> (Int, Int) {
        struct Processor {
            var programCounter: Int = 0
            var a: Int = 0
            var b: Int = 0
        }

        func runProgram(lineArray: [String], a: Int) -> Processor {
            var processor = Processor()
            processor.a = a
            
            while processor.programCounter >= 0 && processor.programCounter < lineArray.count {
                let components = lineArray[processor.programCounter].split {$0 == " "}.map(String.init)
                let opcode = components[0]
                if opcode == "hlf" || opcode == "tpl" || opcode == "inc" {
                    let aRegisterMode = (components[1] == "a")
                    var register = (aRegisterMode ? processor.a : processor.b)
                    if opcode == "hlf" {
                        register /= 2
                    } else if opcode == "tpl" {
                        register *= 3
                    } else if opcode == "inc" {
                        register += 1
                    }
                    
                    if aRegisterMode {
                        processor.a = register
                    } else {
                        processor.b = register
                    }
                    
                    processor.programCounter += 1
                } else if opcode == "jmp" {
                    processor.programCounter += Int(components[1])!
                } else if opcode == "jie" || opcode == "jio" {
                    let aRegisterMode = (components[1] == "a,")
                    let register = (aRegisterMode ? processor.a : processor.b)
                    var offset = 1
                    if (opcode == "jie" && register % 2 == 0) || (opcode == "jio" && register == 1) {
                        offset = Int(components[2])!
                    }
                    
                    processor.programCounter += offset
                }
            }
            
            return processor
        }

        let puzzleInputLineArray = PuzzleInput.final.parseIntoStringArray()
        let part1Processor = runProgram(lineArray: puzzleInputLineArray, a: 0)
        let part2Processor = runProgram(lineArray: puzzleInputLineArray, a: 1)
        return (part1Processor.b, part2Processor.b)
    }
    
}

fileprivate class PuzzleInput: NSObject {

    static let final = """
jio a, +18
inc a
tpl a
inc a
tpl a
tpl a
tpl a
inc a
tpl a
inc a
tpl a
inc a
inc a
tpl a
tpl a
tpl a
inc a
jmp +22
tpl a
inc a
tpl a
inc a
inc a
tpl a
inc a
tpl a
inc a
inc a
tpl a
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
inc a
inc a
tpl a
jio a, +8
inc b
jie a, +4
tpl a
inc a
jmp +2
hlf a
jmp -7
"""

}

