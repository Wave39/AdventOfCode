//
//  Puzzle_2022_23.swift
//  AdventOfCode
//
//  Created by Brian Prescott on 12/8/22.
//  Copyright © 2022 Wave 39 LLC. All rights reserved.
//

import Foundation

public class Puzzle_2022_23: PuzzleBaseClass {
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

    private func solvePart1(str: String) -> Int {
        let buffer = 10
        var lines = str.parseIntoStringArray()
        let width = lines[0].count
        var bufferString = String(repeating: ".", count: buffer)
        for idx in 0..<lines.count {
            lines[idx] = bufferString + lines[idx] + bufferString
        }

        bufferString = String(repeating: ".", count: width + 2 * buffer)
        for _ in 1...buffer {
            lines.insert(bufferString, at: 0)
            lines.append(bufferString)
        }

        var grid = lines.joined(separator: "\n").parseIntoCharacterMatrix()

        for idx in 0..<10 {
            let elves = grid.findInstancesOf("#")
            var desiredDestinations: [Point2D: Int] = [:]
            var elfMoves: [(Point2D, Point2D)] = []
            for elf in elves {
                let adjacent = grid.adjacentGridCells(origin: elf, includeDiagonals: true)
                let elfCount = adjacent.map { $0.1 }.filter { $0 == "#" }.count
                if elfCount > 0 {
                    var direction: CompassDirection?
                    for directionIdx in idx..<(idx + 4) {
                        switch directionIdx % 4 {
                        case 0:
                            if direction == nil && adjacent[0].1 == "." && adjacent[4].1 == "." && adjacent[5].1 == "." {
                                direction = .North
                            }
                        case 1:
                            if direction == nil && adjacent[3].1 == "." && adjacent[6].1 == "." && adjacent[7].1 == "." {
                                direction = .South
                            }
                        case 2:
                            if direction == nil && adjacent[1].1 == "." && adjacent[4].1 == "." && adjacent[6].1 == "." {
                                direction = .West
                            }
                        case 3:
                            if direction == nil && adjacent[2].1 == "." && adjacent[5].1 == "." && adjacent[7].1 == "." {
                                direction = .East
                            }
                        default:
                            print("Something bad happened")
                        }
                    }

                    if let direction {
                        let newLocation = grid.getDirectionalPoint(point: elf, direction: direction)
                        desiredDestinations[newLocation, default: 0] += 1
                        elfMoves.append((elf, newLocation))
                    }
                }
            }

            for elfMove in elfMoves {
                if desiredDestinations[elfMove.1] == 1 {
                    grid[elfMove.0.y][elfMove.0.x] = "."
                    grid[elfMove.1.y][elfMove.1.x] = "#"
                }
            }
        }

        let elves = grid.findInstancesOf("#")
        let x1 = elves.map { $0.x }.min() ?? 0
        let x2 = elves.map { $0.x }.max() ?? 0
        let y1 = elves.map { $0.y }.min() ?? 0
        let y2 = elves.map { $0.y }.max() ?? 0
        let openSpaces = grid.findInstancesOf(".").filter { $0.x >= x1 && $0.x <= x2 && $0.y >= y1 && $0.y <= y2 }

        return openSpaces.count
    }

