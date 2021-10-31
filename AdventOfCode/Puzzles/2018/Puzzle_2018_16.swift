//
//  Puzzle_2018_16.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/4/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2018_16: NSObject {

    typealias Registers = [Int]
    typealias Command = [Int]

    class Sample: CustomStringConvertible {
        var beforeRegisters: Registers = Registers()
        var command: Command = Command()
        var afterRegisters: Registers = Registers()
        var description: String {
            return "Before: \(beforeRegisters); Command: \(command); After: \(afterRegisters)"
        }
    }

    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    func solveBothParts() -> (Int, Int) {
        let puzzleInput = Puzzle_2018_16_Input.puzzleInput

        var samples: [Sample] = []
        var testProgram: [Command] = []
        let arr = puzzleInput.parseIntoStringArray()
        var buildingSample = false
        var singleSample: Sample = Sample()
        for line in arr {
            if line.starts(with: "Before") {
                buildingSample = true
                singleSample = Sample()
                let components = line.capturedGroups(withRegex: "Before: \\[(.*), (.*), (.*), (.*)\\]", trimResults: true)
                singleSample.beforeRegisters = [ Int(components[0])!, Int(components[1])!, Int(components[2])!, Int(components[3])! ]
            } else if line.starts(with: "After") {
                let components = line.capturedGroups(withRegex: "After:  \\[(.*), (.*), (.*), (.*)\\]", trimResults: true)
                singleSample.afterRegisters = [ Int(components[0])!, Int(components[1])!, Int(components[2])!, Int(components[3])! ]
                samples.append(singleSample)
                buildingSample = false
            } else if !line.isEmpty {
                let components = line.capturedGroups(withRegex: "(.*) (.*) (.*) (.*)", trimResults: true)
                if buildingSample {
                    singleSample.command = [ Int(components[0])!, Int(components[1])!, Int(components[2])!, Int(components[3])! ]
                } else {
                    testProgram.append([ Int(components[0])!, Int(components[1])!, Int(components[2])!, Int(components[3])! ])
                }
            }
        }

        let part1 = solvePart1(samples: samples)
        let part2 = solvePart2(originalSamples: samples, testProgram: testProgram)
        return (part1, part2)
    }

    func solvePart1(samples: [Sample]) -> Int {
        let opcodes = [ "addr", "addi", "mulr", "muli", "banr", "bani", "borr", "bori", "setr", "seti", "gtir", "gtri", "gtrr", "eqir", "eqri", "eqrr" ]

        var retval = 0
        for sample in samples {
            var candidateArray: [String] = []
            for opcode in opcodes {
                let results = runCommandString(command: sample.command, registers: sample.beforeRegisters, commandString: opcode)
                if results == sample.afterRegisters {
                    candidateArray.append(opcode)
                }
            }

            if candidateArray.count >= 3 {
                retval += 1
            }
        }

        return retval
    }

    func solvePart2(originalSamples: [Sample], testProgram: [Command]) -> Int {
        var newSamples = originalSamples
        var opcodes = [ "addr", "addi", "mulr", "muli", "banr", "bani", "borr", "bori", "setr", "seti", "gtir", "gtri", "gtrr", "eqir", "eqri", "eqrr" ]
        var mappingDict: Dictionary<Int, String> = [:]

        // figure out which numbers match which opcodes by iterating through the samples
        // when only one candidate is found, that number must match that opcode
        while mappingDict.count < 16 {
            var itemsToRemove: Set<Int> = Set()
            for sample in newSamples {
                var candidateArray: [String] = []
                for opcode in opcodes {
                    let results = runCommandString(command: sample.command, registers: sample.beforeRegisters, commandString: opcode)
                    if results == sample.afterRegisters {
                        candidateArray.append(opcode)
                    }
                }

                if candidateArray.count == 1 {
                    mappingDict[sample.command[0]] = candidateArray[0]
                    itemsToRemove.insert(sample.command[0])
                    opcodes.removeAll { $0 == candidateArray[0] }
                }
            }

            for x in itemsToRemove {
                newSamples = newSamples.filter { $0.command[0] != x }
            }
        }

        var registers = [ 0, 0, 0, 0 ]
        for c in testProgram {
            registers = runCommandString(command: c, registers: registers, commandString: mappingDict[c[0]]!)
        }

        return registers[0]
    }

    func runCommandString(command: Command, registers: Registers, commandString: String) -> Registers {
        var newRegisters = registers
        let a = command[1]
        let b = command[2]
        let c = command[3]
        if commandString == "addr" {
            newRegisters[c] = registers[a] + registers[b]
        } else if commandString == "addi" {
            newRegisters[c] = registers[a] + b
        } else if commandString == "mulr" {
            newRegisters[c] = registers[a] * registers[b]
        } else if commandString == "muli" {
            newRegisters[c] = registers[a] * b
        } else if commandString == "banr" {
            newRegisters[c] = registers[a] & registers[b]
        } else if commandString == "bani" {
            newRegisters[c] = registers[a] & b
        } else if commandString == "borr" {
            newRegisters[c] = registers[a] | registers[b]
        } else if commandString == "bori" {
            newRegisters[c] = registers[a] | b
        } else if commandString == "setr" {
            newRegisters[c] = registers[a]
        } else if commandString == "seti" {
            newRegisters[c] = a
        } else if commandString == "gtir" {
            newRegisters[c] = (a > registers[b] ? 1 : 0)
        } else if commandString == "gtri" {
            newRegisters[c] = (registers[a] > b ? 1 : 0)
        } else if commandString == "gtrr" {
            newRegisters[c] = (registers[a] > registers[b] ? 1 : 0)
        } else if commandString == "eqir" {
            newRegisters[c] = (a == registers[b] ? 1 : 0)
        } else if commandString == "eqri" {
            newRegisters[c] = (registers[a] == b ? 1 : 0)
        } else if commandString == "eqrr" {
            newRegisters[c] = (registers[a] == registers[b] ? 1 : 0)
        }

        return newRegisters
    }

}

private class Puzzle_2018_16_Input: NSObject {

    static let puzzleInput_test =
    """
Before: [3, 2, 1, 1]
9 2 1 2
After:  [3, 2, 2, 1]
"""

