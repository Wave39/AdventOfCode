//
//  Puzzle_2015_24.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 3/1/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2015_24 : PuzzleBaseClass {

    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    func solveBothParts() -> (Int, Int) {
        var solution: Array<Set<Int>> = []

        func getSubsets(superSet: Array<Int>, k: Int, idx: Int, current: inout Set<Int>) {
            // courtesy of http://stackoverflow.com/questions/12548312/find-all-subsets-of-length-k-in-an-array
            if (current.count == k) {
                solution.append(current);
                return
            }

            if (idx == superSet.count) {
                return
            }
            
            let x = superSet[idx]
            current.insert(x);
            getSubsets(superSet: superSet, k: k, idx: idx+1, current: &current);
            current.remove(x);
            getSubsets(superSet: superSet, k: k, idx: idx+1, current: &current);
        }

        func getAllSubsets(superSet: Array<Int>, subsetLength: Int) {
            solution = []
            var newSet: Set<Int> = Set()
            getSubsets(superSet: superSet, k: subsetLength, idx: 0, current: &newSet);
        }

        let puzzleInputString = "1 3 5 11 13 17 19 23 29 31 37 41 43 47 53 59 67 71 73 79 83 89 97 101 103 107 109 113"

        var puzzleInputArray = puzzleInputString.split {$0 == " "}.map { Int(String($0)) ?? 0 }
        let sortedArray = puzzleInputArray.sorted()

        let totalWeight = sortedArray.reduce(0, +)
        let part1TargetWeight = totalWeight / 3
        let part2TargetWeight = totalWeight / 4

        func findLowestQuantumEntanglement(targetWeight: Int) -> Int {
            var lengthToCheck = 2
            var foundASolution = false
            var lowestQuantumEntanglement = Int.max
            while !foundASolution {
                getAllSubsets(superSet: sortedArray, subsetLength: lengthToCheck)
                var validSolutions: Array<Set<Int>> = []
                for subset in solution {
                    let weight = subset.reduce(0, +)
                    if weight == targetWeight {
                        foundASolution = true
                        validSolutions.append(subset)
                    }
                }
                
                if foundASolution {
                    for subset in validSolutions {
                        let qe = subset.reduce(1, *)
                        if qe < lowestQuantumEntanglement {
                            lowestQuantumEntanglement = qe
                        }
                    }
                }
                
                lengthToCheck += 1
            }
            
            return lowestQuantumEntanglement
        }

        let part1LowestQuantumEntanglement = findLowestQuantumEntanglement(targetWeight: part1TargetWeight)
        let part2LowestQuantumEntanglement = findLowestQuantumEntanglement(targetWeight: part2TargetWeight)
        return (part1LowestQuantumEntanglement, part2LowestQuantumEntanglement)
    }
    
}