    private func solvePart2(str: String) -> Int {
        let buffer = 60  // I just kept bumping this up by 10 until the playground was big enough to handle the expansion
        var lines = str.parseIntoStringArray()
        let width = lines[0].count
        var bufferString = String(repeating: ".", count: buffer)
        for idx in 0..<lines.count {
            lines[idx] = bufferString + lines[idx] + bufferString
        }

        bufferString = String(repeating: ".", count: width + 2 * buffer)
        for _ in 1...buffer {
            lines.insert(bufferString, at: 0)
            lines.append(bufferString)
        }

        var grid = lines.joined(separator: "\n").parseIntoCharacterMatrix()

        var idx = 0
        while true {
            let elves = grid.findInstancesOf("#")
            var desiredDestinations: [Point2D: Int] = [:]
            var elfMoves: [(Point2D, Point2D)] = []
            for elf in elves {
                let adjacent = grid.adjacentGridCells(origin: elf, includeDiagonals: true)
                let elfCount = adjacent.map { $0.1 }.filter { $0 == "#" }.count
                if elfCount > 0 {
                    var direction: CompassDirection?
                    for directionIdx in idx..<(idx + 4) {
                        switch directionIdx % 4 {
                        case 0:
                            if direction == nil && adjacent[0].1 == "." && adjacent[4].1 == "." && adjacent[5].1 == "." {
                                direction = .North
                            }
                        case 1:
                            if direction == nil && adjacent[3].1 == "." && adjacent[6].1 == "." && adjacent[7].1 == "." {
                                direction = .South
                            }
                        case 2:
                            if direction == nil && adjacent[1].1 == "." && adjacent[4].1 == "." && adjacent[6].1 == "." {
                                direction = .West
                            }
                        case 3:
                            if direction == nil && adjacent[2].1 == "." && adjacent[5].1 == "." && adjacent[7].1 == "." {
                                direction = .East
                            }
                        default:
                            print("Something bad happened (switch directionIdx % 4)")
                        }
                    }

                    if let direction {
                        let newLocation = grid.getDirectionalPoint(point: elf, direction: direction)
                        desiredDestinations[newLocation, default: 0] += 1
                        elfMoves.append((elf, newLocation))
                    }
                }
            }

            for elfMove in elfMoves {
                if desiredDestinations[elfMove.1] == 1 {
                    grid[elfMove.0.y][elfMove.0.x] = "."
                    grid[elfMove.1.y][elfMove.1.x] = "#"
                }
            }

            if elfMoves.isEmpty {
                return idx + 1
            }

            idx += 1
        }
    }
}

private class Puzzle_Input: NSObject {
    static let test1 = """
.....
..##.
..#..
.....
..##.
.....
"""

    static let test2 = """
....#..
..###.#
#...#.#
.#...##
#.###..
##.#.##
.#..#..
"""

