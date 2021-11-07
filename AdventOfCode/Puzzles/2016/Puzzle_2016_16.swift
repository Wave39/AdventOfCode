//
//  Puzzle_2016_16.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 2/14/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

class Puzzle_2016_16: PuzzleBaseClass {
    func solve() {
        let (part1, part2) = solveBothParts()
        print("Part 1 solution: \(part1)")
        print("Part 2 solution: \(part2)")
    }

    func solveBothParts() -> (String, String) {
        func arrayDescription(arr: [Int]) -> String {
            var s = ""
            for i in arr {
                s += "\(i)"
            }

            return s
        }

        func createFillData(data: [Int]) -> [Int] {
            let a = data
            let b = data.reversed()
            let b1 = b.map { ($0 == 1 ? 2 : $0) }
            let b2 = b1.map { ($0 == 0 ? 1 : $0) }
            let b3 = b2.map { ($0 == 2 ? 0 : $0) }
            let c = a + [ 0 ] + b3
            return c
        }

        func createDiscState(initialData: [Int], size: Int) -> [Int] {
            var d = initialData
            while d.count < size {
                d = createFillData(data: d)
            }

            if d.count > size {
                var d2: [Int] = []
                for idx in 0..<size {
                    d2.append(d[idx])
                }

                return d2
            }

            return d
        }

        func generateChecksum(data: [Int]) -> [Int] {
            var d = data
            var dCount = d.count
            while dCount.isMultiple(of: 2) {
                var s2: [Int]  = []
                for idx in stride(from: 0, to: dCount - 1, by: 2) {
                    if d[idx] == d[idx + 1] {
                        s2.append(1)
                    } else {
                        s2.append(0)
                    }
                }

                d = s2
                dCount = d.count
            }

            return d
        }

        func processInput(input: [Int], length: Int) -> String {
            let discData = createDiscState(initialData: input, size: length)
            let checksum = generateChecksum(data: discData)
            return arrayDescription(arr: checksum)
        }

        let part1Input = [1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0 ]
        let part1Length = 272
        let part1Solution = processInput(input: part1Input, length: part1Length)

        let part2Input = part1Input
        let part2Length = 35_651_584
        let part2Solution = processInput(input: part2Input, length: part2Length)

        return (part1Solution, part2Solution)
    }
}
