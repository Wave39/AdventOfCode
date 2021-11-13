//
//  Puzzle_2018_11.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 1/1/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2018_11: NSObject {
    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")
        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1() -> (Int, Int) {
        let puzzleInput = Puzzle_2018_11_Input.puzzleInput

        var powerGrid: [[Int]] = []
        for y in 0..<300 {
            var powerGridRow: [Int] = []
            for x in 0..<300 {
                powerGridRow.append(fuelCellPowerLevel(x: x, y: y, serialNumber: puzzleInput))
            }

            powerGrid.append(powerGridRow)
        }

        var powerGridSums = Array(repeating: Array(repeating: 0, count: 301), count: 301)
        for x in 1..<301 {
            for y in 1..<301 {
                powerGridSums[x][y] = fuelCellPowerLevel(x: x, y: y, serialNumber: puzzleInput) + powerGridSums[x][y - 1] + powerGridSums[x - 1][y] - powerGridSums[x - 1][y - 1]
            }
        }

        return solvePart1(powerGrid: powerGrid)
    }

    public func solvePart2() -> (Int, Int, Int) {
        let puzzleInput = Puzzle_2018_11_Input.puzzleInput

        var powerGrid: [[Int]] = []
        for y in 0..<300 {
            var powerGridRow: [Int] = []
            for x in 0..<300 {
                powerGridRow.append(fuelCellPowerLevel(x: x, y: y, serialNumber: puzzleInput))
            }

            powerGrid.append(powerGridRow)
        }

        var powerGridSums = Array(repeating: Array(repeating: 0, count: 301), count: 301)
        for x in 1..<301 {
            for y in 1..<301 {
                powerGridSums[x][y] = fuelCellPowerLevel(x: x, y: y, serialNumber: puzzleInput) + powerGridSums[x][y - 1] + powerGridSums[x - 1][y] - powerGridSums[x - 1][y - 1]
            }
        }

        return solvePart2(powerGridSums: powerGridSums)
    }

    private func fuelCellPowerLevel(x: Int, y: Int, serialNumber: Int) -> Int {
        // Find the fuel cell's rack ID, which is its X coordinate plus 10.
        let rackID = x + 10
        // Begin with a power level of the rack ID times the Y coordinate.
        var powerLevel = rackID * y
        // Increase the power level by the value of the grid serial number (your puzzle input).
        powerLevel += serialNumber
        // Set the power level to itself multiplied by the rack ID.
        powerLevel *= rackID
        // Keep only the hundreds digit of the power level (so 12345 becomes 3; numbers with no hundreds digit become 0).
        if powerLevel < 100 {
            powerLevel = 0
        } else {
            powerLevel %= 1_000  // strips away all but 0-999
            powerLevel -= (powerLevel % 100) // strips away all but the hundreds
            powerLevel /= 100
        }
        // Subtract 5 from the power level.
        powerLevel -= 5

        return powerLevel
    }

    private func calculatePower(powerGrid: [[Int]], x: Int, y: Int, size: Int) -> Int {
        var power = 0
        for y2 in y...(y + size - 1) {
            for x2 in x...(x + size - 1) {
                power += powerGrid[y2][x2]
            }
        }

        return power
    }

    private func solvePart1(powerGrid: [[Int]]) -> (Int, Int) {
        var maxValue = Int.min, maxX = 0, maxY = 0
        for y in 0..<298 {
            for x in 0..<298 {
                let boxTotal = calculatePower(powerGrid: powerGrid, x: x, y: y, size: 3)
                if boxTotal > maxValue {
                    maxValue = boxTotal
                    maxX = x
                    maxY = y
                }
            }
        }

        return (maxX, maxY)
    }

    private func solvePart2(powerGridSums: [[Int]]) -> (Int, Int, Int) {
        var maxValue = 0, maxX = Int.min, maxY = Int.min, maxSize = Int.min
        for size in 1...300 {
            for x in size...300 {
                for y in size...300 {
                    let boxTotal = powerGridSums[x][y] - powerGridSums[x - size][y] - powerGridSums[x][y - size] + powerGridSums[x - size][y - size]
                    if boxTotal > maxValue {
                        maxValue = boxTotal
                        maxX = x - size + 1
                        maxY = y - size + 1
                        maxSize = size
                    }
                }
            }
        }

        return (maxX, maxY, maxSize)
    }
}

private class Puzzle_2018_11_Input: NSObject {
    static let puzzleInput_test = 42

    static let puzzleInput = 5_093
}
