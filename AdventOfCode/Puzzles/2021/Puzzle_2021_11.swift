//
//  Puzzle_2021_11.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/6/21.
//  Copyright © 2021 Wave 39 LLC. All rights reserved.
//

// https://adventofcode.com/2021/day/11

import Foundation

public class Puzzle_2021_11: PuzzleBaseClass {
    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1() -> Int {
        solvePart1(str: Puzzle_Input.final)
    }

    public func solvePart2() -> Int {
        solvePart2(str: Puzzle_Input.final)
    }

    private func printMatrix(_ matrix: [[Int]]) {
        let rows = matrix.count
        let columns = matrix[0].count
        for row in 0..<rows {
            var rowString = ""
            for col in 0..<columns {
                rowString += String(matrix[row][col]).padLeft(with: " ", toSize: 3)
            }

            print(rowString)
        }
    }

    private func solvePart1(str: String) -> Int {
        var matrix = str.parseIntoDigitMatrix()
        let rows = matrix.count
        let columns = matrix[0].count
        var totalFlashes = 0
        for _ in 1...100 {
            // increment the energies of all octopi
            var newMatrix = matrix.map { $0.map { $0 + 1 } }

            // check for flashers
            var flashCoordinates: Set<Point2D> = Set()
            var newFlashCoordinates: Set<Point2D> = Set()
            var newFlashes = 0
            repeat {
                newFlashes = 0
                newFlashCoordinates = Set()
                for row in 0..<rows {
                    for col in 0..<columns {
                        let point = Point2D(x: col, y: row)
                        if newMatrix[row][col] > 9 && !flashCoordinates.contains(point) {
                            newFlashes += 1
                            newFlashCoordinates.insert(point)
                            flashCoordinates.insert(point)
                        }
                    }
                }

                for point in newFlashCoordinates {
                    let adjacents = point.adjacentLocationsWithinGrid(rows: rows, columns: columns, includeDiagonals: true)
                    for adjacent in adjacents {
                        newMatrix[adjacent.y][adjacent.x] += 1
                    }
                }

                totalFlashes += newFlashes
            } while newFlashes != 0

            // after all flashing done, reset flashers back to 0 energy
            matrix = newMatrix.map { $0.map { $0 > 9 ? 0 : $0 } }

            // printMatrix(matrix)
        }

        return totalFlashes
    }

    private func solvePart2(str: String) -> Int {
        var matrix = str.parseIntoDigitMatrix()
        let rows = matrix.count
        let columns = matrix[0].count
        var stepFlashes = 0
        var step = 0
        repeat {
            step += 1
            stepFlashes = 0

            // increment the energies of all octopi
            var newMatrix = matrix.map { $0.map { $0 + 1 } }

            // check for flashers
            var flashCoordinates: Set<Point2D> = Set()
            var newFlashCoordinates: Set<Point2D> = Set()
            var newFlashes = 0
            repeat {
                newFlashes = 0
                newFlashCoordinates = Set()
                for row in 0..<rows {
                    for col in 0..<columns {
                        let point = Point2D(x: col, y: row)
                        if newMatrix[row][col] > 9 && !flashCoordinates.contains(point) {
                            newFlashes += 1
                            newFlashCoordinates.insert(point)
                            flashCoordinates.insert(point)
                        }
                    }
                }

                for point in newFlashCoordinates {
                    let adjacents = point.adjacentLocationsWithinGrid(rows: rows, columns: columns, includeDiagonals: true)
                    for adjacent in adjacents {
                        newMatrix[adjacent.y][adjacent.x] += 1
                    }
                }

                stepFlashes += newFlashes
            } while newFlashes != 0

            // after all flashing done, reset flashers back to 0 energy
            matrix = newMatrix.map { $0.map { $0 > 9 ? 0 : $0 } }

            // print("After step \(step), matrix is:")
            // printMatrix(matrix)
        } while stepFlashes < 100

        return step
    }
}

private class Puzzle_Input: NSObject {
    static let test1 = """
11111
19991
19191
19991
11111
"""

    static let test2 = """
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
"""

    static let final = """
4438624262
6263251864
2618812434
2134264565
1815131247
2612457325
8585767584
7217134556
2825456563
8248473584
"""
}
