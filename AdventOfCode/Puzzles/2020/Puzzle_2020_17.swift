//
//  Puzzle_2020_17.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/17/20.
//  Copyright © 2020 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2020_17: PuzzleBaseClass {
    public func solve() {
        let part1 = solvePart1()
        print("Part 1 solution: \(part1)")

        let part2 = solvePart2()
        print("Part 2 solution: \(part2)")
    }

    public func solvePart1() -> Int {
        solvePart1(str: Puzzle_Input.puzzleInput)
    }

    public func solvePart2() -> Int {
        solvePart2(str: Puzzle_Input.puzzleInput)
    }

    private func solvePart1(str: String) -> Int {
        let matrix = str.parseIntoCharacterMatrix()
        var dict: Dictionary<Point3D, Int> = [:]
        for row in 0..<matrix.count {
            for col in 0..<matrix[row].count {
                dict[Point3D(x: col, y: -row, z: 0)] = (matrix[row][col] == "." ? 0 : 1)
            }
        }

        var maxX = matrix[0].count
        var minX = 0
        var maxY = 0
        var minY = -matrix.count
        var maxZ = 0
        var minZ = 0

        for _ in 1...6 {
            maxX += 1
            minX -= 1
            maxY += 1
            minY -= 1
            maxZ += 1
            minZ -= 1
            var newCubes: Dictionary<Point3D, Int> = [:]
            for x in minX...maxX {
                for y in minY...maxY {
                    for z in minZ...maxZ {
                        let location = Point3D(x: x, y: y, z: z)
                        let neighbors = location.adjacentLocationsWithDiagonals()
                        var activeNeighbors = 0
                        for neighbor in neighbors {
                            if dict[neighbor] == 1 {
                                activeNeighbors += 1
                            }
                        }

                        if dict[location] == 1 {
                            if activeNeighbors != 2 && activeNeighbors != 3 {
                                newCubes[location] = 0
                            }
                        } else {
                            if activeNeighbors == 3 {
                                newCubes[location] = 1
                            }
                        }
                    }
                }
            }

            for (key, value) in newCubes {
                dict[key] = value
            }
        }

        var retval = 0
        for (_, value) in dict {
            if value == 1 {
                retval += 1
            }
        }

        return retval
    }

    private func solvePart2(str: String) -> Int {
        let matrix = str.parseIntoCharacterMatrix()
        var dict: Dictionary<Point4D, Int> = [:]
        for row in 0..<matrix.count {
            for col in 0..<matrix[row].count {
                dict[Point4D(x: col, y: -row, z: 0, t: 0)] = (matrix[row][col] == "." ? 0 : 1)
            }
        }

        var maxX = matrix[0].count
        var minX = 0
        var maxY = 0
        var maxT = 0
        var minY = -matrix.count
        var maxZ = 0
        var minZ = 0
        var minT = 0

        for _ in 1...6 {
            maxX += 1
            minX -= 1
            maxY += 1
            minY -= 1
            maxZ += 1
            minZ -= 1
            maxT += 1
            minT -= 1
            var newCubes: Dictionary<Point4D, Int> = [:]
            for x in minX...maxX {
                for y in minY...maxY {
                    for z in minZ...maxZ {
                        for t in minT...maxT {
                            let location = Point4D(x: x, y: y, z: z, t: t)
                            let neighbors = location.adjacentLocationsWithDiagonals()
                            var activeNeighbors = 0
                            for neighbor in neighbors {
                                if dict[neighbor] == 1 {
                                    activeNeighbors += 1
                                }
                            }

                            if dict[location] == 1 {
                                if activeNeighbors != 2 && activeNeighbors != 3 {
                                    newCubes[location] = 0
                                }
                            } else {
                                if activeNeighbors == 3 {
                                    newCubes[location] = 1
                                }
                            }
                        }
                    }
                }
            }

            for (key, value) in newCubes {
                dict[key] = value
            }
        }

        var retval = 0
        for (_, value) in dict {
            if value == 1 {
                retval += 1
            }
        }

        return retval
    }
}

private class Puzzle_Input: NSObject {
    static let puzzleInput_test = """
.#.
..#
###
"""

    static let puzzleInput = """
###...#.
.##.####
.####.##
###.###.
.##.####
#.##..#.
##.####.
.####.#.
"""
}