    static let puzzleInput =
    """
Before: [2, 0, 2, 2]
3 0 2 1
After:  [2, 1, 2, 2]

Before: [3, 0, 3, 3]
3 2 3 2
After:  [3, 0, 1, 3]

Before: [2, 0, 1, 0]
0 2 1 3
After:  [2, 0, 1, 1]

Before: [3, 0, 2, 1]
0 3 1 0
After:  [1, 0, 2, 1]

Before: [1, 1, 2, 3]
4 1 2 0
After:  [0, 1, 2, 3]

Before: [2, 1, 2, 3]
9 1 0 0
After:  [0, 1, 2, 3]

Before: [2, 1, 2, 3]
12 1 3 3
After:  [2, 1, 2, 0]

Before: [2, 2, 1, 3]
12 2 3 1
After:  [2, 0, 1, 3]

Before: [1, 3, 3, 1]
5 3 1 3
After:  [1, 3, 3, 1]

Before: [1, 1, 3, 2]
15 3 3 3
After:  [1, 1, 3, 0]

Before: [2, 1, 1, 3]
9 1 0 1
After:  [2, 0, 1, 3]

Before: [0, 3, 1, 1]
5 3 1 1
After:  [0, 1, 1, 1]

Before: [2, 3, 2, 1]
3 0 2 2
After:  [2, 3, 1, 1]

Before: [0, 2, 2, 1]
7 2 1 3
After:  [0, 2, 2, 1]

Before: [2, 2, 1, 3]
13 3 1 1
After:  [2, 0, 1, 3]

Before: [0, 0, 1, 2]
0 2 1 2
After:  [0, 0, 1, 2]

Before: [0, 1, 2, 1]
4 1 2 1
After:  [0, 0, 2, 1]

Before: [3, 1, 1, 2]
10 2 1 1
After:  [3, 2, 1, 2]

Before: [2, 2, 0, 2]
11 0 3 3
After:  [2, 2, 0, 1]

Before: [1, 1, 2, 0]
1 0 2 0
After:  [0, 1, 2, 0]

Before: [2, 1, 2, 2]
9 1 0 0
After:  [0, 1, 2, 2]

Before: [2, 1, 2, 1]
9 1 0 2
After:  [2, 1, 0, 1]

Before: [2, 1, 2, 2]
9 1 0 1
After:  [2, 0, 2, 2]

Before: [0, 1, 3, 3]
12 1 3 2
After:  [0, 1, 0, 3]

Before: [2, 1, 2, 0]
4 1 2 0
After:  [0, 1, 2, 0]

Before: [0, 1, 3, 3]
3 2 3 3
After:  [0, 1, 3, 1]

Before: [3, 0, 3, 3]
3 2 3 0
After:  [1, 0, 3, 3]

Before: [0, 3, 3, 3]
13 3 3 1
After:  [0, 1, 3, 3]

Before: [0, 3, 2, 1]
14 3 2 2
After:  [0, 3, 1, 1]

Before: [0, 2, 0, 3]
13 0 0 3
After:  [0, 2, 0, 1]

Before: [1, 3, 2, 1]
5 3 1 1
After:  [1, 1, 2, 1]

Before: [2, 2, 1, 1]
8 2 3 2
After:  [2, 2, 2, 1]

Before: [1, 0, 2, 3]
1 0 2 1
After:  [1, 0, 2, 3]

Before: [0, 2, 3, 3]
3 2 3 3
After:  [0, 2, 3, 1]

Before: [1, 2, 1, 2]
8 2 0 3
After:  [1, 2, 1, 2]

Before: [3, 2, 2, 3]
3 0 3 3
After:  [3, 2, 2, 1]

Before: [2, 1, 3, 1]
9 1 0 1
After:  [2, 0, 3, 1]

Before: [2, 0, 2, 1]
14 3 2 1
After:  [2, 1, 2, 1]

Before: [0, 1, 0, 0]
2 0 0 0
After:  [0, 1, 0, 0]

Before: [1, 0, 1, 1]
15 2 3 0
After:  [0, 0, 1, 1]

Before: [2, 0, 1, 1]
8 2 3 1
After:  [2, 2, 1, 1]

Before: [1, 3, 2, 0]
1 0 2 1
After:  [1, 0, 2, 0]

Before: [0, 0, 1, 0]
0 2 1 3
After:  [0, 0, 1, 1]

Before: [1, 3, 2, 0]
1 0 2 3
After:  [1, 3, 2, 0]

Before: [2, 1, 1, 0]
9 1 0 3
After:  [2, 1, 1, 0]

Before: [1, 1, 2, 1]
1 0 2 0
After:  [0, 1, 2, 1]

Before: [3, 1, 1, 1]
10 2 1 2
After:  [3, 1, 2, 1]

Before: [1, 1, 2, 1]
1 0 2 2
After:  [1, 1, 0, 1]

Before: [0, 3, 2, 1]
14 3 2 3
After:  [0, 3, 2, 1]

Before: [1, 3, 2, 1]
14 3 2 0
After:  [1, 3, 2, 1]

Before: [2, 0, 2, 2]
13 2 2 3
After:  [2, 0, 2, 1]

Before: [2, 3, 3, 2]
11 0 3 0
After:  [1, 3, 3, 2]

Before: [2, 2, 2, 3]
3 0 2 0
After:  [1, 2, 2, 3]

Before: [2, 2, 2, 2]
11 0 3 1
After:  [2, 1, 2, 2]

Before: [1, 1, 2, 0]
4 1 2 3
After:  [1, 1, 2, 0]

Before: [1, 2, 2, 0]
1 0 2 0
After:  [0, 2, 2, 0]

Before: [0, 1, 0, 0]
0 1 0 0
After:  [1, 1, 0, 0]

Before: [0, 2, 0, 2]
15 3 3 2
After:  [0, 2, 0, 2]

Before: [2, 1, 2, 3]
7 2 0 0
After:  [1, 1, 2, 3]

Before: [0, 0, 0, 3]
2 0 0 0
After:  [0, 0, 0, 3]

Before: [1, 3, 1, 1]
8 2 0 1
After:  [1, 2, 1, 1]

Before: [2, 1, 1, 1]
8 2 3 2
After:  [2, 1, 2, 1]

Before: [3, 1, 3, 3]
3 0 3 0
After:  [1, 1, 3, 3]

Before: [2, 0, 1, 2]
11 0 3 3
After:  [2, 0, 1, 1]

Before: [1, 0, 0, 0]
0 0 1 0
After:  [1, 0, 0, 0]

Before: [0, 3, 2, 1]
5 3 1 1
After:  [0, 1, 2, 1]

Before: [0, 1, 2, 1]
14 3 2 0
After:  [1, 1, 2, 1]

Before: [1, 2, 1, 1]
8 2 0 2
After:  [1, 2, 2, 1]

Before: [0, 3, 1, 3]
12 2 3 1
After:  [0, 0, 1, 3]

Before: [2, 1, 1, 0]
10 2 1 2
After:  [2, 1, 2, 0]

Before: [1, 3, 1, 0]
8 2 0 3
After:  [1, 3, 1, 2]

Before: [1, 3, 1, 2]
15 3 3 0
After:  [0, 3, 1, 2]

Before: [0, 0, 1, 3]
2 0 0 1
After:  [0, 0, 1, 3]

Before: [2, 1, 0, 2]
15 3 3 3
After:  [2, 1, 0, 0]

Before: [2, 1, 0, 0]
9 1 0 1
After:  [2, 0, 0, 0]

Before: [1, 0, 3, 0]
0 0 1 0
After:  [1, 0, 3, 0]

Before: [3, 0, 3, 1]
15 3 3 0
After:  [0, 0, 3, 1]

Before: [3, 1, 0, 3]
7 3 0 0
After:  [1, 1, 0, 3]

Before: [2, 3, 2, 1]
7 2 0 0
After:  [1, 3, 2, 1]

Before: [2, 2, 2, 2]
11 0 3 3
After:  [2, 2, 2, 1]

Before: [0, 0, 2, 2]
2 0 0 0
After:  [0, 0, 2, 2]

Before: [2, 3, 2, 2]
11 0 3 1
After:  [2, 1, 2, 2]

Before: [0, 1, 3, 2]
6 1 2 0
After:  [0, 1, 3, 2]

Before: [2, 1, 1, 1]
9 1 0 2
After:  [2, 1, 0, 1]

Before: [2, 1, 1, 2]
10 2 1 1
After:  [2, 2, 1, 2]

Before: [1, 1, 1, 1]
10 2 1 0
After:  [2, 1, 1, 1]

Before: [1, 0, 2, 0]
1 0 2 0
After:  [0, 0, 2, 0]

Before: [2, 1, 1, 2]
11 0 3 0
After:  [1, 1, 1, 2]

Before: [2, 0, 1, 3]
12 2 3 0
After:  [0, 0, 1, 3]

Before: [1, 1, 2, 3]
4 1 2 2
After:  [1, 1, 0, 3]

Before: [3, 2, 0, 3]
12 1 3 0
After:  [0, 2, 0, 3]

Before: [2, 0, 1, 3]
13 3 3 2
After:  [2, 0, 1, 3]

Before: [1, 3, 2, 3]
12 2 3 3
After:  [1, 3, 2, 0]

Before: [2, 1, 3, 3]
9 1 0 1
After:  [2, 0, 3, 3]

Before: [0, 3, 1, 1]
8 2 3 2
After:  [0, 3, 2, 1]

Before: [2, 3, 1, 1]
5 3 1 3
After:  [2, 3, 1, 1]

Before: [2, 1, 3, 3]
6 1 2 2
After:  [2, 1, 0, 3]

Before: [2, 1, 3, 1]
9 1 0 3
After:  [2, 1, 3, 0]

Before: [2, 0, 1, 2]
0 2 1 3
After:  [2, 0, 1, 1]

Before: [2, 3, 0, 1]
15 3 3 0
After:  [0, 3, 0, 1]

Before: [2, 1, 2, 3]
9 1 0 1
After:  [2, 0, 2, 3]

Before: [2, 1, 0, 0]
9 1 0 3
After:  [2, 1, 0, 0]

Before: [1, 3, 2, 1]
1 0 2 0
After:  [0, 3, 2, 1]

Before: [1, 1, 1, 2]
8 2 0 0
After:  [2, 1, 1, 2]

Before: [2, 1, 1, 2]
11 0 3 1
After:  [2, 1, 1, 2]

Before: [0, 1, 2, 0]
4 1 2 0
After:  [0, 1, 2, 0]

Before: [1, 1, 2, 1]
14 3 2 1
After:  [1, 1, 2, 1]

Before: [0, 1, 1, 2]
10 2 1 1
After:  [0, 2, 1, 2]

Before: [1, 1, 0, 3]
12 1 3 1
After:  [1, 0, 0, 3]

Before: [3, 3, 2, 1]
5 3 1 1
After:  [3, 1, 2, 1]

Before: [2, 2, 3, 3]
13 3 3 3
After:  [2, 2, 3, 1]

Before: [1, 3, 1, 1]
8 2 3 2
After:  [1, 3, 2, 1]

Before: [2, 2, 2, 1]
14 3 2 0
After:  [1, 2, 2, 1]

Before: [0, 1, 3, 2]
6 1 2 1
After:  [0, 0, 3, 2]

Before: [3, 2, 2, 1]
14 3 2 0
After:  [1, 2, 2, 1]

Before: [1, 2, 3, 3]
3 2 3 3
After:  [1, 2, 3, 1]

Before: [0, 2, 2, 1]
2 0 0 1
After:  [0, 0, 2, 1]

Before: [0, 1, 2, 1]
14 3 2 1
After:  [0, 1, 2, 1]

Before: [2, 3, 0, 2]
11 0 3 1
After:  [2, 1, 0, 2]

Before: [3, 1, 3, 1]
6 1 2 1
After:  [3, 0, 3, 1]

Before: [3, 1, 1, 3]
10 2 1 3
After:  [3, 1, 1, 2]

Before: [3, 0, 2, 1]
14 3 2 0
After:  [1, 0, 2, 1]

Before: [0, 0, 1, 1]
0 3 1 1
After:  [0, 1, 1, 1]

Before: [1, 2, 1, 3]
8 2 0 0
After:  [2, 2, 1, 3]

Before: [0, 1, 2, 0]
0 1 0 2
After:  [0, 1, 1, 0]

Before: [3, 1, 2, 3]
4 1 2 1
After:  [3, 0, 2, 3]

Before: [0, 3, 2, 1]
14 3 2 0
After:  [1, 3, 2, 1]

Before: [3, 2, 1, 3]
13 3 3 3
After:  [3, 2, 1, 1]

Before: [1, 1, 3, 1]
6 1 2 1
After:  [1, 0, 3, 1]

Before: [2, 0, 1, 2]
11 0 3 0
After:  [1, 0, 1, 2]

Before: [1, 2, 2, 1]
14 3 2 2
After:  [1, 2, 1, 1]

Before: [1, 3, 2, 1]
1 0 2 2
After:  [1, 3, 0, 1]

Before: [2, 0, 2, 2]
7 2 0 1
After:  [2, 1, 2, 2]

Before: [1, 1, 3, 0]
6 1 2 2
After:  [1, 1, 0, 0]

Before: [1, 2, 1, 0]
8 2 0 3
After:  [1, 2, 1, 2]

Before: [2, 1, 1, 3]
9 1 0 3
After:  [2, 1, 1, 0]

Before: [1, 1, 1, 0]
10 2 1 1
After:  [1, 2, 1, 0]

Before: [2, 1, 0, 2]
9 1 0 1
After:  [2, 0, 0, 2]

Before: [3, 3, 0, 1]
5 3 1 0
After:  [1, 3, 0, 1]

Before: [0, 0, 1, 2]
0 2 1 3
After:  [0, 0, 1, 1]

Before: [1, 1, 1, 1]
8 2 3 1
After:  [1, 2, 1, 1]

Before: [0, 0, 3, 3]
2 0 0 3
After:  [0, 0, 3, 0]

Before: [2, 2, 2, 2]
3 0 2 2
After:  [2, 2, 1, 2]

Before: [0, 1, 3, 1]
6 1 2 3
After:  [0, 1, 3, 0]

Before: [3, 3, 2, 1]
5 3 1 3
After:  [3, 3, 2, 1]

Before: [0, 3, 2, 3]
13 0 0 0
After:  [1, 3, 2, 3]

Before: [0, 3, 1, 1]
5 3 1 3
After:  [0, 3, 1, 1]

Before: [2, 1, 2, 1]
4 1 2 2
After:  [2, 1, 0, 1]

Before: [0, 1, 3, 3]
6 1 2 1
After:  [0, 0, 3, 3]

Before: [0, 1, 3, 3]
7 3 2 3
After:  [0, 1, 3, 1]

Before: [0, 3, 0, 1]
5 3 1 1
After:  [0, 1, 0, 1]

Before: [1, 3, 2, 3]
1 0 2 0
After:  [0, 3, 2, 3]

Before: [1, 2, 2, 3]
12 1 3 1
After:  [1, 0, 2, 3]

Before: [3, 1, 2, 2]
4 1 2 3
After:  [3, 1, 2, 0]

Before: [0, 3, 2, 3]
13 0 0 3
After:  [0, 3, 2, 1]

Before: [0, 3, 2, 2]
13 2 2 0
After:  [1, 3, 2, 2]

Before: [1, 1, 2, 3]
1 0 2 1
After:  [1, 0, 2, 3]

Before: [0, 2, 1, 2]
15 3 3 0
After:  [0, 2, 1, 2]

Before: [0, 1, 3, 3]
13 0 0 1
After:  [0, 1, 3, 3]

Before: [0, 2, 2, 1]
2 0 0 2
After:  [0, 2, 0, 1]

Before: [0, 1, 3, 2]
2 0 0 1
After:  [0, 0, 3, 2]

Before: [1, 3, 2, 1]
1 0 2 3
After:  [1, 3, 2, 0]

Before: [2, 2, 2, 3]
12 2 3 1
After:  [2, 0, 2, 3]

Before: [2, 1, 3, 3]
7 3 2 1
After:  [2, 1, 3, 3]

Before: [1, 1, 3, 2]
6 1 2 1
After:  [1, 0, 3, 2]

Before: [3, 1, 3, 0]
6 1 2 1
After:  [3, 0, 3, 0]

Before: [0, 3, 0, 3]
2 0 0 1
After:  [0, 0, 0, 3]

Before: [1, 0, 1, 3]
0 0 1 2
After:  [1, 0, 1, 3]

Before: [0, 1, 3, 0]
6 1 2 3
After:  [0, 1, 3, 0]

Before: [0, 3, 3, 1]
5 3 1 3
After:  [0, 3, 3, 1]

Before: [0, 0, 2, 1]
0 3 1 0
After:  [1, 0, 2, 1]

Before: [1, 1, 1, 0]
10 2 1 0
After:  [2, 1, 1, 0]

Before: [1, 3, 2, 0]
1 0 2 0
After:  [0, 3, 2, 0]

Before: [2, 1, 0, 3]
12 1 3 0
After:  [0, 1, 0, 3]

Before: [2, 0, 0, 2]
11 0 3 2
After:  [2, 0, 1, 2]

Before: [0, 1, 1, 1]
15 3 3 1
After:  [0, 0, 1, 1]

Before: [1, 1, 2, 0]
4 1 2 2
After:  [1, 1, 0, 0]

Before: [0, 3, 0, 1]
2 0 0 1
After:  [0, 0, 0, 1]

Before: [3, 1, 3, 1]
6 1 2 0
After:  [0, 1, 3, 1]

Before: [0, 2, 2, 2]
2 0 0 1
After:  [0, 0, 2, 2]

Before: [3, 0, 1, 3]
0 2 1 3
After:  [3, 0, 1, 1]

Before: [3, 2, 2, 0]
7 2 1 2
After:  [3, 2, 1, 0]

Before: [2, 1, 1, 3]
13 3 2 2
After:  [2, 1, 0, 3]

Before: [3, 1, 1, 1]
10 2 1 1
After:  [3, 2, 1, 1]

Before: [2, 2, 2, 0]
3 0 2 2
After:  [2, 2, 1, 0]

Before: [1, 3, 1, 0]
8 2 0 1
After:  [1, 2, 1, 0]

Before: [0, 1, 2, 2]
4 1 2 0
After:  [0, 1, 2, 2]

Before: [1, 2, 1, 2]
8 2 0 1
After:  [1, 2, 1, 2]

Before: [2, 0, 3, 2]
11 0 3 1
After:  [2, 1, 3, 2]

Before: [1, 2, 3, 1]
15 3 3 1
After:  [1, 0, 3, 1]

Before: [2, 1, 2, 0]
4 1 2 1
After:  [2, 0, 2, 0]

Before: [3, 1, 3, 3]
7 3 2 0
After:  [1, 1, 3, 3]

Before: [3, 0, 2, 3]
12 2 3 0
After:  [0, 0, 2, 3]

Before: [3, 1, 2, 0]
4 1 2 2
After:  [3, 1, 0, 0]

Before: [3, 3, 2, 1]
14 3 2 3
After:  [3, 3, 2, 1]

Before: [1, 1, 2, 1]
1 0 2 1
After:  [1, 0, 2, 1]

Before: [3, 3, 1, 1]
8 2 3 1
After:  [3, 2, 1, 1]

Before: [2, 3, 2, 2]
11 0 3 2
After:  [2, 3, 1, 2]

Before: [0, 1, 3, 0]
6 1 2 1
After:  [0, 0, 3, 0]

Before: [1, 2, 2, 2]
1 0 2 1
After:  [1, 0, 2, 2]

Before: [0, 2, 2, 1]
14 3 2 3
After:  [0, 2, 2, 1]

Before: [1, 3, 3, 1]
7 2 3 2
After:  [1, 3, 0, 1]

Before: [3, 1, 3, 3]
3 2 3 3
After:  [3, 1, 3, 1]

Before: [0, 0, 2, 2]
2 0 0 1
After:  [0, 0, 2, 2]

Before: [3, 2, 1, 3]
3 0 3 1
After:  [3, 1, 1, 3]

Before: [1, 3, 1, 1]
8 2 3 1
After:  [1, 2, 1, 1]

Before: [1, 0, 1, 1]
8 2 3 0
After:  [2, 0, 1, 1]

Before: [0, 3, 0, 0]
2 0 0 2
After:  [0, 3, 0, 0]

Before: [2, 1, 2, 2]
9 1 0 3
After:  [2, 1, 2, 0]

Before: [2, 1, 3, 0]
6 1 2 3
After:  [2, 1, 3, 0]

Before: [3, 1, 3, 1]
15 3 3 1
After:  [3, 0, 3, 1]

Before: [2, 1, 1, 1]
8 2 3 0
After:  [2, 1, 1, 1]

Before: [1, 3, 1, 0]
8 2 0 0
After:  [2, 3, 1, 0]

Before: [3, 3, 2, 1]
14 3 2 0
After:  [1, 3, 2, 1]

Before: [2, 1, 1, 3]
9 1 0 2
After:  [2, 1, 0, 3]

Before: [3, 1, 0, 3]
7 3 0 1
After:  [3, 1, 0, 3]

Before: [0, 0, 2, 1]
14 3 2 2
After:  [0, 0, 1, 1]

Before: [0, 1, 2, 3]
0 1 0 1
After:  [0, 1, 2, 3]

Before: [3, 3, 2, 3]
12 2 3 1
After:  [3, 0, 2, 3]

Before: [0, 0, 3, 2]
2 0 0 1
After:  [0, 0, 3, 2]

Before: [1, 1, 1, 3]
10 2 1 0
After:  [2, 1, 1, 3]

Before: [1, 2, 2, 2]
1 0 2 2
After:  [1, 2, 0, 2]

Before: [0, 3, 3, 3]
2 0 0 0
After:  [0, 3, 3, 3]

Before: [2, 2, 2, 2]
11 0 3 2
After:  [2, 2, 1, 2]

Before: [3, 3, 2, 1]
14 3 2 1
After:  [3, 1, 2, 1]

Before: [1, 1, 2, 0]
4 1 2 1
After:  [1, 0, 2, 0]

Before: [3, 3, 0, 3]
3 0 3 2
After:  [3, 3, 1, 3]

Before: [2, 3, 0, 1]
5 3 1 0
After:  [1, 3, 0, 1]

Before: [3, 3, 3, 3]
3 2 3 1
After:  [3, 1, 3, 3]

Before: [2, 1, 2, 0]
4 1 2 3
After:  [2, 1, 2, 0]

Before: [1, 2, 3, 3]
13 3 3 2
After:  [1, 2, 1, 3]

Before: [3, 0, 1, 1]
0 2 1 0
After:  [1, 0, 1, 1]

Before: [3, 0, 0, 2]
15 3 3 3
After:  [3, 0, 0, 0]

Before: [2, 0, 3, 2]
11 0 3 3
After:  [2, 0, 3, 1]

Before: [1, 0, 3, 0]
0 0 1 2
After:  [1, 0, 1, 0]

Before: [2, 1, 3, 1]
6 1 2 0
After:  [0, 1, 3, 1]

Before: [3, 0, 0, 1]
15 3 3 0
After:  [0, 0, 0, 1]

Before: [0, 1, 1, 2]
2 0 0 0
After:  [0, 1, 1, 2]

Before: [0, 1, 2, 3]
4 1 2 0
After:  [0, 1, 2, 3]

Before: [2, 1, 0, 3]
12 1 3 3
After:  [2, 1, 0, 0]

Before: [0, 3, 3, 1]
5 3 1 1
After:  [0, 1, 3, 1]

Before: [0, 0, 0, 1]
2 0 0 2
After:  [0, 0, 0, 1]

Before: [0, 0, 3, 3]
2 0 0 0
After:  [0, 0, 3, 3]

Before: [1, 1, 2, 2]
4 1 2 0
After:  [0, 1, 2, 2]

Before: [2, 2, 2, 1]
14 3 2 2
After:  [2, 2, 1, 1]

Before: [1, 2, 2, 0]
7 2 1 0
After:  [1, 2, 2, 0]

Before: [2, 1, 1, 3]
13 3 2 3
After:  [2, 1, 1, 0]

Before: [3, 1, 3, 1]
6 1 2 2
After:  [3, 1, 0, 1]

Before: [3, 0, 1, 3]
0 2 1 2
After:  [3, 0, 1, 3]

Before: [0, 3, 0, 1]
5 3 1 0
After:  [1, 3, 0, 1]

Before: [1, 1, 1, 1]
10 2 1 1
After:  [1, 2, 1, 1]

Before: [0, 2, 2, 3]
7 2 1 0
After:  [1, 2, 2, 3]

Before: [1, 3, 2, 3]
1 0 2 2
After:  [1, 3, 0, 3]

Before: [3, 1, 1, 0]
10 2 1 3
After:  [3, 1, 1, 2]

Before: [3, 1, 3, 3]
12 1 3 0
After:  [0, 1, 3, 3]

Before: [3, 0, 2, 3]
7 3 0 0
After:  [1, 0, 2, 3]

Before: [2, 1, 2, 3]
4 1 2 1
After:  [2, 0, 2, 3]

Before: [3, 0, 3, 3]
7 3 2 0
After:  [1, 0, 3, 3]

Before: [1, 0, 1, 1]
8 2 0 1
After:  [1, 2, 1, 1]

Before: [1, 1, 1, 0]
8 2 0 1
After:  [1, 2, 1, 0]

Before: [1, 0, 2, 3]
1 0 2 2
After:  [1, 0, 0, 3]

Before: [0, 3, 1, 1]
5 3 1 0
After:  [1, 3, 1, 1]

Before: [0, 1, 2, 3]
4 1 2 3
After:  [0, 1, 2, 0]

Before: [2, 0, 2, 2]
11 0 3 0
After:  [1, 0, 2, 2]

Before: [0, 1, 3, 3]
6 1 2 2
After:  [0, 1, 0, 3]

Before: [2, 1, 1, 1]
10 2 1 1
After:  [2, 2, 1, 1]

Before: [3, 3, 0, 1]
15 3 3 2
After:  [3, 3, 0, 1]

Before: [1, 0, 2, 3]
13 3 2 3
After:  [1, 0, 2, 0]

Before: [3, 2, 2, 1]
14 3 2 3
After:  [3, 2, 2, 1]

Before: [1, 3, 1, 1]
15 3 3 2
After:  [1, 3, 0, 1]

Before: [1, 3, 1, 1]
5 3 1 3
After:  [1, 3, 1, 1]

Before: [2, 3, 2, 1]
14 3 2 3
After:  [2, 3, 2, 1]

Before: [3, 2, 1, 1]
15 3 3 3
After:  [3, 2, 1, 0]

Before: [1, 0, 1, 1]
0 3 1 0
After:  [1, 0, 1, 1]

Before: [2, 1, 2, 3]
4 1 2 3
After:  [2, 1, 2, 0]

Before: [2, 3, 1, 3]
12 2 3 1
After:  [2, 0, 1, 3]

Before: [1, 0, 2, 3]
12 2 3 1
After:  [1, 0, 2, 3]

Before: [3, 2, 1, 3]
12 1 3 0
After:  [0, 2, 1, 3]

Before: [1, 0, 2, 0]
0 0 1 1
After:  [1, 1, 2, 0]

Before: [3, 0, 2, 3]
3 0 3 1
After:  [3, 1, 2, 3]

Before: [2, 0, 2, 1]
14 3 2 3
After:  [2, 0, 2, 1]

Before: [2, 1, 1, 1]
15 3 3 0
After:  [0, 1, 1, 1]

Before: [3, 1, 2, 2]
4 1 2 2
After:  [3, 1, 0, 2]

Before: [3, 3, 2, 3]
12 2 3 0
After:  [0, 3, 2, 3]

Before: [1, 2, 2, 3]
7 2 1 0
After:  [1, 2, 2, 3]

Before: [3, 3, 0, 1]
15 3 3 1
After:  [3, 0, 0, 1]

Before: [3, 1, 3, 3]
6 1 2 2
After:  [3, 1, 0, 3]

Before: [0, 1, 1, 2]
2 0 0 2
After:  [0, 1, 0, 2]

Before: [1, 1, 1, 2]
10 2 1 2
After:  [1, 1, 2, 2]

Before: [1, 0, 2, 2]
1 0 2 0
After:  [0, 0, 2, 2]

Before: [0, 3, 2, 0]
2 0 0 3
After:  [0, 3, 2, 0]

Before: [1, 2, 2, 0]
1 0 2 2
After:  [1, 2, 0, 0]

Before: [0, 2, 2, 2]
7 2 1 2
After:  [0, 2, 1, 2]

Before: [0, 3, 0, 1]
15 3 3 0
After:  [0, 3, 0, 1]

Before: [1, 1, 2, 2]
4 1 2 3
After:  [1, 1, 2, 0]

Before: [3, 1, 0, 3]
7 3 0 3
After:  [3, 1, 0, 1]

Before: [3, 0, 2, 3]
12 2 3 3
After:  [3, 0, 2, 0]

Before: [2, 1, 2, 3]
9 1 0 3
After:  [2, 1, 2, 0]

Before: [3, 1, 1, 0]
10 2 1 1
After:  [3, 2, 1, 0]

Before: [3, 1, 1, 1]
8 2 3 3
After:  [3, 1, 1, 2]

Before: [0, 3, 3, 3]
3 2 3 2
After:  [0, 3, 1, 3]

Before: [2, 2, 2, 3]
12 2 3 2
After:  [2, 2, 0, 3]

Before: [1, 1, 2, 1]
14 3 2 2
After:  [1, 1, 1, 1]

Before: [2, 1, 2, 3]
9 1 0 2
After:  [2, 1, 0, 3]

Before: [1, 1, 2, 3]
13 3 2 1
After:  [1, 0, 2, 3]

Before: [0, 3, 2, 1]
5 3 1 2
After:  [0, 3, 1, 1]

Before: [2, 3, 3, 2]
11 0 3 1
After:  [2, 1, 3, 2]

Before: [2, 3, 2, 3]
3 0 2 0
After:  [1, 3, 2, 3]

Before: [3, 3, 0, 3]
7 3 0 0
After:  [1, 3, 0, 3]

Before: [2, 2, 2, 0]
3 0 2 3
After:  [2, 2, 2, 1]

Before: [0, 2, 2, 0]
13 0 0 3
After:  [0, 2, 2, 1]

Before: [1, 2, 2, 1]
1 0 2 3
After:  [1, 2, 2, 0]

Before: [3, 1, 1, 0]
10 2 1 0
After:  [2, 1, 1, 0]

Before: [1, 1, 2, 2]
1 0 2 0
After:  [0, 1, 2, 2]

Before: [3, 3, 0, 2]
15 3 3 2
After:  [3, 3, 0, 2]

Before: [1, 2, 2, 2]
1 0 2 0
After:  [0, 2, 2, 2]

Before: [1, 2, 3, 3]
13 3 1 0
After:  [0, 2, 3, 3]

Before: [2, 3, 2, 1]
5 3 1 0
After:  [1, 3, 2, 1]

Before: [0, 1, 2, 1]
2 0 0 3
After:  [0, 1, 2, 0]

Before: [2, 2, 3, 3]
7 3 2 1
After:  [2, 1, 3, 3]

Before: [2, 2, 2, 3]
7 2 0 3
After:  [2, 2, 2, 1]

Before: [0, 1, 1, 3]
10 2 1 0
After:  [2, 1, 1, 3]

Before: [3, 3, 3, 3]
3 0 3 1
After:  [3, 1, 3, 3]

Before: [1, 3, 1, 1]
5 3 1 2
After:  [1, 3, 1, 1]

Before: [1, 1, 1, 3]
10 2 1 1
After:  [1, 2, 1, 3]

Before: [0, 1, 1, 0]
10 2 1 3
After:  [0, 1, 1, 2]

Before: [3, 3, 2, 1]
14 3 2 2
After:  [3, 3, 1, 1]

Before: [2, 1, 2, 2]
4 1 2 0
After:  [0, 1, 2, 2]

Before: [2, 1, 0, 2]
9 1 0 2
After:  [2, 1, 0, 2]

Before: [2, 1, 1, 1]
15 2 3 1
After:  [2, 0, 1, 1]

Before: [0, 1, 1, 0]
10 2 1 1
After:  [0, 2, 1, 0]

Before: [0, 1, 3, 2]
0 1 0 1
After:  [0, 1, 3, 2]

Before: [0, 1, 1, 1]
8 2 3 1
After:  [0, 2, 1, 1]

Before: [2, 1, 3, 2]
11 0 3 0
After:  [1, 1, 3, 2]

Before: [3, 1, 2, 0]
4 1 2 3
After:  [3, 1, 2, 0]

Before: [0, 1, 2, 1]
2 0 0 0
After:  [0, 1, 2, 1]

Before: [0, 0, 3, 1]
2 0 0 1
After:  [0, 0, 3, 1]

Before: [1, 0, 2, 0]
0 0 1 0
After:  [1, 0, 2, 0]

Before: [1, 0, 2, 1]
1 0 2 3
After:  [1, 0, 2, 0]

Before: [1, 1, 2, 0]
1 0 2 1
After:  [1, 0, 2, 0]

Before: [2, 1, 3, 2]
9 1 0 1
After:  [2, 0, 3, 2]

Before: [3, 1, 2, 0]
4 1 2 0
After:  [0, 1, 2, 0]

Before: [0, 1, 1, 0]
0 1 0 3
After:  [0, 1, 1, 1]

Before: [3, 1, 2, 1]
14 3 2 1
After:  [3, 1, 2, 1]

Before: [2, 1, 0, 2]
11 0 3 1
After:  [2, 1, 0, 2]

Before: [2, 3, 2, 1]
5 3 1 3
After:  [2, 3, 2, 1]

Before: [2, 0, 2, 1]
14 3 2 0
After:  [1, 0, 2, 1]

Before: [2, 1, 3, 2]
9 1 0 0
After:  [0, 1, 3, 2]

Before: [0, 0, 2, 2]
13 0 0 0
After:  [1, 0, 2, 2]

Before: [1, 1, 2, 1]
1 0 2 3
After:  [1, 1, 2, 0]

Before: [1, 0, 2, 1]
15 3 3 1
After:  [1, 0, 2, 1]

Before: [2, 2, 1, 2]
11 0 3 2
After:  [2, 2, 1, 2]

Before: [0, 1, 3, 0]
6 1 2 2
After:  [0, 1, 0, 0]

Before: [2, 1, 3, 2]
9 1 0 3
After:  [2, 1, 3, 0]

Before: [1, 0, 0, 3]
0 0 1 2
After:  [1, 0, 1, 3]

Before: [2, 0, 2, 1]
14 3 2 2
After:  [2, 0, 1, 1]

Before: [2, 2, 0, 2]
11 0 3 0
After:  [1, 2, 0, 2]

Before: [2, 2, 2, 2]
11 0 3 0
After:  [1, 2, 2, 2]

Before: [1, 2, 2, 0]
7 2 1 3
After:  [1, 2, 2, 1]

Before: [3, 3, 2, 3]
12 2 3 3
After:  [3, 3, 2, 0]

Before: [1, 0, 2, 2]
1 0 2 3
After:  [1, 0, 2, 0]

Before: [0, 1, 1, 3]
10 2 1 2
After:  [0, 1, 2, 3]

Before: [1, 1, 2, 1]
4 1 2 3
After:  [1, 1, 2, 0]

Before: [1, 3, 3, 3]
13 3 3 3
After:  [1, 3, 3, 1]

Before: [3, 0, 1, 1]
8 2 3 3
After:  [3, 0, 1, 2]

Before: [2, 2, 0, 3]
13 3 1 2
After:  [2, 2, 0, 3]

Before: [1, 1, 3, 3]
13 2 1 0
After:  [0, 1, 3, 3]

Before: [1, 1, 1, 0]
10 2 1 3
After:  [1, 1, 1, 2]

Before: [0, 2, 1, 3]
2 0 0 0
After:  [0, 2, 1, 3]

Before: [0, 3, 2, 1]
14 3 2 1
After:  [0, 1, 2, 1]

Before: [2, 1, 2, 2]
11 0 3 3
After:  [2, 1, 2, 1]

Before: [1, 0, 1, 0]
8 2 0 3
After:  [1, 0, 1, 2]

Before: [0, 2, 0, 2]
2 0 0 1
After:  [0, 0, 0, 2]

Before: [3, 1, 2, 2]
4 1 2 1
After:  [3, 0, 2, 2]

Before: [2, 0, 1, 1]
0 2 1 0
After:  [1, 0, 1, 1]

Before: [1, 1, 3, 1]
15 3 3 1
After:  [1, 0, 3, 1]

Before: [0, 1, 1, 3]
0 1 0 1
After:  [0, 1, 1, 3]

Before: [1, 0, 1, 3]
12 2 3 2
After:  [1, 0, 0, 3]

Before: [3, 2, 2, 1]
14 3 2 1
After:  [3, 1, 2, 1]

Before: [0, 0, 2, 3]
13 2 2 1
After:  [0, 1, 2, 3]

Before: [0, 1, 1, 0]
0 1 0 0
After:  [1, 1, 1, 0]

Before: [0, 3, 0, 1]
2 0 0 3
After:  [0, 3, 0, 0]

Before: [0, 1, 2, 3]
4 1 2 2
After:  [0, 1, 0, 3]

Before: [0, 2, 1, 3]
13 3 2 0
After:  [0, 2, 1, 3]

Before: [3, 1, 3, 3]
6 1 2 1
After:  [3, 0, 3, 3]

Before: [2, 1, 1, 2]
9 1 0 2
After:  [2, 1, 0, 2]

Before: [0, 0, 2, 1]
14 3 2 1
After:  [0, 1, 2, 1]

Before: [3, 2, 1, 3]
12 2 3 0
After:  [0, 2, 1, 3]

Before: [0, 2, 3, 3]
7 3 2 3
After:  [0, 2, 3, 1]

Before: [0, 1, 1, 3]
12 1 3 1
After:  [0, 0, 1, 3]

Before: [0, 1, 2, 1]
2 0 0 2
After:  [0, 1, 0, 1]

Before: [2, 0, 0, 2]
11 0 3 1
After:  [2, 1, 0, 2]

Before: [1, 3, 2, 3]
13 3 3 2
After:  [1, 3, 1, 3]

Before: [2, 3, 1, 1]
5 3 1 1
After:  [2, 1, 1, 1]

Before: [0, 0, 1, 1]
0 3 1 0
After:  [1, 0, 1, 1]

Before: [1, 2, 1, 3]
8 2 0 1
After:  [1, 2, 1, 3]

Before: [3, 3, 1, 3]
12 2 3 2
After:  [3, 3, 0, 3]

Before: [3, 1, 1, 1]
8 2 3 0
After:  [2, 1, 1, 1]

Before: [1, 3, 3, 1]
5 3 1 1
After:  [1, 1, 3, 1]

Before: [1, 1, 2, 3]
1 0 2 3
After:  [1, 1, 2, 0]

Before: [0, 0, 2, 2]
2 0 0 2
After:  [0, 0, 0, 2]

Before: [0, 1, 2, 1]
14 3 2 3
After:  [0, 1, 2, 1]

Before: [1, 3, 3, 1]
7 2 3 3
After:  [1, 3, 3, 0]

Before: [2, 1, 3, 2]
15 3 3 2
After:  [2, 1, 0, 2]

Before: [0, 3, 3, 3]
7 3 2 2
After:  [0, 3, 1, 3]

Before: [1, 0, 3, 1]
0 3 1 2
After:  [1, 0, 1, 1]

Before: [1, 0, 2, 2]
1 0 2 1
After:  [1, 0, 2, 2]

Before: [0, 1, 1, 3]
2 0 0 2
After:  [0, 1, 0, 3]

Before: [3, 1, 3, 3]
6 1 2 3
After:  [3, 1, 3, 0]

Before: [1, 0, 1, 0]
8 2 0 1
After:  [1, 2, 1, 0]

Before: [1, 2, 3, 3]
3 2 3 2
After:  [1, 2, 1, 3]

Before: [1, 1, 3, 1]
6 1 2 2
After:  [1, 1, 0, 1]

Before: [2, 1, 0, 3]
9 1 0 3
After:  [2, 1, 0, 0]

Before: [3, 3, 0, 1]
5 3 1 3
After:  [3, 3, 0, 1]

Before: [2, 0, 1, 2]
11 0 3 1
After:  [2, 1, 1, 2]

Before: [2, 2, 3, 3]
7 3 2 0
After:  [1, 2, 3, 3]

Before: [1, 3, 2, 1]
14 3 2 3
After:  [1, 3, 2, 1]

Before: [3, 1, 3, 2]
6 1 2 1
After:  [3, 0, 3, 2]

Before: [0, 2, 3, 3]
12 1 3 0
After:  [0, 2, 3, 3]

Before: [0, 2, 2, 1]
7 2 1 0
After:  [1, 2, 2, 1]

Before: [0, 1, 1, 1]
15 3 3 0
After:  [0, 1, 1, 1]

Before: [3, 3, 1, 1]
5 3 1 2
After:  [3, 3, 1, 1]

Before: [2, 3, 2, 0]
3 0 2 0
After:  [1, 3, 2, 0]

Before: [2, 1, 2, 2]
4 1 2 1
After:  [2, 0, 2, 2]

Before: [0, 0, 3, 3]
3 2 3 1
After:  [0, 1, 3, 3]

Before: [3, 1, 1, 2]
10 2 1 0
After:  [2, 1, 1, 2]

Before: [1, 2, 2, 1]
14 3 2 0
After:  [1, 2, 2, 1]

Before: [3, 1, 1, 3]
13 3 2 3
After:  [3, 1, 1, 0]

Before: [1, 2, 0, 1]
15 3 3 3
After:  [1, 2, 0, 0]

Before: [1, 1, 2, 3]
4 1 2 1
After:  [1, 0, 2, 3]

Before: [2, 1, 0, 3]
9 1 0 1
After:  [2, 0, 0, 3]

Before: [2, 1, 0, 1]
9 1 0 3
After:  [2, 1, 0, 0]

Before: [1, 2, 1, 3]
12 1 3 1
After:  [1, 0, 1, 3]

Before: [2, 1, 3, 0]
6 1 2 2
After:  [2, 1, 0, 0]

Before: [1, 3, 1, 2]
8 2 0 0
After:  [2, 3, 1, 2]

Before: [2, 1, 2, 3]
12 1 3 1
After:  [2, 0, 2, 3]

Before: [1, 3, 2, 2]
1 0 2 0
After:  [0, 3, 2, 2]

Before: [0, 3, 2, 3]
12 2 3 1
After:  [0, 0, 2, 3]

Before: [2, 2, 1, 2]
11 0 3 3
After:  [2, 2, 1, 1]

Before: [2, 1, 1, 3]
12 1 3 0
After:  [0, 1, 1, 3]

Before: [2, 0, 2, 1]
7 2 0 1
After:  [2, 1, 2, 1]

Before: [3, 3, 2, 1]
5 3 1 0
After:  [1, 3, 2, 1]

Before: [2, 3, 2, 2]
13 2 2 3
After:  [2, 3, 2, 1]

Before: [2, 3, 3, 1]
7 2 3 3
After:  [2, 3, 3, 0]

Before: [2, 3, 1, 1]
5 3 1 2
After:  [2, 3, 1, 1]

Before: [2, 1, 3, 0]
9 1 0 1
After:  [2, 0, 3, 0]

Before: [2, 1, 2, 2]
4 1 2 2
After:  [2, 1, 0, 2]

Before: [3, 3, 3, 1]
5 3 1 0
After:  [1, 3, 3, 1]

Before: [3, 2, 0, 2]
15 3 3 3
After:  [3, 2, 0, 0]

Before: [3, 3, 2, 3]
13 2 2 0
After:  [1, 3, 2, 3]

Before: [0, 3, 3, 3]
13 0 0 3
After:  [0, 3, 3, 1]

Before: [2, 1, 2, 1]
4 1 2 0
After:  [0, 1, 2, 1]

Before: [0, 3, 0, 1]
13 0 0 3
After:  [0, 3, 0, 1]

Before: [1, 0, 1, 2]
8 2 0 3
After:  [1, 0, 1, 2]

Before: [1, 3, 2, 1]
14 3 2 1
After:  [1, 1, 2, 1]

Before: [0, 2, 3, 1]
15 3 3 1
After:  [0, 0, 3, 1]

Before: [1, 2, 1, 2]
8 2 0 2
After:  [1, 2, 2, 2]

Before: [0, 0, 1, 2]
2 0 0 1
After:  [0, 0, 1, 2]

Before: [2, 1, 3, 2]
6 1 2 3
After:  [2, 1, 3, 0]

Before: [2, 1, 3, 3]
9 1 0 3
After:  [2, 1, 3, 0]

Before: [2, 1, 3, 3]
9 1 0 2
After:  [2, 1, 0, 3]

Before: [2, 1, 1, 2]
9 1 0 0
After:  [0, 1, 1, 2]

Before: [0, 0, 1, 2]
2 0 0 2
After:  [0, 0, 0, 2]

Before: [2, 0, 3, 3]
7 3 2 1
After:  [2, 1, 3, 3]

Before: [0, 3, 1, 2]
2 0 0 2
After:  [0, 3, 0, 2]

Before: [1, 2, 3, 3]
12 1 3 1
After:  [1, 0, 3, 3]

Before: [0, 1, 0, 3]
12 1 3 2
After:  [0, 1, 0, 3]

Before: [1, 0, 1, 2]
8 2 0 1
After:  [1, 2, 1, 2]

Before: [1, 0, 2, 1]
0 0 1 1
After:  [1, 1, 2, 1]

Before: [1, 1, 2, 1]
4 1 2 2
After:  [1, 1, 0, 1]

Before: [1, 3, 0, 1]
5 3 1 3
After:  [1, 3, 0, 1]

Before: [1, 3, 1, 1]
8 2 0 3
After:  [1, 3, 1, 2]

Before: [0, 3, 1, 1]
5 3 1 2
After:  [0, 3, 1, 1]

Before: [2, 2, 0, 2]
11 0 3 2
After:  [2, 2, 1, 2]

Before: [2, 1, 2, 2]
9 1 0 2
After:  [2, 1, 0, 2]

Before: [1, 1, 3, 0]
6 1 2 1
After:  [1, 0, 3, 0]

Before: [0, 3, 0, 1]
5 3 1 2
After:  [0, 3, 1, 1]

Before: [2, 2, 2, 1]
7 2 0 0
After:  [1, 2, 2, 1]

Before: [1, 3, 2, 3]
1 0 2 1
After:  [1, 0, 2, 3]

Before: [0, 1, 1, 1]
10 2 1 2
After:  [0, 1, 2, 1]

Before: [0, 1, 1, 1]
10 2 1 0
After:  [2, 1, 1, 1]

Before: [1, 3, 2, 2]
1 0 2 2
After:  [1, 3, 0, 2]

Before: [3, 3, 0, 3]
13 3 3 2
After:  [3, 3, 1, 3]

Before: [1, 0, 2, 0]
1 0 2 2
After:  [1, 0, 0, 0]

Before: [3, 3, 3, 1]
5 3 1 3
After:  [3, 3, 3, 1]

Before: [2, 1, 3, 0]
9 1 0 0
After:  [0, 1, 3, 0]

Before: [3, 1, 1, 3]
10 2 1 1
After:  [3, 2, 1, 3]

Before: [3, 1, 2, 3]
12 2 3 1
After:  [3, 0, 2, 3]

Before: [2, 1, 3, 2]
11 0 3 1
After:  [2, 1, 3, 2]

Before: [2, 1, 2, 1]
14 3 2 2
After:  [2, 1, 1, 1]

Before: [2, 1, 2, 1]
9 1 0 0
After:  [0, 1, 2, 1]

Before: [2, 3, 3, 1]
5 3 1 2
After:  [2, 3, 1, 1]

Before: [0, 1, 1, 1]
2 0 0 1
After:  [0, 0, 1, 1]

Before: [3, 0, 3, 1]
0 3 1 2
After:  [3, 0, 1, 1]

Before: [3, 1, 2, 1]
4 1 2 1
After:  [3, 0, 2, 1]

Before: [2, 2, 2, 1]
14 3 2 1
After:  [2, 1, 2, 1]

Before: [1, 1, 2, 3]
12 1 3 0
After:  [0, 1, 2, 3]

Before: [3, 3, 1, 3]
7 3 0 0
After:  [1, 3, 1, 3]

Before: [1, 1, 2, 2]
1 0 2 1
After:  [1, 0, 2, 2]

Before: [1, 0, 2, 3]
0 0 1 3
After:  [1, 0, 2, 1]

Before: [1, 0, 2, 1]
1 0 2 2
After:  [1, 0, 0, 1]

Before: [2, 0, 2, 3]
12 2 3 3
After:  [2, 0, 2, 0]

Before: [2, 1, 0, 1]
9 1 0 0
After:  [0, 1, 0, 1]

Before: [0, 3, 3, 1]
5 3 1 0
After:  [1, 3, 3, 1]

Before: [3, 1, 3, 3]
6 1 2 0
After:  [0, 1, 3, 3]

Before: [2, 1, 2, 0]
9 1 0 0
After:  [0, 1, 2, 0]

Before: [2, 3, 3, 1]
5 3 1 0
After:  [1, 3, 3, 1]

Before: [2, 1, 1, 3]
9 1 0 0
After:  [0, 1, 1, 3]

Before: [3, 3, 1, 1]
5 3 1 0
After:  [1, 3, 1, 1]

Before: [1, 0, 1, 3]
0 2 1 0
After:  [1, 0, 1, 3]

Before: [1, 0, 2, 3]
1 0 2 3
After:  [1, 0, 2, 0]

Before: [2, 3, 2, 1]
14 3 2 0
After:  [1, 3, 2, 1]

Before: [3, 1, 3, 1]
6 1 2 3
After:  [3, 1, 3, 0]

Before: [0, 0, 0, 0]
2 0 0 0
After:  [0, 0, 0, 0]

Before: [3, 3, 1, 1]
5 3 1 3
After:  [3, 3, 1, 1]

Before: [3, 1, 3, 2]
6 1 2 3
After:  [3, 1, 3, 0]

Before: [3, 2, 1, 3]
7 3 0 2
After:  [3, 2, 1, 3]

Before: [2, 3, 2, 1]
14 3 2 1
After:  [2, 1, 2, 1]

Before: [1, 1, 2, 2]
1 0 2 2
After:  [1, 1, 0, 2]

Before: [3, 1, 3, 1]
7 2 3 2
After:  [3, 1, 0, 1]

Before: [0, 0, 1, 1]
0 2 1 0
After:  [1, 0, 1, 1]

Before: [2, 1, 2, 3]
4 1 2 2
After:  [2, 1, 0, 3]

Before: [3, 1, 3, 0]
6 1 2 0
After:  [0, 1, 3, 0]

Before: [2, 3, 2, 2]
3 0 2 2
After:  [2, 3, 1, 2]

Before: [1, 2, 2, 0]
1 0 2 3
After:  [1, 2, 2, 0]

Before: [1, 1, 2, 2]
1 0 2 3
After:  [1, 1, 2, 0]

Before: [1, 1, 1, 3]
10 2 1 3
After:  [1, 1, 1, 2]

Before: [0, 1, 1, 0]
10 2 1 0
After:  [2, 1, 1, 0]

Before: [2, 2, 3, 3]
3 2 3 0
After:  [1, 2, 3, 3]

Before: [0, 3, 3, 3]
3 2 3 1
After:  [0, 1, 3, 3]

Before: [1, 3, 3, 1]
5 3 1 2
After:  [1, 3, 1, 1]

Before: [3, 1, 1, 0]
10 2 1 2
After:  [3, 1, 2, 0]

Before: [0, 0, 0, 0]
13 0 0 2
After:  [0, 0, 1, 0]

Before: [2, 3, 0, 1]
5 3 1 3
After:  [2, 3, 0, 1]

Before: [3, 0, 2, 1]
14 3 2 2
After:  [3, 0, 1, 1]

Before: [2, 1, 2, 1]
4 1 2 1
After:  [2, 0, 2, 1]

Before: [1, 2, 2, 1]
14 3 2 3
After:  [1, 2, 2, 1]

Before: [1, 3, 3, 3]
13 3 3 2
After:  [1, 3, 1, 3]

Before: [1, 0, 2, 1]
14 3 2 0
After:  [1, 0, 2, 1]

Before: [0, 1, 1, 3]
12 2 3 3
After:  [0, 1, 1, 0]

Before: [2, 3, 3, 1]
5 3 1 3
After:  [2, 3, 3, 1]

Before: [0, 3, 3, 2]
13 0 0 0
After:  [1, 3, 3, 2]

Before: [0, 1, 3, 3]
7 3 2 1
After:  [0, 1, 3, 3]

Before: [2, 1, 3, 3]
7 3 2 3
After:  [2, 1, 3, 1]

Before: [1, 1, 1, 3]
8 2 0 2
After:  [1, 1, 2, 3]

Before: [0, 1, 1, 2]
10 2 1 3
After:  [0, 1, 1, 2]

Before: [2, 1, 3, 2]
6 1 2 0
After:  [0, 1, 3, 2]

Before: [0, 0, 1, 2]
15 3 3 2
After:  [0, 0, 0, 2]

Before: [3, 1, 3, 2]
6 1 2 2
After:  [3, 1, 0, 2]

Before: [2, 0, 3, 2]
11 0 3 0
After:  [1, 0, 3, 2]

Before: [1, 3, 2, 3]
12 2 3 0
After:  [0, 3, 2, 3]

Before: [0, 3, 1, 2]
13 0 0 2
After:  [0, 3, 1, 2]

Before: [1, 2, 1, 1]
8 2 3 2
After:  [1, 2, 2, 1]

Before: [2, 0, 2, 2]
11 0 3 2
After:  [2, 0, 1, 2]

Before: [1, 3, 0, 1]
5 3 1 2
After:  [1, 3, 1, 1]

Before: [3, 2, 3, 3]
7 3 2 2
After:  [3, 2, 1, 3]

Before: [3, 2, 0, 3]
12 1 3 1
After:  [3, 0, 0, 3]

Before: [0, 3, 1, 0]
2 0 0 1
After:  [0, 0, 1, 0]

Before: [2, 1, 3, 3]
12 1 3 3
After:  [2, 1, 3, 0]

Before: [2, 1, 1, 1]
9 1 0 3
After:  [2, 1, 1, 0]

Before: [0, 1, 3, 2]
15 3 3 1
After:  [0, 0, 3, 2]

Before: [1, 1, 2, 1]
14 3 2 0
After:  [1, 1, 2, 1]

Before: [0, 1, 0, 3]
12 1 3 1
After:  [0, 0, 0, 3]

Before: [2, 1, 2, 0]
9 1 0 1
After:  [2, 0, 2, 0]

Before: [3, 3, 2, 3]
7 3 0 3
After:  [3, 3, 2, 1]

Before: [1, 2, 1, 3]
8 2 0 3
After:  [1, 2, 1, 2]

Before: [0, 0, 1, 2]
0 2 1 0
After:  [1, 0, 1, 2]

Before: [1, 0, 1, 0]
0 0 1 3
After:  [1, 0, 1, 1]

Before: [0, 1, 1, 1]
10 2 1 3
After:  [0, 1, 1, 2]

Before: [1, 1, 1, 3]
12 1 3 0
After:  [0, 1, 1, 3]

Before: [1, 0, 2, 0]
1 0 2 3
After:  [1, 0, 2, 0]

Before: [0, 1, 3, 1]
6 1 2 2
After:  [0, 1, 0, 1]

Before: [3, 1, 2, 1]
4 1 2 0
After:  [0, 1, 2, 1]

Before: [1, 3, 1, 3]
8 2 0 3
After:  [1, 3, 1, 2]

Before: [0, 3, 0, 0]
13 0 0 3
After:  [0, 3, 0, 1]

Before: [1, 3, 2, 0]
1 0 2 2
After:  [1, 3, 0, 0]

Before: [0, 3, 0, 1]
5 3 1 3
After:  [0, 3, 0, 1]

Before: [3, 0, 0, 3]
3 0 3 1
After:  [3, 1, 0, 3]

Before: [2, 2, 3, 2]
11 0 3 3
After:  [2, 2, 3, 1]

Before: [1, 1, 3, 3]
6 1 2 1
After:  [1, 0, 3, 3]

Before: [2, 2, 1, 2]
11 0 3 1
After:  [2, 1, 1, 2]

Before: [3, 1, 3, 0]
6 1 2 2
After:  [3, 1, 0, 0]

Before: [0, 1, 3, 2]
6 1 2 2
After:  [0, 1, 0, 2]

Before: [2, 3, 0, 1]
5 3 1 2
After:  [2, 3, 1, 1]

Before: [1, 2, 2, 3]
1 0 2 2
After:  [1, 2, 0, 3]

Before: [3, 2, 0, 3]
7 3 0 3
After:  [3, 2, 0, 1]

Before: [3, 0, 2, 3]
3 0 3 2
After:  [3, 0, 1, 3]

Before: [2, 2, 3, 2]
11 0 3 0
After:  [1, 2, 3, 2]

Before: [2, 2, 3, 1]
7 2 3 2
After:  [2, 2, 0, 1]

Before: [1, 0, 2, 0]
1 0 2 1
After:  [1, 0, 2, 0]

Before: [0, 1, 1, 3]
10 2 1 3
After:  [0, 1, 1, 2]

Before: [0, 0, 1, 2]
15 3 3 3
After:  [0, 0, 1, 0]

Before: [3, 3, 2, 0]
13 2 2 1
After:  [3, 1, 2, 0]

Before: [0, 1, 3, 2]
2 0 0 2
After:  [0, 1, 0, 2]

Before: [0, 2, 2, 1]
14 3 2 1
After:  [0, 1, 2, 1]

Before: [1, 1, 3, 2]
15 3 3 0
After:  [0, 1, 3, 2]

Before: [2, 1, 1, 2]
9 1 0 3
After:  [2, 1, 1, 0]

Before: [3, 0, 1, 0]
0 2 1 1
After:  [3, 1, 1, 0]

Before: [1, 2, 2, 3]
1 0 2 1
After:  [1, 0, 2, 3]

Before: [2, 0, 2, 2]
3 0 2 0
After:  [1, 0, 2, 2]

Before: [2, 1, 3, 2]
6 1 2 2
After:  [2, 1, 0, 2]

Before: [3, 3, 0, 1]
5 3 1 1
After:  [3, 1, 0, 1]

Before: [0, 0, 0, 3]
2 0 0 1
After:  [0, 0, 0, 3]

Before: [0, 0, 1, 1]
13 0 0 3
After:  [0, 0, 1, 1]

Before: [3, 1, 3, 3]
7 3 2 2
After:  [3, 1, 1, 3]

Before: [1, 0, 2, 1]
14 3 2 2
After:  [1, 0, 1, 1]

Before: [0, 2, 3, 3]
7 3 2 2
After:  [0, 2, 1, 3]

Before: [0, 3, 2, 2]
2 0 0 3
After:  [0, 3, 2, 0]

Before: [0, 0, 1, 1]
8 2 3 2
After:  [0, 0, 2, 1]

Before: [2, 3, 1, 2]
11 0 3 2
After:  [2, 3, 1, 2]

Before: [0, 3, 2, 1]
5 3 1 3
After:  [0, 3, 2, 1]

Before: [1, 3, 2, 1]
1 0 2 1
After:  [1, 0, 2, 1]

Before: [3, 1, 2, 1]
4 1 2 2
After:  [3, 1, 0, 1]

Before: [3, 2, 2, 3]
3 0 3 2
After:  [3, 2, 1, 3]

Before: [1, 0, 1, 0]
8 2 0 0
After:  [2, 0, 1, 0]

Before: [3, 2, 2, 3]
3 0 3 1
After:  [3, 1, 2, 3]

Before: [1, 1, 2, 0]
1 0 2 3
After:  [1, 1, 2, 0]

Before: [1, 3, 0, 1]
5 3 1 0
After:  [1, 3, 0, 1]

Before: [3, 1, 2, 2]
4 1 2 0
After:  [0, 1, 2, 2]

Before: [0, 3, 1, 1]
13 0 0 1
After:  [0, 1, 1, 1]

Before: [2, 3, 0, 1]
5 3 1 1
After:  [2, 1, 0, 1]

Before: [2, 0, 0, 2]
11 0 3 0
After:  [1, 0, 0, 2]

Before: [2, 2, 3, 3]
12 1 3 0
After:  [0, 2, 3, 3]

Before: [2, 2, 2, 0]
3 0 2 0
After:  [1, 2, 2, 0]

Before: [0, 3, 2, 1]
5 3 1 0
After:  [1, 3, 2, 1]

Before: [1, 1, 2, 2]
4 1 2 1
After:  [1, 0, 2, 2]

Before: [2, 1, 0, 3]
9 1 0 2
After:  [2, 1, 0, 3]

Before: [3, 0, 3, 3]
13 3 3 1
After:  [3, 1, 3, 3]

Before: [1, 2, 3, 3]
12 1 3 0
After:  [0, 2, 3, 3]

Before: [3, 1, 3, 3]
3 0 3 1
After:  [3, 1, 3, 3]

Before: [1, 1, 2, 3]
13 3 3 3
After:  [1, 1, 2, 1]

Before: [0, 3, 1, 1]
8 2 3 3
After:  [0, 3, 1, 2]

Before: [3, 1, 1, 3]
12 1 3 2
After:  [3, 1, 0, 3]

Before: [2, 1, 3, 0]
6 1 2 0
After:  [0, 1, 3, 0]

Before: [1, 0, 2, 2]
1 0 2 2
After:  [1, 0, 0, 2]

Before: [2, 2, 1, 3]
12 1 3 2
After:  [2, 2, 0, 3]

Before: [2, 0, 1, 2]
11 0 3 2
After:  [2, 0, 1, 2]

Before: [0, 2, 2, 1]
2 0 0 3
After:  [0, 2, 2, 0]

Before: [2, 3, 1, 1]
5 3 1 0
After:  [1, 3, 1, 1]

Before: [0, 2, 1, 1]
8 2 3 3
After:  [0, 2, 1, 2]

Before: [3, 1, 2, 1]
14 3 2 2
After:  [3, 1, 1, 1]

Before: [1, 2, 1, 3]
13 3 2 3
After:  [1, 2, 1, 0]

Before: [2, 3, 1, 2]
11 0 3 1
After:  [2, 1, 1, 2]

Before: [3, 1, 1, 2]
10 2 1 3
After:  [3, 1, 1, 2]

Before: [2, 1, 2, 2]
11 0 3 1
After:  [2, 1, 2, 2]

Before: [1, 1, 3, 1]
6 1 2 0
After:  [0, 1, 3, 1]

Before: [0, 2, 0, 0]
2 0 0 3
After:  [0, 2, 0, 0]

Before: [2, 3, 2, 1]
3 0 2 1
After:  [2, 1, 2, 1]

Before: [3, 1, 1, 3]
12 1 3 1
After:  [3, 0, 1, 3]

Before: [0, 1, 0, 3]
13 3 1 1
After:  [0, 0, 0, 3]

Before: [0, 3, 1, 2]
2 0 0 0
After:  [0, 3, 1, 2]

Before: [2, 2, 2, 0]
7 2 1 3
After:  [2, 2, 2, 1]

Before: [2, 1, 1, 1]
9 1 0 1
After:  [2, 0, 1, 1]

Before: [1, 1, 3, 3]
6 1 2 2
After:  [1, 1, 0, 3]

Before: [3, 2, 1, 1]
8 2 3 3
After:  [3, 2, 1, 2]

Before: [0, 2, 2, 1]
14 3 2 0
After:  [1, 2, 2, 1]

Before: [3, 3, 3, 1]
15 3 3 1
After:  [3, 0, 3, 1]

Before: [2, 3, 0, 2]
11 0 3 0
After:  [1, 3, 0, 2]

Before: [2, 2, 2, 2]
7 2 0 1
After:  [2, 1, 2, 2]

Before: [1, 1, 1, 1]
8 2 0 0
After:  [2, 1, 1, 1]

Before: [2, 1, 1, 1]
9 1 0 0
After:  [0, 1, 1, 1]

Before: [2, 2, 3, 3]
7 3 2 2
After:  [2, 2, 1, 3]

Before: [2, 1, 3, 3]
6 1 2 3
After:  [2, 1, 3, 0]

Before: [0, 3, 0, 3]
13 3 3 1
After:  [0, 1, 0, 3]

Before: [2, 1, 3, 1]
9 1 0 0
After:  [0, 1, 3, 1]

Before: [0, 1, 2, 2]
2 0 0 2
After:  [0, 1, 0, 2]

Before: [2, 3, 1, 3]
12 2 3 0
After:  [0, 3, 1, 3]

Before: [2, 1, 1, 0]
9 1 0 2
After:  [2, 1, 0, 0]

Before: [0, 1, 0, 3]
13 0 0 3
After:  [0, 1, 0, 1]

Before: [0, 1, 2, 3]
13 3 2 2
After:  [0, 1, 0, 3]

Before: [3, 0, 3, 3]
3 0 3 1
After:  [3, 1, 3, 3]

Before: [2, 1, 2, 1]
9 1 0 1
After:  [2, 0, 2, 1]

Before: [1, 1, 1, 2]
10 2 1 3
After:  [1, 1, 1, 2]

Before: [0, 0, 2, 1]
14 3 2 0
After:  [1, 0, 2, 1]

Before: [3, 3, 3, 1]
5 3 1 1
After:  [3, 1, 3, 1]

Before: [3, 0, 2, 0]
13 2 2 2
After:  [3, 0, 1, 0]

Before: [2, 0, 2, 1]
0 3 1 0
After:  [1, 0, 2, 1]

Before: [1, 0, 2, 3]
1 0 2 0
After:  [0, 0, 2, 3]

Before: [0, 0, 2, 3]
12 2 3 1
After:  [0, 0, 2, 3]

Before: [3, 1, 3, 3]
7 3 0 0
After:  [1, 1, 3, 3]

Before: [3, 0, 0, 3]
3 0 3 3
After:  [3, 0, 0, 1]

Before: [2, 3, 1, 2]
11 0 3 0
After:  [1, 3, 1, 2]

Before: [3, 1, 3, 3]
7 3 2 3
After:  [3, 1, 3, 1]

Before: [2, 0, 0, 2]
11 0 3 3
After:  [2, 0, 0, 1]

Before: [3, 3, 0, 1]
5 3 1 2
After:  [3, 3, 1, 1]

Before: [2, 1, 2, 1]
14 3 2 1
After:  [2, 1, 2, 1]

Before: [2, 0, 3, 2]
15 3 3 2
After:  [2, 0, 0, 2]

Before: [1, 1, 3, 3]
3 2 3 0
After:  [1, 1, 3, 3]

Before: [3, 0, 0, 3]
7 3 0 3
After:  [3, 0, 0, 1]

Before: [2, 1, 3, 0]
9 1 0 2
After:  [2, 1, 0, 0]

Before: [0, 3, 3, 0]
2 0 0 0
After:  [0, 3, 3, 0]

Before: [1, 0, 1, 1]
0 2 1 1
After:  [1, 1, 1, 1]

Before: [1, 1, 2, 1]
4 1 2 0
After:  [0, 1, 2, 1]

Before: [0, 0, 2, 3]
2 0 0 2
After:  [0, 0, 0, 3]

Before: [1, 1, 1, 3]
13 3 1 1
After:  [1, 0, 1, 3]

Before: [2, 1, 1, 2]
10 2 1 2
After:  [2, 1, 2, 2]

Before: [0, 2, 1, 1]
2 0 0 1
After:  [0, 0, 1, 1]

Before: [2, 1, 2, 3]
4 1 2 0
After:  [0, 1, 2, 3]

Before: [3, 2, 1, 1]
15 2 3 1
After:  [3, 0, 1, 1]

Before: [3, 0, 3, 3]
3 0 3 0
After:  [1, 0, 3, 3]

Before: [1, 2, 2, 1]
1 0 2 2
After:  [1, 2, 0, 1]

Before: [3, 3, 2, 3]
3 0 3 2
After:  [3, 3, 1, 3]

Before: [2, 1, 0, 1]
9 1 0 2
After:  [2, 1, 0, 1]

Before: [2, 1, 0, 1]
9 1 0 1
After:  [2, 0, 0, 1]

Before: [1, 2, 2, 1]
1 0 2 0
After:  [0, 2, 2, 1]

Before: [3, 1, 3, 2]
6 1 2 0
After:  [0, 1, 3, 2]

Before: [0, 2, 2, 1]
14 3 2 2
After:  [0, 2, 1, 1]

Before: [1, 2, 2, 3]
1 0 2 3
After:  [1, 2, 2, 0]

Before: [0, 1, 1, 2]
0 1 0 3
After:  [0, 1, 1, 1]

Before: [1, 3, 1, 1]
5 3 1 1
After:  [1, 1, 1, 1]

Before: [2, 1, 3, 1]
15 3 3 2
After:  [2, 1, 0, 1]

Before: [2, 1, 1, 3]
10 2 1 3
After:  [2, 1, 1, 2]

Before: [0, 1, 1, 0]
2 0 0 3
After:  [0, 1, 1, 0]

Before: [1, 1, 3, 2]
6 1 2 3
After:  [1, 1, 3, 0]

Before: [2, 1, 1, 2]
10 2 1 3
After:  [2, 1, 1, 2]

Before: [1, 2, 1, 3]
13 3 3 3
After:  [1, 2, 1, 1]

Before: [1, 0, 1, 3]
8 2 0 1
After:  [1, 2, 1, 3]

Before: [3, 3, 2, 2]
13 2 2 2
After:  [3, 3, 1, 2]

Before: [3, 1, 2, 0]
13 2 2 0
After:  [1, 1, 2, 0]

Before: [0, 1, 3, 2]
6 1 2 3
After:  [0, 1, 3, 0]

Before: [1, 0, 2, 3]
0 0 1 2
After:  [1, 0, 1, 3]

Before: [0, 2, 0, 2]
15 3 3 3
After:  [0, 2, 0, 0]

Before: [2, 1, 2, 2]
3 0 2 3
After:  [2, 1, 2, 1]

Before: [2, 1, 3, 2]
11 0 3 3
After:  [2, 1, 3, 1]

Before: [2, 2, 2, 2]
7 2 0 3
After:  [2, 2, 2, 1]

Before: [2, 1, 0, 0]
9 1 0 2
After:  [2, 1, 0, 0]

Before: [1, 1, 3, 2]
15 3 3 1
After:  [1, 0, 3, 2]

Before: [3, 0, 1, 2]
15 3 3 2
After:  [3, 0, 0, 2]

Before: [0, 2, 1, 3]
12 2 3 0
After:  [0, 2, 1, 3]

Before: [3, 2, 2, 1]
7 2 1 1
After:  [3, 1, 2, 1]

Before: [0, 2, 0, 1]
2 0 0 3
After:  [0, 2, 0, 0]

Before: [0, 0, 2, 1]
14 3 2 3
After:  [0, 0, 2, 1]

Before: [2, 0, 0, 1]
0 3 1 2
After:  [2, 0, 1, 1]

Before: [3, 1, 1, 1]
8 2 3 1
After:  [3, 2, 1, 1]

Before: [1, 2, 2, 1]
14 3 2 1
After:  [1, 1, 2, 1]

Before: [0, 1, 2, 2]
4 1 2 2
After:  [0, 1, 0, 2]

Before: [2, 2, 0, 2]
11 0 3 1
After:  [2, 1, 0, 2]

Before: [0, 1, 0, 2]
15 3 3 3
After:  [0, 1, 0, 0]

Before: [0, 0, 0, 1]
13 0 0 0
After:  [1, 0, 0, 1]

Before: [2, 0, 1, 1]
0 2 1 1
After:  [2, 1, 1, 1]

Before: [1, 0, 2, 3]
0 0 1 0
After:  [1, 0, 2, 3]

Before: [2, 1, 1, 1]
15 2 3 2
After:  [2, 1, 0, 1]

Before: [0, 0, 1, 1]
15 2 3 3
After:  [0, 0, 1, 0]

Before: [1, 1, 3, 3]
13 3 1 2
After:  [1, 1, 0, 3]

Before: [0, 0, 0, 3]
2 0 0 2
After:  [0, 0, 0, 3]

Before: [1, 0, 1, 3]
8 2 0 0
After:  [2, 0, 1, 3]

Before: [3, 0, 0, 3]
3 0 3 0
After:  [1, 0, 0, 3]

Before: [0, 1, 3, 3]
6 1 2 3
After:  [0, 1, 3, 0]

Before: [1, 1, 1, 2]
10 2 1 1
After:  [1, 2, 1, 2]

Before: [1, 2, 2, 1]
13 2 2 0
After:  [1, 2, 2, 1]

Before: [2, 1, 0, 3]
9 1 0 0
After:  [0, 1, 0, 3]

Before: [3, 3, 2, 1]
5 3 1 2
After:  [3, 3, 1, 1]

Before: [3, 3, 3, 1]
5 3 1 2
After:  [3, 3, 1, 1]

Before: [2, 1, 0, 0]
9 1 0 0
After:  [0, 1, 0, 0]

Before: [0, 0, 2, 0]
13 0 0 2
After:  [0, 0, 1, 0]

Before: [2, 1, 3, 2]
6 1 2 1
After:  [2, 0, 3, 2]

Before: [2, 1, 3, 2]
11 0 3 2
After:  [2, 1, 1, 2]

Before: [0, 1, 2, 0]
13 2 2 2
After:  [0, 1, 1, 0]

Before: [0, 1, 0, 1]
15 3 3 2
After:  [0, 1, 0, 1]

Before: [2, 2, 3, 1]
7 2 3 3
After:  [2, 2, 3, 0]

Before: [0, 3, 3, 1]
5 3 1 2
After:  [0, 3, 1, 1]

Before: [0, 1, 0, 0]
0 1 0 2
After:  [0, 1, 1, 0]

Before: [1, 0, 2, 2]
0 0 1 0
After:  [1, 0, 2, 2]

Before: [1, 1, 1, 1]
10 2 1 2
After:  [1, 1, 2, 1]

Before: [0, 1, 3, 3]
0 1 0 3
After:  [0, 1, 3, 1]

Before: [2, 3, 1, 1]
8 2 3 3
After:  [2, 3, 1, 2]

Before: [0, 0, 2, 1]
2 0 0 2
After:  [0, 0, 0, 1]

Before: [2, 1, 3, 0]
9 1 0 3
After:  [2, 1, 3, 0]

Before: [1, 3, 3, 1]
5 3 1 0
After:  [1, 3, 3, 1]

Before: [2, 1, 1, 1]
10 2 1 0
After:  [2, 1, 1, 1]

Before: [1, 3, 1, 3]
8 2 0 0
After:  [2, 3, 1, 3]

Before: [1, 1, 1, 0]
8 2 0 3
After:  [1, 1, 1, 2]

Before: [1, 0, 3, 3]
3 2 3 2
After:  [1, 0, 1, 3]

Before: [2, 1, 3, 3]
12 1 3 1
After:  [2, 0, 3, 3]

Before: [2, 2, 2, 0]
7 2 0 3
After:  [2, 2, 2, 1]

Before: [0, 0, 1, 1]
8 2 3 1
After:  [0, 2, 1, 1]



1 2 1 0
9 1 0 2
10 2 3 2
1 1 2 3
15 0 3 3
9 3 2 3
9 3 3 3
8 3 1 1
14 1 1 0
1 2 2 3
1 0 1 1
1 0 2 2
13 2 3 1
9 1 1 1
8 0 1 0
14 0 1 1
1 0 3 3
1 2 3 0
1 2 0 2
5 0 3 0
9 0 2 0
8 0 1 1
1 1 1 0
1 1 1 2
8 0 0 3
9 3 3 3
9 3 2 3
8 1 3 1
14 1 3 3
1 2 1 1
1 2 2 0
1 3 2 2
3 0 2 0
9 0 2 0
9 0 3 0
8 3 0 3
14 3 1 2
1 2 1 0
1 0 0 1
1 0 0 3
5 0 3 1
9 1 1 1
8 1 2 2
1 3 0 1
1 1 0 3
15 0 3 1
9 1 3 1
8 1 2 2
14 2 0 1
1 2 2 2
9 3 0 3
10 3 2 3
1 1 1 0
5 2 3 0
9 0 3 0
8 1 0 1
1 0 1 2
1 3 2 0
13 2 3 0
9 0 1 0
9 0 1 0
8 0 1 1
14 1 3 2
1 0 1 1
1 2 3 0
11 0 3 0
9 0 2 0
9 0 1 0
8 2 0 2
14 2 3 1
1 1 0 2
1 3 1 3
9 0 0 0
10 0 2 0
4 3 0 2
9 2 3 2
8 1 2 1
14 1 3 2
1 1 1 1
1 3 1 0
1 1 0 3
8 3 3 3
9 3 3 3
8 3 2 2
14 2 1 1
1 2 0 2
1 1 0 0
9 1 0 3
10 3 0 3
12 3 2 3
9 3 3 3
8 3 1 1
14 1 1 2
1 0 3 1
1 2 3 3
1 2 3 0
5 0 3 1
9 1 2 1
9 1 3 1
8 2 1 2
1 2 0 1
1 1 2 0
5 1 3 3
9 3 2 3
9 3 3 3
8 2 3 2
14 2 2 1
1 3 1 2
1 1 1 3
1 2 1 0
3 0 2 3
9 3 1 3
8 1 3 1
14 1 2 0
1 0 0 3
9 2 0 1
10 1 2 1
1 0 1 2
5 1 3 1
9 1 2 1
8 1 0 0
14 0 1 2
1 1 1 1
1 3 3 0
1 2 0 3
4 0 3 3
9 3 3 3
8 2 3 2
1 2 2 1
1 1 1 3
9 2 0 0
10 0 2 0
15 0 3 0
9 0 2 0
9 0 1 0
8 0 2 2
14 2 1 3
1 3 3 1
1 2 0 2
9 0 0 0
10 0 1 0
14 0 2 2
9 2 1 2
8 2 3 3
9 1 0 2
10 2 0 2
10 0 1 2
9 2 1 2
9 2 3 2
8 3 2 3
14 3 3 2
1 2 0 0
1 1 3 1
1 3 2 3
2 1 0 3
9 3 3 3
8 2 3 2
14 2 1 0
1 1 0 2
1 3 1 1
9 1 0 3
10 3 1 3
6 1 2 3
9 3 3 3
8 0 3 0
14 0 2 2
9 2 0 3
10 3 1 3
1 1 1 0
10 0 1 1
9 1 2 1
9 1 1 1
8 2 1 2
14 2 3 1
1 2 0 3
1 2 0 2
2 0 3 0
9 0 3 0
8 1 0 1
14 1 3 0
1 1 0 3
1 1 3 1
1 3 0 2
9 3 2 2
9 2 1 2
9 2 2 2
8 2 0 0
14 0 3 1
1 1 2 2
9 2 0 0
10 0 1 0
8 0 0 2
9 2 3 2
8 1 2 1
14 1 0 0
1 2 0 3
1 3 3 1
1 3 1 2
1 2 1 1
9 1 3 1
8 0 1 0
9 0 0 3
10 3 1 3
9 0 0 1
10 1 3 1
10 3 1 1
9 1 1 1
8 1 0 0
14 0 3 1
1 0 2 2
9 0 0 0
10 0 3 0
6 0 2 0
9 0 3 0
8 1 0 1
14 1 2 2
1 2 3 1
1 3 2 0
0 1 0 1
9 1 2 1
8 1 2 2
14 2 0 3
1 0 2 2
9 0 0 1
10 1 3 1
1 1 3 0
1 2 1 0
9 0 1 0
9 0 2 0
8 0 3 3
14 3 0 2
1 1 3 1
9 3 0 3
10 3 2 3
1 1 3 0
2 0 3 3
9 3 1 3
8 2 3 2
1 2 3 3
9 3 0 1
10 1 2 1
2 0 3 1
9 1 2 1
8 1 2 2
1 3 2 0
1 2 1 1
0 1 0 1
9 1 2 1
9 1 3 1
8 1 2 2
14 2 1 0
1 0 2 1
1 1 2 2
1 3 2 3
6 3 2 1
9 1 2 1
8 0 1 0
14 0 0 1
9 0 0 0
10 0 2 0
1 0 3 3
5 0 3 3
9 3 2 3
9 3 2 3
8 1 3 1
9 2 0 0
10 0 3 0
9 0 0 2
10 2 2 2
1 0 2 3
7 2 0 2
9 2 1 2
8 1 2 1
1 1 3 0
1 2 3 2
12 3 2 0
9 0 3 0
9 0 1 0
8 1 0 1
14 1 3 2
1 3 1 1
1 1 1 0
1 3 3 3
10 0 1 0
9 0 1 0
8 0 2 2
1 0 2 1
1 2 0 0
4 3 0 0
9 0 3 0
8 2 0 2
9 3 0 0
10 0 2 0
1 2 2 3
11 0 3 1
9 1 3 1
8 2 1 2
1 2 3 1
1 3 1 0
5 1 3 3
9 3 3 3
8 2 3 2
14 2 1 3
1 1 2 2
1 1 0 0
8 0 0 0
9 0 2 0
8 0 3 3
14 3 3 1
9 2 0 0
10 0 1 0
1 0 3 2
9 0 0 3
10 3 2 3
8 0 0 0
9 0 1 0
8 1 0 1
14 1 2 0
1 2 0 2
1 0 3 3
1 1 3 1
12 3 2 2
9 2 2 2
8 2 0 0
14 0 1 1
1 3 0 3
1 1 2 2
1 3 0 0
1 2 0 2
9 2 2 2
8 2 1 1
1 2 3 0
1 3 0 2
3 0 2 0
9 0 1 0
8 1 0 1
9 1 0 3
10 3 1 3
1 0 0 2
1 2 1 0
2 3 0 0
9 0 1 0
8 1 0 1
14 1 2 2
9 1 0 1
10 1 3 1
1 3 1 3
1 1 3 0
8 0 0 3
9 3 3 3
9 3 1 3
8 3 2 2
14 2 1 0
1 2 2 2
1 0 1 3
5 2 3 3
9 3 2 3
9 3 3 3
8 0 3 0
14 0 0 2
1 3 1 3
9 3 0 0
10 0 2 0
1 2 0 1
4 3 0 0
9 0 3 0
8 2 0 2
14 2 0 1
1 3 3 0
9 0 0 3
10 3 2 3
1 0 1 2
3 2 0 2
9 2 1 2
8 1 2 1
14 1 0 0
1 1 2 1
9 3 0 2
10 2 3 2
2 1 3 1
9 1 2 1
8 1 0 0
14 0 2 1
1 2 3 0
1 0 3 2
11 0 3 2
9 2 3 2
9 2 3 2
8 1 2 1
1 0 2 0
1 0 1 3
1 2 3 2
5 2 3 2
9 2 1 2
8 2 1 1
14 1 2 2
1 1 0 3
1 2 2 0
1 2 2 1
2 3 0 0
9 0 1 0
8 2 0 2
14 2 2 0
1 0 3 3
1 3 0 2
9 3 0 1
10 1 0 1
13 3 2 3
9 3 1 3
8 3 0 0
9 1 0 3
10 3 3 3
1 3 1 1
1 2 1 2
7 2 1 3
9 3 3 3
8 0 3 0
14 0 0 3
9 1 0 0
10 0 2 0
1 0 1 1
9 1 0 2
10 2 3 2
3 0 2 1
9 1 2 1
9 1 1 1
8 3 1 3
1 3 2 0
9 2 0 1
10 1 2 1
4 0 1 0
9 0 2 0
8 0 3 3
1 1 0 1
1 2 1 0
1 0 1 2
9 1 2 0
9 0 1 0
8 3 0 3
14 3 0 2
1 1 2 3
1 2 3 0
1 3 1 1
2 3 0 0
9 0 3 0
8 0 2 2
14 2 1 3
9 3 0 2
10 2 2 2
9 0 0 1
10 1 1 1
1 1 0 0
14 0 2 0
9 0 3 0
8 0 3 3
14 3 2 2
1 0 2 1
1 3 0 0
1 2 3 3
4 0 3 1
9 1 3 1
8 2 1 2
14 2 1 1
1 1 0 0
9 0 0 2
10 2 3 2
1 2 0 2
9 2 2 2
8 2 1 1
14 1 1 2
9 0 0 0
10 0 0 0
1 3 3 1
4 1 3 3
9 3 2 3
8 3 2 2
14 2 2 1
9 0 0 2
10 2 1 2
1 3 1 0
1 0 3 3
6 0 2 0
9 0 1 0
8 1 0 1
9 2 0 0
10 0 3 0
1 3 2 2
1 2 2 3
4 0 3 0
9 0 3 0
8 0 1 1
14 1 3 2
1 0 3 1
1 1 0 3
1 1 0 0
10 0 1 0
9 0 2 0
8 0 2 2
1 2 3 0
1 2 1 3
1 3 2 1
11 0 3 1
9 1 3 1
8 1 2 2
14 2 0 0
1 0 3 2
1 1 1 1
2 1 3 1
9 1 2 1
8 1 0 0
14 0 1 1
1 1 3 3
1 1 3 0
9 3 2 2
9 2 2 2
8 1 2 1
14 1 1 0
1 1 0 2
1 3 0 1
10 3 1 3
9 3 1 3
9 3 2 3
8 0 3 0
14 0 2 2
1 1 1 0
1 3 3 3
1 0 1 1
10 0 1 3
9 3 2 3
9 3 1 3
8 3 2 2
14 2 2 1
1 3 2 2
1 1 3 3
8 0 0 3
9 3 1 3
8 3 1 1
14 1 1 0
1 0 0 2
1 1 3 3
1 0 1 1
8 3 3 2
9 2 2 2
9 2 2 2
8 2 0 0
14 0 2 2
1 1 0 0
10 0 1 1
9 1 3 1
8 1 2 2
14 2 2 0
1 1 0 1
1 3 0 3
1 3 2 2
9 1 2 2
9 2 1 2
8 2 0 0
14 0 1 1
9 1 0 2
10 2 0 2
1 2 1 3
1 2 1 0
11 0 3 0
9 0 3 0
9 0 3 0
8 0 1 1
14 1 0 2
1 1 0 3
1 0 2 1
1 2 1 0
15 0 3 1
9 1 1 1
8 2 1 2
14 2 1 0
9 2 0 1
10 1 1 1
1 2 3 2
9 3 0 3
10 3 0 3
5 2 3 1
9 1 2 1
8 1 0 0
14 0 1 1
1 3 0 3
1 0 1 2
1 2 3 0
4 3 0 0
9 0 3 0
9 0 3 0
8 0 1 1
1 3 1 2
1 2 1 0
1 2 1 3
11 0 3 3
9 3 3 3
8 3 1 1
14 1 1 0
1 0 1 3
1 3 0 1
6 1 2 2
9 2 1 2
8 2 0 0
14 0 3 1
1 3 3 3
1 2 2 0
1 1 1 2
6 3 2 2
9 2 1 2
8 1 2 1
1 2 0 2
1 1 3 0
14 0 2 2
9 2 3 2
8 2 1 1
14 1 2 3
9 2 0 0
10 0 2 0
1 3 3 1
1 2 2 2
7 0 1 0
9 0 2 0
8 3 0 3
14 3 2 2
1 1 3 3
1 1 0 1
1 3 2 0
8 1 3 0
9 0 2 0
8 0 2 2
14 2 0 0
1 0 3 3
1 2 2 2
1 3 1 1
7 2 1 2
9 2 3 2
8 0 2 0
14 0 0 1
9 3 0 0
10 0 3 0
9 0 0 2
10 2 0 2
1 2 1 3
4 0 3 2
9 2 1 2
9 2 1 2
8 1 2 1
14 1 2 0
1 1 3 2
9 1 0 1
10 1 1 1
1 0 2 3
1 3 1 2
9 2 3 2
8 2 0 0
14 0 3 3
1 3 3 0
9 2 0 1
10 1 0 1
1 2 3 2
7 2 0 2
9 2 1 2
8 3 2 3
14 3 3 1
1 1 0 2
1 1 1 3
1 1 0 0
8 0 3 0
9 0 3 0
9 0 3 0
8 1 0 1
1 2 1 2
1 3 2 0
1 2 3 3
4 0 3 3
9 3 3 3
8 1 3 1
1 1 0 3
9 0 0 0
10 0 2 0
2 3 0 2
9 2 1 2
8 1 2 1
14 1 3 3
1 2 3 2
9 3 0 1
10 1 1 1
2 1 0 2
9 2 2 2
8 2 3 3
14 3 3 2
9 0 0 1
10 1 2 1
1 2 3 3
9 3 0 0
10 0 0 0
5 1 3 0
9 0 2 0
8 2 0 2
14 2 3 0
1 3 1 3
1 1 2 2
1 3 0 1
6 3 2 2
9 2 3 2
9 2 2 2
8 2 0 0
14 0 1 1
1 1 0 0
1 2 2 2
1 1 0 3
14 0 2 2
9 2 3 2
8 2 1 1
1 0 2 3
1 2 3 2
1 2 3 0
12 3 2 2
9 2 1 2
9 2 2 2
8 2 1 1
1 3 3 2
3 0 2 2
9 2 1 2
8 2 1 1
14 1 1 3
1 3 2 0
1 0 1 2
9 2 0 1
10 1 1 1
3 2 0 2
9 2 2 2
9 2 2 2
8 3 2 3
14 3 3 1
1 2 3 3
1 2 2 0
1 1 2 2
11 0 3 0
9 0 3 0
9 0 1 0
8 1 0 1
14 1 3 3
1 0 0 1
1 2 3 2
1 1 2 0
14 0 2 0
9 0 1 0
8 0 3 3
14 3 3 1
1 1 0 0
1 0 1 2
1 3 2 3
6 3 2 2
9 2 2 2
9 2 1 2
8 1 2 1
1 1 1 2
1 2 0 3
1 2 1 0
11 0 3 3
9 3 3 3
8 1 3 1
1 1 2 0
1 2 3 2
1 3 2 3
14 0 2 3
9 3 3 3
8 1 3 1
14 1 1 2
1 2 1 3
1 0 1 1
10 0 1 3
9 3 3 3
8 2 3 2
1 1 3 3
8 3 3 3
9 3 3 3
8 2 3 2
14 2 2 3
1 0 3 2
1 1 2 1
9 1 2 1
9 1 3 1
8 1 3 3
14 3 3 0
1 2 1 3
1 2 2 1
1 3 0 2
0 1 2 1
9 1 3 1
8 0 1 0
14 0 1 2
1 2 1 0
1 1 2 1
11 0 3 3
9 3 3 3
8 2 3 2
14 2 2 1
1 0 3 2
9 1 0 3
10 3 2 3
13 2 3 2
9 2 3 2
8 1 2 1
14 1 1 2
9 1 0 1
10 1 1 1
1 1 1 3
15 0 3 1
9 1 1 1
8 2 1 2
14 2 2 1
9 3 0 3
10 3 2 3
9 0 0 2
10 2 3 2
0 0 2 3
9 3 2 3
8 1 3 1
14 1 2 2
1 3 3 1
1 1 2 3
1 1 3 0
10 3 1 0
9 0 1 0
9 0 1 0
8 0 2 2
1 2 3 1
9 1 0 0
10 0 3 0
1 3 2 3
0 1 0 1
9 1 3 1
8 2 1 2
14 2 2 3
1 3 1 1
1 3 2 2
1 2 2 0
7 0 1 1
9 1 2 1
9 1 2 1
8 3 1 3
14 3 0 1
1 1 3 2
1 0 2 3
1 3 0 0
6 0 2 3
9 3 1 3
9 3 1 3
8 1 3 1
14 1 1 3
1 3 3 1
1 2 3 0
4 1 0 1
9 1 2 1
8 1 3 3
14 3 0 2
1 1 2 3
9 3 0 1
10 1 0 1
15 0 3 3
9 3 2 3
9 3 3 3
8 3 2 2
14 2 1 0
1 1 3 3
1 2 2 2
1 3 0 1
10 3 1 1
9 1 3 1
9 1 2 1
8 1 0 0
14 0 2 1
1 1 3 0
1 3 0 2
9 2 3 2
8 1 2 1
14 1 3 0
1 3 3 1
1 0 2 3
1 3 1 2
6 1 2 1
9 1 2 1
8 1 0 0
14 0 3 3
1 3 0 1
1 1 1 0
9 0 2 2
9 2 3 2
8 2 3 3
14 3 3 1
1 2 1 0
1 0 1 2
1 3 0 3
6 3 2 2
9 2 1 2
8 1 2 1
14 1 1 0
"""

}
