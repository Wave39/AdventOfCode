//
//  Puzzle_2016_15.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/14/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2016_15: PuzzleBaseClass {

    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }
    
    func solveBothParts() -> (Int, Int) {
        struct DiscState {
            var initialPosition: Int
            var size: Int
            func positionAtTime(time: Int) -> Int {
                return (initialPosition + time) % size
            }
        }

        func solve(discs: [ DiscState ]) -> Int {
            var startingTime = 0
            var foundTime = -1
            while foundTime == -1 {
                var found = true
                for idx in 0..<discs.count {
                    if discs[idx].positionAtTime(time: (startingTime + idx)) != 0 {
                        found = false
                    }
                }
                
                if found {
                    foundTime = startingTime - 1
                }
                
                startingTime += 1
            }
            
            return foundTime
        }

        let part1Input = [ DiscState(initialPosition: 10, size: 13),
                           DiscState(initialPosition: 15, size: 17),
                           DiscState(initialPosition: 17, size: 19),
                           DiscState(initialPosition: 1, size: 7),
                           DiscState(initialPosition: 0, size: 5),
                           DiscState(initialPosition: 1, size: 3)
        ]
        var part2Input = part1Input
        part2Input.append(DiscState(initialPosition: 0, size: 11))

        let part1Solution = solve(discs: part1Input)
        let part2Solution = solve(discs: part2Input)
        return (part1Solution, part2Solution)
    }
}