    static let final = """
####.##.#..#..#...#..#.#..#..#.##.##.####.#..#.#....###.....####..#.#..#
.##.#..#...#...#....#...#..#.##....#.#..#.#..#.####.........#.#....####.
#.#..#.#..#....###..#.#.#.....####.##....#.##...#.##..#..#..#..######.##
.#.##......#.#..#...###..###.#....####..##..####.#..##.###..#..##.##.#.#
#####.####.####.###.###.###..###...#.##......##...###.####.....##.#.##..
.....####.#..###.##.###.###.....###.#.##.#..##..##.#...#.#..#.##.#...#.#
###..#..#..#..#.#..#...#..#.##..#..#.....#....##.########..##.###.#....#
..#....###..##.####.#..#......##.#..####...#.....#..###..###......#.#...
####.....#..##....##...#..##..#.#####..####.####....##.####.#...###...#.
######.....##..#..#...#..###.#.#..#.##..#..#.....########..#....#.#.###.
##...####.###.####.##.###.#..###.#####....##..###......#....###...##...#
....#...#.#.##...#.#.###...##.#.#.#.##.#.##.###.#####.#.####.##.#####.#.
.#.##.####.#.....#.##.##.#......#.#.#.##..#.##.####...#.#..#.#######.#.#
#..#.#..##......#....#..##.#...####.#.#...#....#..####...#.#.##..#.###.#
#.##..#.###..###..##.###..#..###.#....#.#.########..##..#.##.###.##..#.#
.######.#.......#.##....#.###....##.##.#..##.#....#..##...#..#..#.##...#
...#.###..###.######...####.##..###.#...####.######.#.#.##..###.#.#..##.
....##....#...###..#...#.#.#.##.#..###.###...#..#..#.#.#..####...##...##
.##.##.##..#.##......###....#.###.#...#..##.#.#####...############......
.#..#.#..###.####.#..#.##..###.###.##.#.#.#.##.###......#.##..###.#.#.##
#..#....#.##..#.#.##.##.##....##..###.###..####..#.#.....#..#......##.##
#...####...##..#....#.#.#.##.....#.......##...#....#.##....##..##...##.#
####.#.#..#.##.#######.###....###..#....#.##.####..##.#...#.####.#.#.#..
............##..#..#.###...#.#.##....#######..#....#..###.....#.###...#.
##.##..##....####..#######.##.#..#....####....#.###.#.#...###....#.##.#.
.##.#..#.##.###..##.#.#.#..#...##.#...#.##.#...#.###.#...#.##....##.#...
.#.########.##.####.#.#...#....#.###..##.##.#.##.#..#.###......###..#..#
..#.#....#.#.#..##.#..###.#.###.##.##.##..#.#.#..##....#.##.#.....#.###.
..#...#.###..##..###.##..##.#..#....#.###...###...#..#.#.#.#..###.####..
###...#.#..###...##.##.###....#.#......##..............#..##.#####.##.##
###..#.##.#.########.##.####..####...##.#.#.###...##.###.#.####.#.##.###
..##.###.#.#.#.##.#.####....#.####.#.##....###.###.##.##....#..##..##...
##..##.#.#......##..#.######...##..#...#.###..#.#.##...#....#.###.##.#.#
..####...##..#..#.#...#.#.###.##..#.#.#..##.##..#..##.#######...##...##.
....#..#..#.#...##.#.##.####..#..#..#..#...###..#.####.#.##.###.###..#..
.##...#.#.##.##..###.#.#..#.#.#.....##......##.#........#####.#......##.
###.####.#...##...#.#......####.#..#......##.....#..#####...#.###.##.#.#
...##.#..#.#.###....#####..#..###.#..#..#.#..#.#.#.#####.#..####..#..###
.##.##....#.#.#.#..#######..#..#.#..#....#.####...#...#..##..#..#...#.##
#.##.#.....#...#...###.##.##.##.#..#..#.###....##.#.#..##.##.###.##..##.
#.##..#....########.#.#.....##.###.#..##.####.#.##..###.##...#.....#.#.#
#..#..##.#....##...#.....#######.###########.#...####.#...####.#.#...##.
####.#..#..#...##..##.###.#.#.##..##.##.###.####..#.##.#.#....#..#.#.#..
#..#########...##..####..###..##.#..##....#..#.#.#..##.#..#.##.#.###.#.#
#....#..#.##.##.....#####.#.......###..#.#.#...###..#...##.#..##.#..#.##
#...####..#.#...#......#....#.#.#.#.##.....#.#.##..#...#.##........#....
###........#.###..#....##.##......#..##..##...##.#.####...#.#..##..##.#.
.#.#.##.#....##.#.#.#.#.#...##.#...##..#####.##.##.###..##..#.#...##...#
###.####...#......######.###..##..##.....###...#.......#..##.#..#.#.##..
####.#..#.#.##.#####.#.#..#..####..##...#.###.##.##.##..#.###..#.#..###.
#..###..#.#.###.#.#.##.#.##....#..#.#.###.##.#.##..###..#.##.....#..##..
.#..#.##.#####..#.....#....##......#.##.##.##....##.#...#.#.##.#..#..#.#
..#...##...#..####.##..#.##.#.##..#.##.#..####.#.#####......########..##
.##.....##.##.######..#.##..#....#..#####.#.##..##..#.#.#.#..#...##..##.
##.#...###.##..##..#.#....#..#.#.#.#.##.#..#..#.#####.##.#####..##.#.#..
#.####.#..##..##...##..##.#.#......#.#####.#..####..#..########.##.###..
#.##.##.#.##...#..#..#.#...#.##.##..##......##.#####..##.#.#.#.##.##.#.#
..#....##....#..###.#####....##.#######..##..#####...#...#####.###.....#
#.#.##..####.##.#......###..##.####.#...####.#..#.#.##.#..#.###.##.#####
.##..####...###...#.##.#..#.##.######.#.##...#.##...##..##.##########...
#.##.####..######...###.##.###.####.#.#..#..#.#.#..##....#......##....#.
.###......##.##.####.#...##...#..#.#..####..#.#.##.###.#.....#.#....#.#.
#..#..#.####.#.#.#..##..#..##.##..#.#..##.#########.###.######......#.##
..#.#.#.#..#######...#.#.....######.#.#.##.#..#...#..#####..##.###.#.##.
..#.#.#..##...####.#.###.##..#.#.##.#.#....##.#####.####...##..####....#
....#.##.....##...#.##.#.###..#.#...#####....##.###..#..########.....#..
#.#.#..#.#...###...##...#..#.##..#.#..#.....###.#####.##...#.#.#...##.#.
..#.#####..##....##...##.#.##.#..#..##.#...#.##..###..#.##...#..##..##..
#.###..##.#...####....###........#...###.#..##.#......###..####.#......#
#..#.#.#....#...##.##.....#..##..#.####.##.....##.#.....#.#.#....##....#
########.#.##.#..##..#...####.#.###.#.#.#.##.#.######.##.#.##....####..#
###.#...##.###.##....#..##.##..#######..###.###...#..###.##...#...#..##.
"""
}
