//
//  Puzzle_2017_15.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/18/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2017_15: PuzzleBaseClass {
    func solve() {
        let part1Solution = solvePart1()
        print("Part 1 solution: \(part1Solution)")

        let part2Solution = solvePart2()
        print("Part 2 solution: \(part2Solution)")
    }

    func solvePart1() -> Int {
        let puzzleInput = Puzzle_2017_15_Input.puzzleInput

        let puzzleInputMatrix = puzzleInput.parseIntoMatrix()
        let initialGenerators = (puzzleInputMatrix[0][4].int, puzzleInputMatrix[1][4].int)

        return solvePart1(initialGenerators: initialGenerators)
    }

    func solvePart2() -> Int {
        let puzzleInput = Puzzle_2017_15_Input.puzzleInput

        let puzzleInputMatrix = puzzleInput.parseIntoMatrix()
        let initialGenerators = (puzzleInputMatrix[0][4].int, puzzleInputMatrix[1][4].int)

        return solvePart2(initialGenerators: initialGenerators)
    }

    func getNextGenerators(generators: (Int, Int)) -> (Int, Int) {
        let a = (generators.0 * 16_807) % 2_147_483_647
        let b = (generators.1 * 48_271) % 2_147_483_647
        return (a, b)
    }

    func generatorsMatch(generatorA: Int, generatorB: Int) -> Bool {
        let matchA = generatorA & 65_535
        let matchB = generatorB & 65_535
        return matchA == matchB
    }

    func generatorsMatch(generators: (Int, Int)) -> Bool {
        generatorsMatch(generatorA: generators.0, generatorB: generators.1)
    }

    func solvePart1(initialGenerators: (Int, Int)) -> Int {
        let iterations = 40_000_000
        var matchCount = 0
        var generators = initialGenerators

        for _ in 0..<iterations {
            generators = getNextGenerators(generators: generators)
            if generatorsMatch(generators: generators) {
                matchCount += 1
            }
        }

        return matchCount
    }

    func solvePart2(initialGenerators: (Int, Int)) -> Int {
        let iterations = 5_000_000
        var generators = initialGenerators
        var aGenerators: [Int] = []
        var bGenerators: [Int] = []
        while aGenerators.count < iterations || bGenerators.count < iterations {
            generators = getNextGenerators(generators: generators)
            if generators.0.isMultiple(of: 4) {
                aGenerators.append(generators.0)
            }

            if generators.1.isMultiple(of: 8) {
                bGenerators.append(generators.1)
            }
        }

        var matchCount = 0
        for idx in 0..<iterations {
            if generatorsMatch(generatorA: aGenerators[idx], generatorB: bGenerators[idx]) {
                matchCount += 1
            }
        }

        return matchCount
    }
}

private class Puzzle_2017_15_Input: NSObject {
    static let puzzleInput_test1 =

"""
Generator A starts with 65
Generator B starts with 8921
"""

    static let puzzleInput =

"""
Generator A starts with 679
Generator B starts with 771
"""
}
